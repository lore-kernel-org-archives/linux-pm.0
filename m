Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77A37997A;
	Thu, 16 Apr 2026 05:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776319164; cv=none; b=B4D2Oi9GMNlD0wwRZqWAAVLEQogOaYRd9i2dmCa+2FcvNw0rh6EzPbPopYIWpMv2vw2tyaEUm2C2oYneCcPQK90iPZUBR43Y+gV6IJr6+OFbDsjObAMziVq2SysgB/BaclIB4jzXiQnbsWdWoDl1YzAFz6twmVBr7qqQ8ZqwdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776319164; c=relaxed/simple;
	bh=b6GXcjHcPMiBaPIn941JJJDw3UCq6GnTG0tuVxP2agU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=NfSmw3BqExVMiM9X8yHIC8fALDv1BE6HDTLqf3u1eeyfvi5Em2Be7tx9UIH1wYLbL1lRJPFn0PFEcAJohDIcv/iEwzNeeMxRF/2MGrFNCkd162x0OTXgW3RRoLobElzjiS5VbN+AK6P65fgjGobLbTP8E6KPOZAEqXmfpg0HfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=T0d5FZuI; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T0d5FZuI"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fx6lq0M0Fz9v9H;
	Thu, 16 Apr 2026 07:59:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776319159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdYYj6riYPTbHMM03d5MjNlO26UgiwN7VzvRSyjNM9s=;
	b=T0d5FZuIdovLQSma1yRC/MqVlnad0m/7B26hJJkNPWxROCk60QRoLX6Bc9CAlxB6n2IYfx
	MvijupiQs9VPfrqOWiy/4JJhd4VBKXd6PyCdV7QuOJk/AG9lfupfKGTQkKXucNabXkIa5a
	iwQWpZtPhnFoA6mKpS8xtGvZAD2KqMoojSTeo004xk4h8n1YlmMoaMTqEgUQhQtpk9x/w8
	IC1iG90Z3MfzFqTuPpc1bi8s9eMMcHAAjfhC4GTi4LwF5ufeMsigGPzMmtbuDsxyrlbbwL
	9YHRPd/atHZVjcZNxXj3DcpynbBjF4e2icTPz0tK1MnGVp9jW44Hgezo9OpmxQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 13:59:05 +0800
Message-Id: <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Yixun Lan" <dlan@kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org>
 <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
In-Reply-To: <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
X-MBO-RS-ID: b7b74779982dba8ead6
X-MBO-RS-META: toouq7rwxsurys33hpqzupw7oknyhwcj

On Tue Apr 14, 2026 at 9:25 PM CST, Anand Moon wrote:
> Hi Shuwei,
>
> On Fri, 10 Apr 2026 at 13:30, Shuwei Wu <shuwei.wu@mailbox.org> wrote:
>>
>> Add Operating Performance Points (OPP) tables and CPU clock properties
>> for the two clusters in the SpacemiT K1 SoC.
>>
>> Also assign the CPU power supply (cpu-supply) for the Banana Pi BPI-F3
>> board to fully enable CPU DVFS.
>>
>> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
>>
>> ---
>> Changes in v2:
>> - Add k1-opp.dtsi with OPP tables for both CPU clusters
>> - Assign CPU supplies and include OPP table for Banana Pi BPI-F3
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
>>  arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 +++++++++++++++++=
+++++++
>>  arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
>>  3 files changed, 147 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/risc=
v/boot/dts/spacemit/k1-bananapi-f3.dts
>> index 444c3b1e6f44..3780593f610d 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
>> @@ -5,6 +5,7 @@
>>
>>  #include "k1.dtsi"
>>  #include "k1-pinctrl.dtsi"
>> +#include "k1-opp.dtsi"
>>
>>  / {
>>         model =3D "Banana Pi BPI-F3";
>> @@ -86,6 +87,38 @@ &combo_phy {
>>         status =3D "okay";
>>  };
>>
>> +&cpu_0 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_1 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_2 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_3 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_4 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_5 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_6 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>> +&cpu_7 {
>> +       cpu-supply =3D <&buck1_3v45>;
>> +};
>> +
>>  &emmc {
>>         bus-width =3D <8>;
>>         mmc-hs400-1_8v;
>> @@ -201,7 +234,7 @@ pmic@41 {
>>                 dldoin2-supply =3D <&buck5>;
>>
>>                 regulators {
>> -                       buck1 {
>> +                       buck1_3v45: buck1 {
>>                                 regulator-min-microvolt =3D <500000>;
>>                                 regulator-max-microvolt =3D <3450000>;
>>                                 regulator-ramp-delay =3D <5000>;
>> diff --git a/arch/riscv/boot/dts/spacemit/k1-opp.dtsi b/arch/riscv/boot/=
dts/spacemit/k1-opp.dtsi
>> new file mode 100644
>> index 000000000000..768ae390686d
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
>> @@ -0,0 +1,105 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/ {
>> +       cluster0_opp_table: opp-table-cluster0 {
>> +               compatible =3D "operating-points-v2";
>> +               opp-shared;
>> +
>> +               opp-614400000 {
>> +                       opp-hz =3D /bits/ 64 <614400000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-819000000 {
>> +                       opp-hz =3D /bits/ 64 <819000000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-1000000000 {
>> +                       opp-hz =3D /bits/ 64 <1000000000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-1228800000 {
>> +                       opp-hz =3D /bits/ 64 <1228800000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-1600000000 {
>> +                       opp-hz =3D /bits/ 64 <1600000000>;
>> +                       opp-microvolt =3D <1050000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +       };
>> +
>> +       cluster1_opp_table: opp-table-cluster1 {
>> +               compatible =3D "operating-points-v2";
>> +               opp-shared;
>> +
>> +               opp-614400000 {
>> +                       opp-hz =3D /bits/ 64 <614400000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-819000000 {
>> +                       opp-hz =3D /bits/ 64 <819000000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-1000000000 {
>> +                       opp-hz =3D /bits/ 64 <1000000000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-1228800000 {
>> +                       opp-hz =3D /bits/ 64 <1228800000>;
>> +                       opp-microvolt =3D <950000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +
>> +               opp-1600000000 {
>> +                       opp-hz =3D /bits/ 64 <1600000000>;
>> +                       opp-microvolt =3D <1050000>;
>> +                       clock-latency-ns =3D <200000>;
>> +               };
>> +       };
>> +};
>> +
>> +&cpu_0 {
>> +       operating-points-v2 =3D <&cluster0_opp_table>;
>> +};
>> +
>> +&cpu_1 {
>> +       operating-points-v2 =3D <&cluster0_opp_table>;
>> +};
>> +
>> +&cpu_2 {
>> +       operating-points-v2 =3D <&cluster0_opp_table>;
>> +};
>> +
>> +&cpu_3 {
>> +       operating-points-v2 =3D <&cluster0_opp_table>;
>> +};
>> +
>> +&cpu_4 {
>> +       operating-points-v2 =3D <&cluster1_opp_table>;
>> +};
>> +
>> +&cpu_5 {
>> +       operating-points-v2 =3D <&cluster1_opp_table>;
>> +};
>> +
>> +&cpu_6 {
>> +       operating-points-v2 =3D <&cluster1_opp_table>;
>> +};
>> +
>> +&cpu_7 {
>> +       operating-points-v2 =3D <&cluster1_opp_table>;
>> +};
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/=
spacemit/k1.dtsi
>> index 529ec68e9c23..bdd109b81730 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -54,6 +54,7 @@ cpu_0: cpu@0 {
>>                         compatible =3D "spacemit,x60", "riscv";
>>                         device_type =3D "cpu";
>>                         reg =3D <0>;
>> +                       clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
>>                         riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicboz=
_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvf=
h_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
>>                         riscv,isa-base =3D "rv64i";
>>                         riscv,isa-extensions =3D "i", "m", "a", "f", "d"=
, "c", "b", "v", "zicbom",
>> @@ -84,6 +85,7 @@ cpu_1: cpu@1 {
>>                         compatible =3D "spacemit,x60", "riscv";
>>                         device_type =3D "cpu";
>>                         reg =3D <1>;
>> +                       clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
>
> Based on the Spacemit kernel source, the k1-x_opp_table.dtsi file
> defines several additional clocks for the Operating Performance Points
> (OPP) table:
>
>  clocks =3D <&ccu CLK_CPU_C0_ACE>, <&ccu CLK_CPU_C1_ACE>, <&ccu CLK_CPU_C=
0_TCM>,
>                         <&ccu CLK_CCI550>, <&ccu CLK_PLL3>, <&ccu
> CLK_CPU_C0_HI>, <&ccu CLK_CPU_C1_HI>;
>                 clock-names =3D "ace0","ace1","tcm","cci","pll3", "c0hi",=
 "c1hi";
>
> These hardware clocks are also explicitly registered in the APMU clock dr=
iver
> via the k1_ccu_apmu_hws array, confirming their availability for frequenc=
y
> and voltage scaling on the K1-X SoC.
>
> static struct clk_hw *k1_ccu_apmu_hws[] =3D {
>         [CLK_CCI550]            =3D &cci550_clk.common.hw,
>         [CLK_CPU_C0_HI]         =3D &cpu_c0_hi_clk.common.hw,
>         [CLK_CPU_C0_CORE]       =3D &cpu_c0_core_clk.common.hw,
>         [CLK_CPU_C0_ACE]        =3D &cpu_c0_ace_clk.common.hw,
>         [CLK_CPU_C0_TCM]        =3D &cpu_c0_tcm_clk.common.hw,
>         [CLK_CPU_C1_HI]         =3D &cpu_c1_hi_clk.common.hw,
>         [CLK_CPU_C1_CORE]       =3D &cpu_c1_core_clk.common.hw,
>         [CLK_CPU_C1_ACE]        =3D &cpu_c1_ace_clk.common.hw,
>
> Yes, it is possible to add these clocks for DVFS to work correctly,
> provided they are managed by the appropriate driver and declared in
> the Device Tree (DT).
>
> Thanks
> -Anand

Thanks for your review and for pointing this out.

Regarding the clocks you mentioned, I'd like to clarify their roles based o=
n
the K1 datasheet. Taking Cluster 0 as an example, c0_core_clk is the primar=
y
clock for the cluster. c0_ace_clk and c0_tcm_clk are children derived from =
it,
defaulting to half the frequency of their parent core clock, while c0_hi_cl=
k
represents the high-speed path selection.
Cluster 1 follows the same structure.

Based on the official SpacemiT Bianbu OS source, the spacemit-cpufreq.c dri=
ver
mainly performs the following tasks:
1. Sets the CCI550 clock frequency to 614MHz.
2. Sets the clock frequencies of c0_ace_clk, c1_ace1_clk, and c0_tcm_clk to=
 half
the frequency of their parent clock.
3. For the 1.6GHz OPP, it sets the PLL3 frequency to 3.2GHz and the
c0_hi_clk/c1_hi_clk frequencies to 1.6GHz.

I booted with the manufacturer's OpenWRT image and used debugfs to confirm =
that
the clock states are exactly as described above.

At 1.6GHz:
Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
---------------------------------------------------------------------------
pll3                          3,200,000,000      Y      deviceless
 =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      dev=
iceless
     =E2=94=9C=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      dev=
iceless
     =E2=94=82   =E2=94=94=E2=94=80 cpu_c1_pclk       1,600,000,000      Y =
     cpu0
     =E2=94=82       =E2=94=94=E2=94=80 cpu_c1_ace_clk  800,000,000      Y =
     deviceless
     =E2=94=94=E2=94=80 cpu_c0_hi_clk         1,600,000,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cpu_c0_core_clk   1,600,000,000      Y      cpu=
0
             =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  800,000,000      Y      dev=
iceless
             =E2=94=94=E2=94=80 cpu_c0_ace_clk  800,000,000      Y      dev=
iceless

pll1_2457p6_vco               2,457,600,000      Y      deviceless
 =E2=94=94=E2=94=80 pll1_d4                     614,400,000      Y      dev=
iceless
     =E2=94=94=E2=94=80 pll1_d4_614p4           614,400,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cci550_clk          614,400,000      Y      dev=
iceless

At 1.228GHz:
Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
---------------------------------------------------------------------------
pll1_2457p6_vco               2,457,600,000      Y      deviceless
 =E2=94=94=E2=94=80 pll1_d2                   1,228,800,000      Y      dev=
iceless
     =E2=94=94=E2=94=80 pll1_d2_1228p8        1,228,800,000      Y      dev=
iceless
         =E2=94=9C=E2=94=80 cpu_c0_core_clk   1,228,800,000      Y      cpu=
0
         =E2=94=82   =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  614,400,000      Y =
     deviceless
         =E2=94=82   =E2=94=94=E2=94=80 cpu_c0_ace_clk  614,400,000      Y =
     deviceless
         =E2=94=94=E2=94=80 cpu_c1_pclk       1,228,800,000      Y      cpu=
0
             =E2=94=94=E2=94=80 cpu_c1_ace_clk  614,400,000      Y      dev=
iceless
  =E2=94=94=E2=94=80 pll1_d4                     614,400,000      Y      de=
viceless
     =E2=94=94=E2=94=80 pll1_d4_614p4           614,400,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cci550_clk          614,400,000      Y      dev=
iceless

pll3                          3,200,000,000      Y      deviceless
 =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      dev=
iceless
     =E2=94=9C=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      dev=
iceless
     =E2=94=94=E2=94=80 cpu_c0_hi_clk         1,600,000,000      Y      dev=
iceless
 =E2=94=94=E2=94=80 pll3_d3                   1,066,666,666      Y      dev=
iceless

Regarding the necessity of listing these clocks in the DT, my analysis is a=
s follows:
1. For CCI550, I did not find a clear definition of this clock's specific r=
ole
in the SoC datasheet. Although the vendor kernel increases its frequency,
my benchmarks show that maintaining the mainline default (245.76MHz) has a
negligible impact on CPU performance.
2. For ACE and TCM clocks, they function as synchronous children of the cor=
e
clock with a default divide-by-2 ratio. Since they scale automatically rela=
tive
to c0_core_clk/c1_core_clk and no other peripherals depend on them, they do=
 not
require manual management in the OPP table.
3. For the high-speed path, the underlying clock controller logic already h=
andles
the parent MUX switching and PLL3 scaling automatically when clk_set_rate()
is called on the core clock.

I have verified this by checking the hardware state in the mainline kernel.
The clock tree matches the vendor kernel's configuration:

At 1.6GHz:
Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
---------------------------------------------------------------------------
pll3                          3,200,000,000      Y      deviceless
 =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      dev=
iceless
     =E2=94=9C=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      dev=
iceless
     =E2=94=82   =E2=94=94=E2=94=80 cpu_c1_core_clk   1,600,000,000      Y =
     cpu4
     =E2=94=82       =E2=94=94=E2=94=80 cpu_c1_ace_clk  800,000,000      Y =
     deviceless
     =E2=94=94=E2=94=80 cpu_c0_hi_clk         1,600,000,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cpu_c0_core_clk   1,600,000,000      Y      cpu=
0
             =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  800,000,000      Y      dev=
iceless
             =E2=94=94=E2=94=80 cpu_c0_ace_clk  800,000,000      Y      dev=
iceless

pll1                          2,457,600,000      Y      deviceless
 =E2=94=94=E2=94=80 pll1_d5                     491,520,000      Y      dev=
iceless
     =E2=94=94=E2=94=80 pll1_d5_491p52          491,520,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cci550_clk          245,760,000      Y      dev=
iceless

At 1.228GHz:
Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
---------------------------------------------------------------------------
pll1                          2,457,600,000      Y      deviceless
 =E2=94=9C=E2=94=80 pll1_d5                     491,520,000      Y      dev=
iceless
 =E2=94=82   =E2=94=94=E2=94=80 pll1_d5_491p52          491,520,000      Y =
     deviceless
 =E2=94=82       =E2=94=94=E2=94=80 cci550_clk          245,760,000      Y =
     deviceless
 =E2=94=94=E2=94=80 pll1_d2                   1,228,800,000      Y      dev=
iceless
     =E2=94=94=E2=94=80 pll1_d2_1228p8        1,228,800,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cpu_c0_core_clk   1,228,800,000      Y      cpu=
0
             =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  614,400,000      Y      dev=
iceless
             =E2=94=94=E2=94=80 cpu_c0_ace_clk  614,400,000      Y      dev=
iceless

pll3                          3,200,000,000      Y      deviceless
 =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      dev=
iceless
     =E2=94=94=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      dev=
iceless
         =E2=94=94=E2=94=80 cpu_c1_core_clk   1,600,000,000      Y      cpu=
4
             =E2=94=94=E2=94=80 cpu_c1_ace_clk  800,000,000      Y      dev=
iceless

Performance benchmarks also confirm that the current configuration is suffi=
cient:
Benchmark (AWK computation): time awk 'BEGIN{for(i=3D0;i<10000000;i++) sum+=
=3Di}'
---------------------------------------------------------------------------=
-
Frequency    |      Mainline Linux (s)       |        OpenWrt (s)         =
=20
(kHz)        |  Real (Total) |  User (CPU)   |  Real (Total) |  User (CPU) =
)
-------------+---------------+---------------+---------------+-------------=
-
1,600,000    |     1.82s     |     1.81s     |     1.73s     |    1.73s   =
=20
1,228,800    |     2.34s     |     2.33s     |     2.26s     |    2.26s   =
=20
1,000,000    |     2.94s     |     2.86s     |     2.78s     |    2.78s   =
=20
  819,000    |     3.54s     |     3.53s     |     3.39s     |    3.39s   =
=20
  614,400    |     4.73s     |     4.71s     |     4.51s     |    4.51s   =
=20
---------------------------------------------------------------------------=
-

In summary, because the clock controller correctly handles the internal div=
iders
and parent switching, declaring only the primary core clock for each CPU no=
de is
sufficient for functional DVFS.

--=20
Best regards,
Shuwei Wu
