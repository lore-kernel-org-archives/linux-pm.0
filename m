Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C711C84D0;
	Mon, 15 Jun 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484072; cv=none; b=b3wErO2zUiUGQta177qIYjq2WKWwyGYg9YM3gMIVj/oo2bOkqIPUNhJlU9qSalW3KD/fZc7olwkYoEAIzjt2DAU9R+lo6HRgZGQkH5yBN0Gxh9Azs+5NuvoUQ4ds34Y+v4z5sAAXEB6DnAn6KVV3sO1DbNEnbCjiO176iYFUhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484072; c=relaxed/simple;
	bh=rHW7iSFM1/5SccAkwiz04HAQ0dgWkBSTJyHysQPm/6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8aDCBFe46rfCAOhhkwE9QknPzH/HlX1UOXLBBEtHSykpMiRNVN0ddPH/Mo5VXhWx+j2TlxzHA0oko1acDf/8SHA6ViDrsdfxK258mqMc5TOzMXDsxZk9+x4xKelu0LR331V1YsDjLAu2/F94WH2v5aeW+CbbVDc0Gb9SWqS2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDJkSnLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDJkSnLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C51F000E9;
	Mon, 15 Jun 2026 00:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484071;
	bh=wO+xhrsIY7D9Za7HFA+jcdc+uFRy9vZxo0r3ijKBOMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BDJkSnLbAydbROsU/w2Ao1u7vkhvlnf3yIcWpGa1NWsj8v5WM9EcqfOVe4YyBmuVI
	 4TAIi1DEyQLis8OJ2a9o0m5m/5xOttqUMDDlZMifak7lBIF0OvzDkrSn0xkPHuPy3D
	 GDRpDK9IqkFHPoQdtRfP3Xm7F2ZokVnFtiKhx1LR0bF4rFQXVa3IQE9QKo4F1WJ9cc
	 Q54rzjNKu05r57NAcppKGIdufMCywYyjJmCW+weODbbymyxXpkZUgA3W4snx1b7506
	 zgp8fr53R27uqgBTo6+a+pjfv6bgiCzQ23MC5KWviAUGYoqtxE9TJnluyFbC7FGXPb
	 iQuEX01208Vrw==
Date: Mon, 15 Jun 2026 00:41:08 +0000
From: Yixun Lan <dlan@kernel.org>
To: Vincent Legoll <legoll@online.fr>
Cc: Shuwei Wu <shuwei.wu@mailbox.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: spacemit: orangepi-rv2: Add cpu scaling for
 K1, SoC
Message-ID: <20260615004108-GKA1002079@kernel.org>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
 <f031e13e-d9f5-414a-b90e-a3d5a60b8d05@online.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f031e13e-d9f5-414a-b90e-a3d5a60b8d05@online.fr>

Hi Vincent,

 Please send the patch directly instead of attached file, it's more
easy for people to review and apply, suggest to use b4, or
 "git send-email" (old way)


On 08:50 Sun 14 Jun     , Vincent Legoll wrote:
> [RESEND] as I cannot see yesterday's
> 
> 
> Hello,
> 
> 
> 
> I tested (on OrangePi RV2) the attached patch applied over
> 
> spacemit/for-next + Shuwei Wu's V3 series.
> 
> 
> This is a copy/paste of Shuwei Wu's work, so I don't know
> 
> if I can submit this with my SoB or if it should be done
> 
It's ok to add your SoB while adding support for new board

> differently, please advise.
> 
> 
> Anyways, you can add my:
> 
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # OrangePi-RV2
> 
> 
> To the relevant patches from your series, if that's useful,
> 
> because it looks like it is working properly:
> 
> 
> On Void linux (musl libc):
> 
> 
> uname -a
> Linux opirv2 7.1.0-rc1-00043-gb860bca13be4 #14 SMP PREEMPT Sat Jun 13 
> 11:02:13 CEST 2026 riscv64 GNU/Linux
> 
> awk --version | head -1
> GNU Awk 5.3.2, API 4.0
> 
> echo userspace > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
> 
> echo 1600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
> real    0m0.300s
> user    0m0.299s
> sys     0m0.001s
> 
> echo 1228800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
> real    0m0.432s
> user    0m0.429s
> sys     0m0.004s
> 
> echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
> real    0m0.476s
> user    0m0.476s
> sys     0m0.001s
> 
> echo 819000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
> real    0m0.582s
> user    0m0.581s
> sys     0m0.001s
> 
> echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
> time awk 'BEGIN{for(i=0;i<1000000;i++){}}'
> real    0m0.778s
> user    0m0.773s
> sys     0m0.005s
> 
> -- 
> 
> Vincent Legoll
> 

> From 9924789655ae5f4f98e7a5cdc3df3f34e7bfb659 Mon Sep 17 00:00:00 2001
> From: Vincent Legoll <vincent.legoll@gmail.com>
> Date: Sat, 13 Jun 2026 10:49:34 +0200
> Subject: [PATCH] riscv: dts: spacemit: orangepi-rv2: Add cpu scaling for K1
>  SoC
> 
> Enable CPU DVFS on OrangePi RV2
> 
..
> This is a copy/paste from Shuwei Wu's BPI-F3 DTS modifications
> 
It's quite common that people do copy/paste for additional board
support, no need to mention it in commit message which I think it
isn't really useful


> Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
> ---
>  .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> index 7c49bce427f3..62d25f579af6 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> @@ -8,6 +8,7 @@
>  
>  #include "k1.dtsi"
>  #include "k1-pinctrl.dtsi"
> +#include "k1-opp.dtsi"
keep alphabet sorted
>  
>  / {
>  	model = "OrangePi RV2";
> @@ -80,6 +81,38 @@ &combo_phy {
>  	status = "okay";
>  };
>  
> +&cpu_0 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_1 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_2 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_3 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_4 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_5 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_6 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
> +&cpu_7 {
> +       cpu-supply = <&buck1_0v9>;
> +};
> +
>  &emmc {
>  	bus-width = <8>;
>  	mmc-hs400-1_8v;
> @@ -162,7 +195,7 @@ pmic@41 {
>  		dldoin2-supply = <&buck5>;
>  
>  		regulators {
> -			buck1 {
> +			buck1_0v9: buck1 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3450000>;
>  				regulator-ramp-delay = <5000>;
> -- 
> 2.54.0
> 


-- 
Yixun Lan (dlan)
