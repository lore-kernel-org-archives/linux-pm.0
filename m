From: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: hi3521a syscon-reboot issue, reboot fails oddly.
Date: Sat, 25 Nov 2017 13:02:03 -0600
Message-ID: <20171125190203.24521-1-hanetzer@startmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, linux@armlinux.org.uk, z.liuxinliang@hisilicon.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, zhangshaokun@hisilicon.com, wangzhou1@hisilicon.com, songxiaowei@hisilicon.com, wangbinghui@hisilicon.com, xuejiancheng@huawei.com, zhangfei.gao@linaro.org, "Marty E. Plummer" <hanetzer@startmail.com>
List-Id: linux-pm@vger.kernel.org

Greetings,

Having a slight issue with getting reboot to work on the board I'm tinkering
with; according to the documentation writing any value to 0x12050004 should
reset the system, as such I have the following snippet in my dts to make it
work:

sysctrl: system-controller@12050000 {
	compatible = "hisilicon,hi3521a-sysctrl", "syscon";
	reg = <0x12050000 0x1000>;
	#clock-cells = <1>;
	#reset-cells = <2>;
};

reboot {
	compatible = "syscon-reboot";
	regmap = <&sysctrl>;
	offset = <0x4>;
	mask = <0xdeadbeef>;
};

The above is primarily based on the hi3519.dtsi setup, whose docs indicate
it resets in the same manner.

However, issuing a `reboot' ends up putting the cpu into a wierd state, with
the serial port getting spammed with '0x0a2020202020...0a20202020...' in what
appears to be an infinite amount of time (let it sit in this state overnight,
remaining in this state.

It doesn't make much sense to me, as I can't find anything in the bsp regarding
reset excluding a small bit in linux-3.10.y/arch/arm/mach-hi3521a/core.c:

void hi3521a_restart(char mode, const char *cmd)
{
	writel(~0, __io_address(REG_BASE_SCTL + REG_SC_SYSRES));
}

which effectively does the same thing as syscon-reboot.

This happens whether I reboot via command or by killing the process feeding the
watchdog (procd on lede's initramfs).

Was hoping you guys could perhaps provide some guidance regarding this matter.

Regards,
Marty
-- 
2.15.0
