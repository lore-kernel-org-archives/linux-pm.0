Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917A331A77;
	Tue, 19 May 2026 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169105; cv=none; b=DMCh6usyVG21O1meaRWrsnxE9ejx/AKFpWUYUoNsLUpvPRkDaX7b+gVtdb+xnOGf5yhC0F9jkOjJ6vJQ0INzWGwAnfoiuatSozJQa07CBIV+iXh/Ny8kZYbR1JWtfy7/j8vGUXqhZ1LpN3OdWzTdWbO4d26zctU8/lftDgloIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169105; c=relaxed/simple;
	bh=Psc9YO6boKUU786uu3Ie0bpQH19f4iilC5X7LSyJNtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw5J1w13+RQVXDwTCRlZH6hi3zqXP8vzubc1+DPHSeIqLoWTG0dPBK2AyJDX0gXLii0dkwsz3ijjJd8ZZj4YkkKQa5EcTaMvvr8pWfiS6YMPeTYuLifqlyoV2ZBlzthAu+PqagXMArBabJVp/U6AAOadvVdIe0QgFhH7fUztwV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVzASog7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVzASog7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C7C2BCB3;
	Tue, 19 May 2026 05:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779169104;
	bh=Psc9YO6boKUU786uu3Ie0bpQH19f4iilC5X7LSyJNtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVzASog7bBmivdNYQ7uhlJ7jFrpnEwd3nOg+U2fW1H9vtyIC+dJ2j52XQ7HSntd3t
	 kr3ZF17XW+EznhglwB4/qEyka5HM1BDR6uGjRAZ7Mwc9YZ8wKXnigQspT9R40/8a2z
	 OS9pj8w1+KTzqhudtyIAHAxXB4v9viig/WM2qo5m4OfKkSrt4k+kxCwfwUDeMySbPb
	 6hCgadagksm0P1a88T7sKSkio1kO5xIx95RzfhQptdm6UV28wY6J8UrW9VKTLK191E
	 Sr9Ri3Wr62G6cxwITsCgehADflooe4x2OhTwbDqmaagsGI7yHeM0Vh7FrmBrntWQ/Y
	 mSYGEA/YZouRw==
Date: Tue, 19 May 2026 05:38:21 +0000
From: Yixun Lan <dlan@kernel.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vincent Legoll <legoll@online.fr>,
	Gong Shuai <gsh517025@gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: dts: spacemit: Add thermal sensor for K1
 SoC
Message-ID: <20260519053821-GKF3679294@kernel.org>
References: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
 <20260427-k1-thermal-v5-3-df39187480ed@mailbox.org>
 <20260519002602-GKE3679294@kernel.org>
 <DIMB1PN1XURX.2SKN1XCULACU7@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIMB1PN1XURX.2SKN1XCULACU7@mailbox.org>

Hi Shuwei,

On 10:41 Tue 19 May     , Shuwei Wu wrote:
> Hi Yixun,
> 
> On Tue May 19, 2026 at 8:26 AM CST, Yixun Lan wrote:
> > Hi Shuwei,
> >
> > On 15:15 Mon 27 Apr     , Shuwei Wu wrote:
> >> Include the Thermal Sensor node in the SpacemiT K1 dtsi
> >> with definitions for registers, clocks, and interrupts.
> >> Additionally, configure thermal zones for the soc, package, gpu, and
> >> clusters to enable temperature monitoring via the thermal framework.
> >> 
> >> Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
> >> Tested-by: Gong Shuai <gsh517025@gmail.com>
> >> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
> >> 
> >> ---
> >> Changes in v2:
> >> - Update compatible to "spacemit,k1-tsensor"
> >> ---
> >>  arch/riscv/boot/dts/spacemit/k1.dtsi | 101 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 101 insertions(+)
> >> 
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> index 529ec68e9c23..e9952204224e 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> >> @@ -339,6 +339,96 @@ osc_32k: clock-32k {
> >>  		};
> >>  	};
> >>  
> >> +	thermal-zones {
> >> +		soc-thermal {
> >> +			polling-delay-passive = <0>;
> >> +			polling-delay = <0>;
> >> +			thermal-sensors = <&thermal 0>;
> >> +
> >> +			trips {
> >> +				soc-crit {
> >> +					temperature = <115000>;
> >> +					hysteresis = <0>;
> >> +					type = "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +
> >> +		package-thermal {
> >> +			polling-delay-passive = <0>;
> >> +			polling-delay = <0>;
> >> +			thermal-sensors = <&thermal 1>;
> >> +
> >> +			trips {
> >> +				package-crit {
> >> +					temperature = <115000>;
> >> +					hysteresis = <0>;
> >> +					type = "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +
> >> +		gpu-thermal {
> >> +			polling-delay-passive = <100>;
> >> +			polling-delay = <0>;
> >> +			thermal-sensors = <&thermal 2>;
> >> +
> >> +			trips {
> >> +				gpu-alert {
> >> +					temperature = <85000>;
> >> +					hysteresis = <2000>;
> >> +					type = "passive";
> >> +				};
> >> +
> >> +				gpu-crit {
> >> +					temperature = <115000>;
> >> +					hysteresis = <0>;
> >> +					type = "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +
> >> +		cluster0-thermal {
> >> +			polling-delay-passive = <100>;
> >> +			polling-delay = <0>;
> >> +			thermal-sensors = <&thermal 3>;
> >> +
> >> +			trips {
> >> +				cluster0-alert {
> >> +					temperature = <85000>;
> >> +					hysteresis = <2000>;
> >> +					type = "passive";
> >> +				};
> >> +
> >> +				cluster0-crit {
> >> +					temperature = <115000>;
> >> +					hysteresis = <0>;
> >> +					type = "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +
> >> +		cluster1-thermal {
> >> +			polling-delay-passive = <100>;
> >> +			polling-delay = <0>;
> >> +			thermal-sensors = <&thermal 4>;
> >> +
> >> +			trips {
> >> +				cluster1-alert {
> >> +					temperature = <85000>;
> >> +					hysteresis = <2000>;
> >> +					type = "passive";
> >> +				};
> >> +
> >> +				cluster1-crit {
> >> +					temperature = <115000>;
> >> +					hysteresis = <0>;
> >> +					type = "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +	};
> >> +
> >>  	soc {
> >>  		compatible = "simple-bus";
> >>  		interrupt-parent = <&plic>;
> >> @@ -494,6 +584,17 @@ syscon_apbc: system-controller@d4015000 {
> >>  			#reset-cells = <1>;
> >>  		};
> >>  
> >> +		thermal: thermal@d4018000 {
> >> +			compatible = "spacemit,k1-tsensor";
> >> +			reg = <0x0 0xd4018000 0x0 0x100>;
> >> +			clocks = <&syscon_apbc CLK_TSEN>,
> >> +				 <&syscon_apbc CLK_TSEN_BUS>;
> >> +			clock-names = "core", "bus";
> >> +			interrupts = <61>;
> >> +			resets = <&syscon_apbc RESET_TSEN>;
> >> +			#thermal-sensor-cells = <1>;
> >> +		};
> > Ok, so if I understand correctly the thermal is a SoC feature, so with
> > above it will be enabled by default for all boards, but for the convention
> > we usually disable it in dtsi file, and enable it at board dts level
> >
> > Please convince me doing above is better? as I'm not sure if there is
> > cases that user want it disabled (but could possible)..
> 
> I had two reasons for keeping the thermal node enabled in k1.dtsi,
> rather than requiring each board to opt in:
> 
> 1. Other SoCs follow the same pattern: the RISC-V JH7110 and Allwinner D1s
> both define their thermal sensor nodes and thermal-zones in the SoC dtsi
> without status = "disabled".
> 
> 2. Thermal protection is safety-critical, and the silicon trip points
> don't vary between boards. Leaving it disabled by default risks boards
> booting without thermal shutdown.
> 
Ok, sounds good to me, I will queue it unless objection from others

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
