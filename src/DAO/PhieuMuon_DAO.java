/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Model.PhieuMuon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author nguye
 */
public class PhieuMuon_DAO {
    public List<PhieuMuon> getDSPhieuMuon() {
        List<PhieuMuon> pmList = new ArrayList<PhieuMuon>();
        
        Connection connection = KetNoiSQL.getConnection();
        
        String sql = "select maPhieuMuon, TaiKhoan.tenNguoiDung, CanBo.tenCanBo, ngayMuon, soNgayMuon, ghiChu, trangThai from PhieuMuon, TaiKhoan, CanBo where PhieuMuon.maCanBo = CanBo.maCanBo and PhieuMuon.maTaiKhoan = TaiKhoan.maTaiKhoan";
        
        try {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            while (rs.next()) {
                PhieuMuon pm = new PhieuMuon();

                pm.setMaPM(rs.getString("maPhieuMuon"));
                pm.setMaTaiKhoan(rs.getString("tenNguoiDung"));
                pm.setMaCanBo(rs.getString("tenCanBo"));
                pm.setNgayMuon(rs.getString("ngayMuon"));
                pm.setSoNgayMuon(rs.getInt("soNgayMuon"));
                pm.setGhiChu(rs.getString("ghiChu"));
                pm.setTrangThai(rs.getString("trangThai"));
                
                pmList.add(pm);
            }
        } catch (SQLException e) {
        }

        return pmList;
    }
    
    public void addPhieuMuon(PhieuMuon phieuMuon) {
        Connection connection = KetNoiSQL.getConnection();
            String sql = "INSERT INTO PhieuMuon VALUES (?, ?, ?, ?, ?, ?, ?)";
            try {           
                PreparedStatement preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, phieuMuon.getMaPM());
                preparedStatement.setString(2, phieuMuon.getNgayMuon());
                preparedStatement.setString(3, String.valueOf(phieuMuon.getSoNgayMuon()));
                preparedStatement.setString(4, phieuMuon.getMaTaiKhoan());
                preparedStatement.setString(5, phieuMuon.getMaCanBo());
                preparedStatement.setString(6, phieuMuon.getGhiChu());
                preparedStatement.setString(4, phieuMuon.getTrangThai());
                
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
            }
     
    }
    
    public void updatePhieuMuon(PhieuMuon phieuMuon) {
        Connection connection = KetNoiSQL.getConnection();
        String sql = "UPDATE Product SET ghiChu = ?, trangThai = ? WHERE maPhieuMuon = ?";
        try {           
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, phieuMuon.getGhiChu());
            preparedStatement.setString(2, phieuMuon.getTrangThai());
            preparedStatement.setString(3, phieuMuon.getMaPM());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            
        }
    }
}
