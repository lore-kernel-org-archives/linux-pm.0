From: Stefan Wahren <info@lategoodbye.de>
Subject: Re: ARM: mx28: cpufreq-cpu0 support?
Date: Thu, 25 Sep 2014 20:24:00 +0200
Message-ID: <54245DC0.8020700@lategoodbye.de>
References: <53F9B4BF.2050802@lategoodbye.de>	<20140825080123.GA12289@dragon>	<53FB1041.5010208@lategoodbye.de>	<CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>	<CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>	<540412A9.4090806@lategoodbye.de>	<CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>	<542093C0.1040004@lategoodbye.de>	<CAOMZO5A0of3_arOx2z0_t7xN37jQjJ5uU4gwcsgCuSdpBJJVzw@mail.gmail.com>	<54232D9C.5070404@lategoodbye.de> <CAOMZO5BN8APenWCsy7uHbYNQ4q0-QxorAdGPKBHOHPcUzp2PYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5BN8APenWCsy7uHbYNQ4q0-QxorAdGPKBHOHPcUzp2PYg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Otavio Salvador <otavio@ossystems.com.br>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

i added linux-pm list.

Am 24.09.2014 23:47, schrieb Fabio Estevam:
> On Wed, Sep 24, 2014 at 5:46 PM, Stefan Wahren <info@lategoodbye.de> wrote:
>
>> thanks, registering cpufreq-cpu0 and adding missing properties reg & clocks
>> did the trick.
>>
>> Now the sys interface of cpufreq is available and the mxs-regulator seems to
>> handle frequency change. But the frequency selection do not work as
>> expected. If i set cpu frequency to 454736, 392727 or 261818 kHz, the
>
> Why 454736 instead of 454MHz? Same for the other values.

I took these values from the cpufreq driver in the Freescale BSP and 
they are in the datasheet, too. If i take 454000 and so one, i will get 
this nice oops:

root@duckbill:~# modprobe cpufreq-cpu0
[   95.764654] cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted 
freq: 454736 KHz
[   95.773146] cpufreq_cpu0: failed to find OPP for 454736842
[   95.778692] cpufreq: __target_index: Failed to change cpu frequency: -34
[   95.786235] ------------[ cut here ]------------
[   95.790913] kernel BUG at drivers/cpufreq/cpufreq.c:1249!
[   95.796342] Internal error: Oops - BUG: 0 [#1] ARM
[   95.801154] Modules linked in: cpufreq_cpu0(+)
[   95.805673] CPU: 0 PID: 446 Comm: modprobe Not tainted 
3.17.0-rc4-00268-ge789d1c-dirty #17
[   95.813965] task: c6fa8980 ti: c6c86000 task.ti: c6c86000
[   95.819409] PC is at cpufreq_add_dev+0x530/0x5b4
[   95.824069] LR is at mark_held_locks+0x74/0x9c
[...]

>
>> cpufreq driver change it silently to 240000 kHz.
>
> 24MHz is the osc clock. It seems you did not turn on the PLL0.
>
> Check the POWER bit of HW_CLKCTRL_PLL0CTRL0 register.
>

240000 kHz = 240 MHz

I fixed this specific problem by setting the clock reference in the DT 
to ref_cpu instead of cpu. After that i'm able to set 392727, 360000, 
261818 and 64000 kHz. Unfortunately the highest and default value 454736 
is not selectable:

[   38.901842] cpu cpu0: Looking up cpu0-supply from device tree
[   38.904082] freq_table: table entry 0: 64000 kHz
[   38.904141] freq_table: table entry 1: 261818 kHz
[   38.904176] freq_table: table entry 2: 360000 kHz
[   38.904206] freq_table: table entry 3: 392727 kHz
[   38.904235] freq_table: table entry 4: 454736 kHz
[   38.908050] freq_table: request for verification of policy (64000 - 
454736 kHz) for cpu 0
[   38.908116] freq_table: verification lead to (64000 - 454736 kHz) for 
cpu 0
[   38.908176] freq_table: request for verification of policy (64000 - 
454736 kHz) for cpu 0
[   38.908220] freq_table: verification lead to tage: vddd register val 30
root@duckbill:/sys/devices/system/cpu/cpu0/cpufreq# echo "454736" > 
scaling_setspeed
[  595.671708] cpufreq_cpu0: failed to find OPP for 454736842
[  595.677272] cpufreq: __target_index: Failed to change cpu frequency: -34

That looks like a bug in cpufreq.

Best regards
Stefan

PS: Here is my relevant DT:

############# imx28.dtsi

[...]

cpus {
	#address-cells = <1>;
	#size-cells = <0>;

	cpu@0 {
		compatible = "arm,arm926ej-s";
		device_type = "cpu";
		reg = <0x0>;
		operating-points = <
			/* kHz	uV */
			454736  1550000
			392727  1475000
			360000  1375000
			261818  1275000
			64000   1050000
		>;
		clocks = <&clks 4>;
		clock-latency = <61036>; /* two CLK32 periods */
		cpu0-supply = <&reg_vddd>;
	};
};

[...]
