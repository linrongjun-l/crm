package cn.euct.vo;

import cn.euct.workbench.domain.Activity;
import org.omg.PortableInterceptor.INACTIVE;

import java.util.List;

public class PagingVo<T> {

    private  Integer total;
    private List<T> dataList;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }
}
