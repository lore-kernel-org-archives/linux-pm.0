Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8312C2741A0
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 11:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339474; cv=pass; b=WGWzBkxf1Bn1/9EhhAsmsTLaZzbH2rW38PmgeFUTChFd8L6m9EQjDW9uaGjX+nf+j8Z2qKka8fZlnbrp8LhxczBLKBf0Rm2i3GyuQUxZ2wio0L8lxipmuHgh9Xw5q+gOWII2+etsU+PIiqlH9gSsjQmA3oU90AjhFFBL3BXcHvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339474; c=relaxed/simple;
	bh=y+bMqqcHc0MOUSHh9FMZcaPA8F4kx57RUuCle6g4hHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+OB+QOqPVMiuNnugs6rr0Gt58ib4qn6Bc4jGPsbMtGNcNhBshTAXurRMgGZSWdqujw1BVsiAB11Ys0RaUOJ/3DDoQ0m/Yu8Rbe848dWEGiTKGsru52zKxi07CIxHL5qb0cXj9RJjsmuGUB003je300t1RmJDPz9RiE4awJVpuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJmkiuv3; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJmkiuv3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-671c4d08dc2so3048928a12.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 04:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776339470; cv=none;
        d=google.com; s=arc-20240605;
        b=cH8x0d04XJdNuHDcb4ZO9fCl7U4Bz1VGlpmhO39qQZmDT6Ls1OF0k0V3OsC2aPaiUu
         yBxPu9Z5Qzgu2W1tPWQafOEFLDXMWbPN2nVuK14NSyE4ZEdZLF/qmZfUAu/2vQi+nUhx
         lrG8o6VGiz0mK+F4VFXZr+Gd1v4Vnix3Lzbp5emV1LhARBeCrkD0iMeEzuKW0VU9hzFd
         5QBoIp0rsbH5paGYG/yLXomL2F/wJq5PC7+keaOVqzCdzZkzOHHuReu9QrSEYpexYXp+
         V5WG9whKd4BqMNuWR9f9jzCjTOU0Nen1Uw8jGlhRTCtX2WPowqP4p866H+fN2o6PwPaw
         h8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3tkxR5LobNlNsp7WzOQN3ZZ4Rm/yHO6kNskBcUk/aOk=;
        fh=7RE0/kt3i8D5MdAicaNcXJbRsHp74UAdq2p4DUqWb+U=;
        b=cuOwLGnBJjGHgAEj6STcpZd8OKZEAtXdSbQwr3MiZ5/bAF4DaMY1uvPsuKZLTKIJE5
         ACcZ25ndqEVg5S08e0Z7oxqPjPsjPq3eb9gY5NGJYYIAZFIDUaD/rGuenpJfhIhUdmm1
         U5PCsRAD3C8okL8RfbtKZ5tn1Pjrdraswm/Yx+ToalcipVWrvjnT+hfiPMiIWFnif8yG
         fCda+kMG9R5XqpZIWDNI6k6jCFBz4ArHwVhh/K92+9iGNH8/0+bYtJkWhxakrqFJomZ0
         Yk+0m/0f2AdrUPRlYqgroitwbqrweaxivaoN9entQ/7T7FxlxF/+V6FXtWgA16+hWzP0
         fSRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776339470; x=1776944270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tkxR5LobNlNsp7WzOQN3ZZ4Rm/yHO6kNskBcUk/aOk=;
        b=OJmkiuv3azjFChmXcj4UfpC/B5gSpK8lhz9w2RTkcRx+Hbxqm60Q5DXJ/dwb6k8n6/
         /XXYBFRfWze5uZ5eoV2w05S8NFwxmil/yYrSHHSAw3NbPkl4N8Sn9sx70+QZvvClYZ/v
         4rZE1gioDT8L7kG9nRr+zMPPHvtEphMg4qdsbQuMR19pVHN4fFptgGOBV6ULqlhTKBe3
         IVYXp8lJkSxwZn3Tc1dHpPt7dBjq6v1utS3znb8b9J6ObVZp0afXc4Yq4B+rbg7wxphJ
         VlOcTNbHz8ua+cNz3xUopp8dxaGivIs2j9NTxqQxVfTbZ/x2TM54+QVVOPNG6Iui6SjQ
         dHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776339470; x=1776944270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3tkxR5LobNlNsp7WzOQN3ZZ4Rm/yHO6kNskBcUk/aOk=;
        b=hYcDfHujE5ALqnNACoYb6y9mUn1nt55MX8Rok2pumVujxZaZemLN5tmg/YgBvKRG2w
         E8hqoCvHV7dlMbb7uDNb/hKmA2LKSsARN+FQD8rfEaqYqGL30wGhf4Ti24bkxft458pO
         5FJDmaef7Fv/1EGzFIfmco1SePM8yKnf1mMsczcPacla1wxpcJLKk3BoejJJlns1RENG
         BxjjBXvQv31zrGc+bCR0eFXW0QuHe71rAQ0YyplULemzgTF8M0kWvpPDPWZl1rVuPAY0
         pWAzfvDNk1ijPLIpixlp0GT+D5pNAreKI6VDHhiJTuOcA2Q4K4/CSiDSRAs50T7Awj/w
         WAPg==
X-Forwarded-Encrypted: i=1; AFNElJ8/vw/sh54sp5czcj+MdaBQ9jv1Lrr4EVfSrkQi+KuzLn0/PMR+nI0yrD/CAM4QIGramlixpvcplA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vD2iOOVAgzxjMDCLq8/FO1z1F2Y4la8hSVpzgXQyBfD2e1p7
	ZAzc/vpXK+Oe9NaUQQkM2wfS/P/w7ohCLc/GfNp0kfYYnYHfwl3afMfmqaPjN2FAzD9ZwnUkoKY
	kl9prFBV1UBZejYrQEptXeJFSU830f/Y=
X-Gm-Gg: AeBDievnWYBgF9MsBTqfagCYXQ4/sSeM98LfOKFYgwYhZYwlFxfsZaMkGkr5X/CrDi6
	T4buVX2GusPvXYYoqOLiFIJh4t0GpUqqHDMNFvXSoawCluxNjiWxf1cb6S8U/lw7NDq7WnyrRmS
	X/39N9kmXR94RlWikiUyaXtcAjyPttp9W8M3mZurtg2gtDR0CHU1hM1sdx6VlbfiryKvdFhav/C
	BuOmbo614xI9b3EYBpVwioxw5VoouCUR/ZZpVmseCz3NOBcS+HaIfXpcBc/Uzanyt4llooKnofr
	YXbXqZw6ENeil3lH
X-Received: by 2002:a17:907:874e:b0:b9e:b78:d6db with SMTP id
 a640c23a62f3a-b9e0b78d725mr654969666b.30.1776339468690; Thu, 16 Apr 2026
 04:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org> <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org>
In-Reply-To: <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 16 Apr 2026 17:07:32 +0530
X-Gm-Features: AQROBzCTKU_VxSSEbfoM3-gVelIWkEsa_RLbSNY2lrCCrTdeopvGQ57eo0SFCzY
Message-ID: <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuwei,

Thanks for sharing the details.

On Thu, 16 Apr 2026 at 11:29, Shuwei Wu <shuwei.wu@mailbox.org> wrote:
>
> On Tue Apr 14, 2026 at 9:25 PM CST, Anand Moon wrote:
> > Hi Shuwei,
> >
> > On Fri, 10 Apr 2026 at 13:30, Shuwei Wu <shuwei.wu@mailbox.org> wrote:
> >>
> >> Add Operating Performance Points (OPP) tables and CPU clock properties
> >> for the two clusters in the SpacemiT K1 SoC.
> >>
> >> Also assign the CPU power supply (cpu-supply) for the Banana Pi BPI-F3
> >> board to fully enable CPU DVFS.
> >>
> >> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> >>
> >> ---
> >> Changes in v2:
> >> - Add k1-opp.dtsi with OPP tables for both CPU clusters
> >> - Assign CPU supplies and include OPP table for Banana Pi BPI-F3
> >> ---
> >>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |  35 +++++++-
> >>  arch/riscv/boot/dts/spacemit/k1-opp.dtsi        | 105 +++++++++++++++=
+++++++++
> >>  arch/riscv/boot/dts/spacemit/k1.dtsi            |   8 ++
> >>  3 files changed, 147 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/ri=
scv/boot/dts/spacemit/k1-bananapi-f3.dts
> >> index 444c3b1e6f44..3780593f610d 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> >> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> >> @@ -5,6 +5,7 @@
> >>
> >>  #include "k1.dtsi"
> >>  #include "k1-pinctrl.dtsi"
> >> +#include "k1-opp.dtsi"
> >>
> >>  / {
> >>         model =3D "Banana Pi BPI-F3";
> >> @@ -86,6 +87,38 @@ &combo_phy {
> >>         status =3D "okay";
> >>  };
> >>
> >> +&cpu_0 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_1 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_2 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_3 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_4 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_5 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_6 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >> +&cpu_7 {
> >> +       cpu-supply =3D <&buck1_3v45>;
> >> +};
> >> +
> >>  &emmc {
> >>         bus-width =3D <8>;
> >>         mmc-hs400-1_8v;
> >> @@ -201,7 +234,7 @@ pmic@41 {
> >>                 dldoin2-supply =3D <&buck5>;
> >>
> >>                 regulators {
> >> -                       buck1 {
> >> +                       buck1_3v45: buck1 {
> >>                                 regulator-min-microvolt =3D <500000>;
> >>                                 regulator-max-microvolt =3D <3450000>;
> >>                                 regulator-ramp-delay =3D <5000>;
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1-opp.dtsi b/arch/riscv/boo=
t/dts/spacemit/k1-opp.dtsi
> >> new file mode 100644
> >> index 000000000000..768ae390686d
> >> --- /dev/null
> >> +++ b/arch/riscv/boot/dts/spacemit/k1-opp.dtsi
> >> @@ -0,0 +1,105 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +
> >> +/ {
> >> +       cluster0_opp_table: opp-table-cluster0 {
> >> +               compatible =3D "operating-points-v2";
> >> +               opp-shared;
> >> +
> >> +               opp-614400000 {
> >> +                       opp-hz =3D /bits/ 64 <614400000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-819000000 {
> >> +                       opp-hz =3D /bits/ 64 <819000000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-1000000000 {
> >> +                       opp-hz =3D /bits/ 64 <1000000000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-1228800000 {
> >> +                       opp-hz =3D /bits/ 64 <1228800000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-1600000000 {
> >> +                       opp-hz =3D /bits/ 64 <1600000000>;
> >> +                       opp-microvolt =3D <1050000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +       };
> >> +
> >> +       cluster1_opp_table: opp-table-cluster1 {
> >> +               compatible =3D "operating-points-v2";
> >> +               opp-shared;
> >> +
> >> +               opp-614400000 {
> >> +                       opp-hz =3D /bits/ 64 <614400000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-819000000 {
> >> +                       opp-hz =3D /bits/ 64 <819000000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-1000000000 {
> >> +                       opp-hz =3D /bits/ 64 <1000000000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-1228800000 {
> >> +                       opp-hz =3D /bits/ 64 <1228800000>;
> >> +                       opp-microvolt =3D <950000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +
> >> +               opp-1600000000 {
> >> +                       opp-hz =3D /bits/ 64 <1600000000>;
> >> +                       opp-microvolt =3D <1050000>;
> >> +                       clock-latency-ns =3D <200000>;
> >> +               };
> >> +       };
> >> +};
> >> +
> >> +&cpu_0 {
> >> +       operating-points-v2 =3D <&cluster0_opp_table>;
> >> +};
> >> +
> >> +&cpu_1 {
> >> +       operating-points-v2 =3D <&cluster0_opp_table>;
> >> +};
> >> +
> >> +&cpu_2 {
> >> +       operating-points-v2 =3D <&cluster0_opp_table>;
> >> +};
> >> +
> >> +&cpu_3 {
> >> +       operating-points-v2 =3D <&cluster0_opp_table>;
> >> +};
> >> +
> >> +&cpu_4 {
> >> +       operating-points-v2 =3D <&cluster1_opp_table>;
> >> +};
> >> +
> >> +&cpu_5 {
> >> +       operating-points-v2 =3D <&cluster1_opp_table>;
> >> +};
> >> +
> >> +&cpu_6 {
> >> +       operating-points-v2 =3D <&cluster1_opp_table>;
> >> +};
> >> +
> >> +&cpu_7 {
> >> +       operating-points-v2 =3D <&cluster1_opp_table>;
> >> +};
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dt=
s/spacemit/k1.dtsi
> >> index 529ec68e9c23..bdd109b81730 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> @@ -54,6 +54,7 @@ cpu_0: cpu@0 {
> >>                         compatible =3D "spacemit,x60", "riscv";
> >>                         device_type =3D "cpu";
> >>                         reg =3D <0>;
> >> +                       clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
> >>                         riscv,isa =3D "rv64imafdcbv_zicbom_zicbop_zicb=
oz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_z=
vfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
> >>                         riscv,isa-base =3D "rv64i";
> >>                         riscv,isa-extensions =3D "i", "m", "a", "f", "=
d", "c", "b", "v", "zicbom",
> >> @@ -84,6 +85,7 @@ cpu_1: cpu@1 {
> >>                         compatible =3D "spacemit,x60", "riscv";
> >>                         device_type =3D "cpu";
> >>                         reg =3D <1>;
> >> +                       clocks =3D <&syscon_apmu CLK_CPU_C0_CORE>;
> >
> > Based on the Spacemit kernel source, the k1-x_opp_table.dtsi file
> > defines several additional clocks for the Operating Performance Points
> > (OPP) table:
> >
> >  clocks =3D <&ccu CLK_CPU_C0_ACE>, <&ccu CLK_CPU_C1_ACE>, <&ccu CLK_CPU=
_C0_TCM>,
> >                         <&ccu CLK_CCI550>, <&ccu CLK_PLL3>, <&ccu
> > CLK_CPU_C0_HI>, <&ccu CLK_CPU_C1_HI>;
> >                 clock-names =3D "ace0","ace1","tcm","cci","pll3", "c0hi=
", "c1hi";
> >
> > These hardware clocks are also explicitly registered in the APMU clock =
driver
> > via the k1_ccu_apmu_hws array, confirming their availability for freque=
ncy
> > and voltage scaling on the K1-X SoC.
> >
> > static struct clk_hw *k1_ccu_apmu_hws[] =3D {
> >         [CLK_CCI550]            =3D &cci550_clk.common.hw,
> >         [CLK_CPU_C0_HI]         =3D &cpu_c0_hi_clk.common.hw,
> >         [CLK_CPU_C0_CORE]       =3D &cpu_c0_core_clk.common.hw,
> >         [CLK_CPU_C0_ACE]        =3D &cpu_c0_ace_clk.common.hw,
> >         [CLK_CPU_C0_TCM]        =3D &cpu_c0_tcm_clk.common.hw,
> >         [CLK_CPU_C1_HI]         =3D &cpu_c1_hi_clk.common.hw,
> >         [CLK_CPU_C1_CORE]       =3D &cpu_c1_core_clk.common.hw,
> >         [CLK_CPU_C1_ACE]        =3D &cpu_c1_ace_clk.common.hw,
> >
> > Yes, it is possible to add these clocks for DVFS to work correctly,
> > provided they are managed by the appropriate driver and declared in
> > the Device Tree (DT).
> >
> > Thanks
> > -Anand
>
> Thanks for your review and for pointing this out.
>
> Regarding the clocks you mentioned, I'd like to clarify their roles based=
 on
> the K1 datasheet. Taking Cluster 0 as an example, c0_core_clk is the prim=
ary
> clock for the cluster. c0_ace_clk and c0_tcm_clk are children derived fro=
m it,
> defaulting to half the frequency of their parent core clock, while c0_hi_=
clk
> represents the high-speed path selection.
> Cluster 1 follows the same structure.
>
> Based on the official SpacemiT Bianbu OS source, the spacemit-cpufreq.c d=
river
> mainly performs the following tasks:
> 1. Sets the CCI550 clock frequency to 614MHz.
> 2. Sets the clock frequencies of c0_ace_clk, c1_ace1_clk, and c0_tcm_clk =
to half
> the frequency of their parent clock.
> 3. For the 1.6GHz OPP, it sets the PLL3 frequency to 3.2GHz and the
> c0_hi_clk/c1_hi_clk frequencies to 1.6GHz.
>
> I booted with the manufacturer's OpenWRT image and used debugfs to confir=
m that
> the clock states are exactly as described above.
>
> At 1.6GHz:
> Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
> -------------------------------------------------------------------------=
--
> pll3                          3,200,000,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      d=
eviceless
>      =E2=94=9C=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      d=
eviceless
>      =E2=94=82   =E2=94=94=E2=94=80 cpu_c1_pclk       1,600,000,000      =
Y      cpu0
>      =E2=94=82       =E2=94=94=E2=94=80 cpu_c1_ace_clk  800,000,000      =
Y      deviceless
>      =E2=94=94=E2=94=80 cpu_c0_hi_clk         1,600,000,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cpu_c0_core_clk   1,600,000,000      Y      c=
pu0
>              =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  800,000,000      Y      d=
eviceless
>              =E2=94=94=E2=94=80 cpu_c0_ace_clk  800,000,000      Y      d=
eviceless
>
> pll1_2457p6_vco               2,457,600,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll1_d4                     614,400,000      Y      d=
eviceless
>      =E2=94=94=E2=94=80 pll1_d4_614p4           614,400,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cci550_clk          614,400,000      Y      d=
eviceless
>
> At 1.228GHz:
> Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
> -------------------------------------------------------------------------=
--
> pll1_2457p6_vco               2,457,600,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll1_d2                   1,228,800,000      Y      d=
eviceless
>      =E2=94=94=E2=94=80 pll1_d2_1228p8        1,228,800,000      Y      d=
eviceless
>          =E2=94=9C=E2=94=80 cpu_c0_core_clk   1,228,800,000      Y      c=
pu0
>          =E2=94=82   =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  614,400,000      =
Y      deviceless
>          =E2=94=82   =E2=94=94=E2=94=80 cpu_c0_ace_clk  614,400,000      =
Y      deviceless
>          =E2=94=94=E2=94=80 cpu_c1_pclk       1,228,800,000      Y      c=
pu0
>              =E2=94=94=E2=94=80 cpu_c1_ace_clk  614,400,000      Y      d=
eviceless
>   =E2=94=94=E2=94=80 pll1_d4                     614,400,000      Y      =
deviceless
>      =E2=94=94=E2=94=80 pll1_d4_614p4           614,400,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cci550_clk          614,400,000      Y      d=
eviceless
>
> pll3                          3,200,000,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      d=
eviceless
>      =E2=94=9C=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      d=
eviceless
>      =E2=94=94=E2=94=80 cpu_c0_hi_clk         1,600,000,000      Y      d=
eviceless
>  =E2=94=94=E2=94=80 pll3_d3                   1,066,666,666      Y      d=
eviceless
>
> Regarding the necessity of listing these clocks in the DT, my analysis is=
 as follows:
> 1. For CCI550, I did not find a clear definition of this clock's specific=
 role
> in the SoC datasheet. Although the vendor kernel increases its frequency,
> my benchmarks show that maintaining the mainline default (245.76MHz) has =
a
> negligible impact on CPU performance.
> 2. For ACE and TCM clocks, they function as synchronous children of the c=
ore
> clock with a default divide-by-2 ratio. Since they scale automatically re=
lative
> to c0_core_clk/c1_core_clk and no other peripherals depend on them, they =
do not
> require manual management in the OPP table.
> 3. For the high-speed path, the underlying clock controller logic already=
 handles
> the parent MUX switching and PLL3 scaling automatically when clk_set_rate=
()
> is called on the core clock.
>
> I have verified this by checking the hardware state in the mainline kerne=
l.
> The clock tree matches the vendor kernel's configuration:
>
> At 1.6GHz:
> Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
> -------------------------------------------------------------------------=
--
> pll3                          3,200,000,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      d=
eviceless
>      =E2=94=9C=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      d=
eviceless
>      =E2=94=82   =E2=94=94=E2=94=80 cpu_c1_core_clk   1,600,000,000      =
Y      cpu4
>      =E2=94=82       =E2=94=94=E2=94=80 cpu_c1_ace_clk  800,000,000      =
Y      deviceless
>      =E2=94=94=E2=94=80 cpu_c0_hi_clk         1,600,000,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cpu_c0_core_clk   1,600,000,000      Y      c=
pu0
>              =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  800,000,000      Y      d=
eviceless
>              =E2=94=94=E2=94=80 cpu_c0_ace_clk  800,000,000      Y      d=
eviceless
>
> pll1                          2,457,600,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll1_d5                     491,520,000      Y      d=
eviceless
>      =E2=94=94=E2=94=80 pll1_d5_491p52          491,520,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cci550_clk          245,760,000      Y      d=
eviceless
>
> At 1.228GHz:
> Clock Source & Tree           Rate (Hz)      HW Enable  Consumer
> -------------------------------------------------------------------------=
--
> pll1                          2,457,600,000      Y      deviceless
>  =E2=94=9C=E2=94=80 pll1_d5                     491,520,000      Y      d=
eviceless
>  =E2=94=82   =E2=94=94=E2=94=80 pll1_d5_491p52          491,520,000      =
Y      deviceless
>  =E2=94=82       =E2=94=94=E2=94=80 cci550_clk          245,760,000      =
Y      deviceless
>  =E2=94=94=E2=94=80 pll1_d2                   1,228,800,000      Y      d=
eviceless
>      =E2=94=94=E2=94=80 pll1_d2_1228p8        1,228,800,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cpu_c0_core_clk   1,228,800,000      Y      c=
pu0
>              =E2=94=9C=E2=94=80 cpu_c0_tcm_clk  614,400,000      Y      d=
eviceless
>              =E2=94=94=E2=94=80 cpu_c0_ace_clk  614,400,000      Y      d=
eviceless
>
> pll3                          3,200,000,000      Y      deviceless
>  =E2=94=94=E2=94=80 pll3_d2                   1,600,000,000      Y      d=
eviceless
>      =E2=94=94=E2=94=80 cpu_c1_hi_clk         1,600,000,000      Y      d=
eviceless
>          =E2=94=94=E2=94=80 cpu_c1_core_clk   1,600,000,000      Y      c=
pu4
>              =E2=94=94=E2=94=80 cpu_c1_ace_clk  800,000,000      Y      d=
eviceless
>

Thanks, I have verified the clocks are set to Y in
/sys/kernel/debug/clk/clk_summary

> Performance benchmarks also confirm that the current configuration is suf=
ficient:
> Benchmark (AWK computation): time awk 'BEGIN{for(i=3D0;i<10000000;i++) su=
m+=3Di}'
> -------------------------------------------------------------------------=
---
> Frequency    |      Mainline Linux (s)       |        OpenWrt (s)
> (kHz)        |  Real (Total) |  User (CPU)   |  Real (Total) |  User (CPU=
) )
> -------------+---------------+---------------+---------------+-----------=
---
> 1,600,000    |     1.82s     |     1.81s     |     1.73s     |    1.73s
> 1,228,800    |     2.34s     |     2.33s     |     2.26s     |    2.26s
> 1,000,000    |     2.94s     |     2.86s     |     2.78s     |    2.78s
>   819,000    |     3.54s     |     3.53s     |     3.39s     |    3.39s
>   614,400    |     4.73s     |     4.71s     |     4.51s     |    4.51s
> -------------------------------------------------------------------------=
---
>
> In summary, because the clock controller correctly handles the internal d=
ividers
> and parent switching, declaring only the primary core clock for each CPU =
node is
> sufficient for functional DVFS.
>
I have just tested this patch against  next-20260415
But, I have observed this log on the Banana Pi F3 dev board with the
Banana PI - R4 heat sink and fan.

[    5.803445][    T1] In-situ OAM (IOAM) with IPv6
[    5.809605][    T1] NET: Registered PF_PACKET protocol family
[    5.819098][    T1] Key type dns_resolver registered
[    5.853430][    C2] cpu2: scalar unaligned word access speed is
1.60x byte access speed (fast)
[    5.853431][    C3] cpu3: scalar unaligned word access speed is
1.67x byte access speed (fast)
[    5.853440][    C7] cpu7: scalar unaligned word access speed is
8.10x byte access speed (fast)
[    5.853432][    C1] cpu1: scalar unaligned word access speed is
3.98x byte access speed (fast)
[    5.853431][    T1] cpu0: scalar unaligned word access speed is
2.33x byte access speed (fast)
[    5.853436][    C5] cpu5: scalar unaligned word access speed is
2.29x byte access speed (fast)
[    5.853436][    C6] cpu6: scalar unaligned word access speed is
2.58x byte access speed (fast)
[    5.853431][    C4] cpu4: scalar unaligned word access speed is
2.07x byte access speed (fast)
[    5.936544][   T92] mmcblk0boot0: mmc0:0001 AJTD4R 4.00 MiB
[    6.003120][   T92] mmcblk0boot1: mmc0:0001 AJTD4R 4.00 MiB
[    6.070909][   T92] mmcblk0rpmb: mmc0:0001 AJTD4R 4.00 MiB, chardev (244=
:0)
[    6.380324][    T1] registered taskstats version 1
[    6.407337][    T1] Loading compiled-in X.509 certificates
[    6.594206][    T1] Loaded X.509 cert 'Build time autogenerated
kernel key: 19b81ec48e45e6ee983623417bad5096df8bbcf1'
[    7.600343][    T1] Demotion targets for Node 0: null
[    7.608583][    T1] kmemleak: Kernel memory leak detector
initialized (mem pool available: 1309)
[    7.608646][  T120] kmemleak: Automatic memory scanning thread started
[    7.624663][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers
[    7.636721][    T1] page_owner is disabled
[    8.213648][   T74] debugfs: ':soc:gpio@d4019000-1' already exists
in 'domains'
[    8.233502][   T74] debugfs: ':soc:gpio@d4019000-1' already exists
in 'domains'
[    8.254012][   T74] debugfs: ':soc:gpio@d4019000-1' already exists
in 'domains'
[    8.319431][   T74] printk: legacy console [ttyS0] disabled
[    8.345811][   T74] d4017000.serial: ttyS0 at MMIO 0xd4017000 (irq
=3D 16, base_baud =3D 921600) is a XScale
[    8.357331][   T74] printk: legacy console [ttyS0] enabled
[    8.357331][   T74] printk: legacy console [ttyS0] enabled
[    8.369971][   T74] printk: legacy bootconsole [uart0] disabled
[    8.369971][   T74] printk: legacy bootconsole [uart0] disabled
[    8.427040][   T74] /soc/i2c@d401d800/pmic@41: Fixed dependency
cycle(s) with /soc/i2c@d401d800/pmic@41/regulators/buck5
[    8.634595][   T74] spacemit-p1-rtc spacemit-p1-rtc.1.auto:
registered as rtc0
[    8.642732][   T74] spacemit-p1-rtc spacemit-p1-rtc.1.auto: setting
system clock to 2026-04-10T00:03:42 UTC (1775779422)
[    8.766081][   T74] sdhci-spacemit d4280000.mmc: Got CD GPIO
[    8.801855][  T130] buck1: Restricting voltage, 1050000-950000uV
[    8.806411][  T129] buck1: Restricting voltage, 1050000-950000uV
[    8.813413][  T130] buck1: Restricting voltage, 1050000-950000uV
[    8.818261][  T130] cpu cpu4: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    8.818307][  T129] buck1: Restricting voltage, 1050000-950000uV
[    8.827239][  T129] cpu cpu0: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    8.833161][  T130] cpu cpu4: Failed to set regulator voltages: -22
[    8.842546][  T129] cpu cpu0: Failed to set regulator voltages: -22
[    8.848941][  T130] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    8.855273][  T129] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    8.893720][  T129] buck1: Restricting voltage, 1050000-950000uV
[    8.904437][  T129] buck1: Restricting voltage, 1050000-950000uV
[    8.908515][  T129] cpu cpu0: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    8.918057][  T129] cpu cpu0: Failed to set regulator voltages: -22
[    8.924402][  T129] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    8.945668][   T74] mmc1: SDHCI controller on d4280000.mmc
[d4280000.mmc] using ADMA
[    8.976207][  T130] buck1: Restricting voltage, 1050000-950000uV
[    8.980156][  T130] buck1: Restricting voltage, 1050000-950000uV
[    8.986169][  T130] cpu cpu4: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    8.995473][  T130] cpu cpu4: Failed to set regulator voltages: -22
[    9.001603][  T130] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    9.020028][  T130] buck1: Restricting voltage, 1050000-950000uV
[    9.024051][  T129] buck1: Restricting voltage, 1050000-950000uV
[    9.030122][  T130] buck1: Restricting voltage, 1050000-950000uV
[    9.036004][  T130] cpu cpu4: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    9.036059][  T129] buck1: Restricting voltage, 1050000-950000uV
[    9.045003][  T130] cpu cpu4: Failed to set regulator voltages: -22
[    9.045077][  T130] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    9.058079][   T57] spacemit-k1-pcie ca800000.pcie: host bridge
/soc/pcie-bus/pcie@ca800000 ranges:
[    9.064716][  T129] cpu cpu0: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    9.064745][  T130] buck1: Restricting voltage, 1050000-950000uV
[    9.064825][  T129] cpu cpu0: Failed to set regulator voltages: -22
[    9.064889][  T129] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    9.065762][  T130] buck1: Restricting voltage, 1050000-950000uV
[    9.069924][   T60] spacemit-k1-pcie ca400000.pcie: host bridge
/soc/pcie-bus/pcie@ca400000 ranges:
[    9.071122][   T60] spacemit-k1-pcie ca400000.pcie:       IO
0x009f002000..0x009f101fff -> 0x0000000000
[    9.073304][   T60] spacemit-k1-pcie ca400000.pcie:      MEM
0x0090000000..0x009effffff -> 0x0090000000
[    9.081407][   T74] at24 2-0050: 256 byte 24c02 EEPROM, read-only
[    9.083047][  T130] cpu cpu4: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    9.083509][  T129] buck1: Restricting voltage, 1050000-950000uV
[    9.083614][  T129] buck1: Restricting voltage, 1050000-950000uV
[    9.083686][  T129] cpu cpu0: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    9.083845][  T129] cpu cpu0: Failed to set regulator voltages: -22
[    9.083885][  T129] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    9.089945][   T57] spacemit-k1-pcie ca800000.pcie:       IO
0x00b7002000..0x00b7101fff -> 0x0000000000
[    9.092728][    T1] clk: Disabling unused clocks
[    9.095269][  T130] cpu cpu4: Failed to set regulator voltages: -22
[    9.096981][    T1] PM: genpd: Disabling unused power domains
[    9.104949][   T57] spacemit-k1-pcie ca800000.pcie:      MEM
0x00a0000000..0x00afffffff -> 0x00a0000000
[    9.107986][  T129] buck1: Restricting voltage, 1050000-950000uV
[    9.108166][  T129] buck1: Restricting voltage, 1050000-950000uV
[    9.108246][  T129] cpu cpu0: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    9.108311][  T129] cpu cpu0: Failed to set regulator voltages: -22
[    9.108356][  T129] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    9.108582][  T130] cpufreq: __target_index: Failed to change cpu
frequency: -22
[    9.113366][  T130] buck1: Restricting voltage, 1050000-950000uV
[    9.118144][   T57] spacemit-k1-pcie ca800000.pcie:      MEM
0x00b0000000..0x00b6ffffff -> 0x00b0000000
[    9.130386][  T130] buck1: Restricting voltage, 1050000-950000uV
[    9.196246][  T130] cpu cpu4: _set_opp_voltage: failed to set
voltage (1050000 1050000 1050000 mV): -22
[    9.202562][   T60] spacemit-k1-pcie ca400000.pcie: iATU: unroll T,
8 ob, 8 ib, align 4K, limit 4G
[    9.206998][  T130] cpu cpu4: Failed to set regulator voltages: -22
[    9.257180][  T130] cpufreq: __target_index: Failed to change cpu
frequency: -22

After reviewing the Banana Pi F3 schematics, I confirmed that Buck1 and Buc=
k2
Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the restriction=
 errors,
I expanded the voltage range in the DTS to 500,000=E2=80=93950,000 =C2=B5V.

Additionally, I updated the DTS to map the second CPU cluster (cores 4=E2=
=80=937)
to Buck2 to better align with the hardware's power distribution.

[1] https://drive.google.com/file/d/19iLJ5xnCB_oK8VeQjkPGjzAn39WYyylv/view
(page 4)

Can you share your thoughts on the changes below?
$ git diff
diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 7e300cca50d8..be53645ba0c6 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -102,19 +102,19 @@ &cpu_3 {
 };

 &cpu_4 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &cpu_5 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &cpu_6 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &cpu_7 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &emmc {
@@ -234,14 +234,14 @@ pmic@41 {
                regulators {
                        buck1_3v45: buck1 {
                                regulator-min-microvolt =3D <500000>;
-                               regulator-max-microvolt =3D <3450000>;
+                               regulator-max-microvolt =3D <950000>;
                                regulator-ramp-delay =3D <5000>;
                                regulator-always-on;
                        };

-                       buck2 {
+                       buck2_3v45: buck2 {
                                regulator-min-microvolt =3D <500000>;
-                               regulator-max-microvolt =3D <3450000>;
+                               regulator-max-microvolt =3D <950000>;
                                regulator-ramp-delay =3D <5000>;
                                regulator-always-on;
                        };
> --
> Best regards,
> Shuwei Wu

Thanks
-Anand
