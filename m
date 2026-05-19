Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE52DCBEC;
	Tue, 19 May 2026 02:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158517; cv=none; b=qTTioAxLitFJFXNz2AoHcDpZjJEb6xAnXt56GCgxVlzk4ttN0pBDc7sAyVeETs4juPj+Z2Wmvj0ECxP6bAVWtEQOO6/+o97gqbRkDFVIX47JJZqKlNYKhu4d07ksDOkSO90Rj1y1H2k5O51oZzNlFExoApm06Erb+Tm6fLCQrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158517; c=relaxed/simple;
	bh=R0bw45W4CGsbembmwVaCzRAcowRsSDgWPJsqgFxagAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=h1hFSlpCXaeyvagr7a1yAqMpbPaVccUDMzJOgf5/GeWVMXWqRBJUOkzh/XF81TsmCLJhSPMaHrIPU3d9M44UdCrazOB4OhOQ7pgJttDo36qXv1wd2zQhGjubQ305JcsWU6f2p0mlqk4LFLEAm7mcD2ypJVX1vciuUsW0C5Lj7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Zk5jYLge; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Zk5jYLge"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gKJpl2Z2Vz9v86;
	Tue, 19 May 2026 04:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779158512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bDcRH1NI5ohQC+8+KyXW8eoTp/NLzHa6GAXlQDvIRGo=;
	b=Zk5jYLgezbUaeotn+EN1Af21OuqAYuWUYfpzSTIhirx7abiMuM8yP5JWHDwnqCpzVyCnFv
	8Gig1TpFtxTNadWAdpvDlvuAVb62sSD0ZJK1jAMZKcMe7SUGGjYF+PFZRmZNA6lbAn/2Hb
	aHo3Qa4MbnyczPDG4FMGDCScl/LAET0BKyhEQ6dJn/ASJCxI61KnVtTZurAMgKDAbE1szw
	+MlE1M5B2xODK5690RFdle8g6oVXGNCzUl3rBj+eskBvGAi9rLw1dHhWhfSDxEQch1mZT5
	rv2HNctFuKV3Mc7mLiytV682F7+m42xwVbbFqI/Qzh2OF7gkAoUfecX3d/EN+A==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 10:41:27 +0800
Message-Id: <DIMB1PN1XURX.2SKN1XCULACU7@mailbox.org>
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Yixun Lan" <dlan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Vincent
 Legoll" <legoll@online.fr>, "Gong Shuai" <gsh517025@gmail.com>
Subject: Re: [PATCH v5 3/3] riscv: dts: spacemit: Add thermal sensor for K1
 SoC
References: <20260427-k1-thermal-v5-0-df39187480ed@mailbox.org>
 <20260427-k1-thermal-v5-3-df39187480ed@mailbox.org>
 <20260519002602-GKE3679294@kernel.org>
In-Reply-To: <20260519002602-GKE3679294@kernel.org>
X-MBO-RS-META: a8gyojcb1u79paamze3ow1xuowf3feiy
X-MBO-RS-ID: c3256d9df03ab1dced4

Hi Yixun,

On Tue May 19, 2026 at 8:26 AM CST, Yixun Lan wrote:
> Hi Shuwei,
>
> On 15:15 Mon 27 Apr     , Shuwei Wu wrote:
>> Include the Thermal Sensor node in the SpacemiT K1 dtsi
>> with definitions for registers, clocks, and interrupts.
>> Additionally, configure thermal zones for the soc, package, gpu, and
>> clusters to enable temperature monitoring via the thermal framework.
>>=20
>> Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2
>> Tested-by: Gong Shuai <gsh517025@gmail.com>
>> Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
>>=20
>> ---
>> Changes in v2:
>> - Update compatible to "spacemit,k1-tsensor"
>> ---
>>  arch/riscv/boot/dts/spacemit/k1.dtsi | 101 ++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 101 insertions(+)
>>=20
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/=
spacemit/k1.dtsi
>> index 529ec68e9c23..e9952204224e 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -339,6 +339,96 @@ osc_32k: clock-32k {
>>  		};
>>  	};
>> =20
>> +	thermal-zones {
>> +		soc-thermal {
>> +			polling-delay-passive =3D <0>;
>> +			polling-delay =3D <0>;
>> +			thermal-sensors =3D <&thermal 0>;
>> +
>> +			trips {
>> +				soc-crit {
>> +					temperature =3D <115000>;
>> +					hysteresis =3D <0>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		package-thermal {
>> +			polling-delay-passive =3D <0>;
>> +			polling-delay =3D <0>;
>> +			thermal-sensors =3D <&thermal 1>;
>> +
>> +			trips {
>> +				package-crit {
>> +					temperature =3D <115000>;
>> +					hysteresis =3D <0>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		gpu-thermal {
>> +			polling-delay-passive =3D <100>;
>> +			polling-delay =3D <0>;
>> +			thermal-sensors =3D <&thermal 2>;
>> +
>> +			trips {
>> +				gpu-alert {
>> +					temperature =3D <85000>;
>> +					hysteresis =3D <2000>;
>> +					type =3D "passive";
>> +				};
>> +
>> +				gpu-crit {
>> +					temperature =3D <115000>;
>> +					hysteresis =3D <0>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		cluster0-thermal {
>> +			polling-delay-passive =3D <100>;
>> +			polling-delay =3D <0>;
>> +			thermal-sensors =3D <&thermal 3>;
>> +
>> +			trips {
>> +				cluster0-alert {
>> +					temperature =3D <85000>;
>> +					hysteresis =3D <2000>;
>> +					type =3D "passive";
>> +				};
>> +
>> +				cluster0-crit {
>> +					temperature =3D <115000>;
>> +					hysteresis =3D <0>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +
>> +		cluster1-thermal {
>> +			polling-delay-passive =3D <100>;
>> +			polling-delay =3D <0>;
>> +			thermal-sensors =3D <&thermal 4>;
>> +
>> +			trips {
>> +				cluster1-alert {
>> +					temperature =3D <85000>;
>> +					hysteresis =3D <2000>;
>> +					type =3D "passive";
>> +				};
>> +
>> +				cluster1-crit {
>> +					temperature =3D <115000>;
>> +					hysteresis =3D <0>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>  	soc {
>>  		compatible =3D "simple-bus";
>>  		interrupt-parent =3D <&plic>;
>> @@ -494,6 +584,17 @@ syscon_apbc: system-controller@d4015000 {
>>  			#reset-cells =3D <1>;
>>  		};
>> =20
>> +		thermal: thermal@d4018000 {
>> +			compatible =3D "spacemit,k1-tsensor";
>> +			reg =3D <0x0 0xd4018000 0x0 0x100>;
>> +			clocks =3D <&syscon_apbc CLK_TSEN>,
>> +				 <&syscon_apbc CLK_TSEN_BUS>;
>> +			clock-names =3D "core", "bus";
>> +			interrupts =3D <61>;
>> +			resets =3D <&syscon_apbc RESET_TSEN>;
>> +			#thermal-sensor-cells =3D <1>;
>> +		};
> Ok, so if I understand correctly the thermal is a SoC feature, so with
> above it will be enabled by default for all boards, but for the conventio=
n
> we usually disable it in dtsi file, and enable it at board dts level
>
> Please convince me doing above is better? as I'm not sure if there is
> cases that user want it disabled (but could possible)..

I had two reasons for keeping the thermal node enabled in k1.dtsi,
rather than requiring each board to opt in:

1. Other SoCs follow the same pattern: the RISC-V JH7110 and Allwinner D1s
both define their thermal sensor nodes and thermal-zones in the SoC dtsi
without status =3D "disabled".

2. Thermal protection is safety-critical, and the silicon trip points
don't vary between boards. Leaving it disabled by default risks boards
booting without thermal shutdown.

--=20
Best regards,
Shuwei Wu
