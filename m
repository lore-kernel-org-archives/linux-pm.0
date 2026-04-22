Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD393B27E2;
	Wed, 22 Apr 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854272; cv=none; b=pk89ML/NoSarfbYXdtgabc1FA1aJ93v79F5EB2pfu5grFCnb6W7DPytvJjXV+iiNwaGRcWCdTvyOPlCE0PPTTiBqoGSeXR6y8nadIyKHayYJU4OhYjAygoaryeHDAst7JdeUoTwtTLT1U9Q13ty9fGRL0PMmcK/1e4v/Dlao+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854272; c=relaxed/simple;
	bh=xWpDigKY+Mqp0QNsnqMxN5XBsR0RUwgIQEbgjXFLty8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TDpq1fz498YuQRny/eX1oK3uXfXtFN3ZIqru5rQUICNvwqRjWminH9tTFpFUZt/XI7JF2JZFmd7hnNUnc2FUY5irJsqF4DNSktCELnlfh4hIqYdqBJLk2stqUGtHd6iYN7pvb5ChIEHJHnPFiHYzie95g0ZPSjaUS9wUffsy7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=veBpZvMR; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="veBpZvMR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g0wfB6CyNz9v1C;
	Wed, 22 Apr 2026 12:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1776854258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6sdjhyBhlH5eqfCOIKrgMghdQWTDW4fIojwdQkw/6cw=;
	b=veBpZvMRGxlfD9Rl00PhTcly0LB6QbXCDw5ywa7A1bMPl94W/FqrvYDAZPt/RtPscrY+NI
	owRV8OnJCoVoBGcayfofwrKbDmjsLmImesrY2VwncSRzQD55t8GS2e66pEctZjj+AegnZx
	ivP0PDOAggr8+kABJ5vF6zRuaLnOgsAaXbWsGAgVmKzyP64OebKJgkCsWFeHRuDXI1SV5I
	H9QFT5gIAi8EoTODf83YRmfqAGCmDWR7PsyEW8O/UVS8nlPpFtKC6MqKTJDRytpJ2OvBGE
	dBZvzkRz0yfmc2skkB0eyLgHQsOXSwpjiBryiyLTIJfSs3B3HKmyrnyPI8Uk/Q==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 18:37:20 +0800
Message-Id: <DHZM9D696P6G.NVPMN20XXM3H@mailbox.org>
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Anand Moon" <linux.amoon@gmail.com>, "Shuwei Wu" <shuweiwoo@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Yixun Lan" <dlan@gentoo.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: Add thermal sensor for K1
 SoC
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com>
 <20260119-patchv2-k1-thermal-v3-3-3d82c9ebe8a4@163.com>
 <CANAwSgTOmbb+Vzhck1riVaFM89zYLdMe3dn6DRHrc7p+rkR2DQ@mail.gmail.com>
In-Reply-To: <CANAwSgTOmbb+Vzhck1riVaFM89zYLdMe3dn6DRHrc7p+rkR2DQ@mail.gmail.com>
X-MBO-RS-ID: 8c13cdb3ffab5188b99
X-MBO-RS-META: 8qb7nhuijnrjcpn5ghg44wzykgeabcef

Hi Anand,

Thank you for the careful review.

On Wed Apr 22, 2026 at 1:56 PM CST, Anand Moon wrote:
> Hi Shuwei,
>
> On Mon, 19 Jan 2026 at 08:13, Shuwei Wu <shuweiwoo@163.com> wrote:
>>
>> Include the Thermal Sensor node in the SpacemiT K1 dtsi
>> with definitions for registers, clocks, and interrupts.
>> Additionally, configure thermal zones for the soc, package, gpu, and
>> clusters to enable temperature monitoring via the thermal framework.
>>
>> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
>> ---
>> Changes in v2:
>> - Update compatible to "spacemit,k1-tsensor"
>> ---
>>  arch/riscv/boot/dts/spacemit/k1.dtsi | 101 ++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 101 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/=
spacemit/k1.dtsi
>> index 7818ca4979b6..0fe7396ea6e4 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -338,6 +338,96 @@ osc_32k: clock-32k {
>>                 };
>>         };
>>
> I feel the thermal zones appear to be configured at significantly
> higher temperatures
> compared to the thresholds typically used in commercial-grade and
> industrial-grade device
> test environments 1.2 Test Environment
>
> [1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=
=3Dhardware/key_stone/k1/k1_hw/avl_veri_sop.md

The official definition of this temperature range is as follows:
"The CPU delivers stable and reliable computing power from -40=C2=B0C to 85=
=C2=B0C,
complying with the demanding requirements of industrial applications."

[1] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=3Dh=
ardware/key_stone
/k1/k1_docs/root_overview.md

Therefore, this does not mean that the chip cannot continue to work above
this temperature.

The datasheet also defines another temperature, the Junction Temperature,
which represents the chip's temperature limit. Exceeding this temperature
may permanently damage the chip.

[2] https://www.spacemit.com/community/document/info?lang=3Den&nodepath=3Dh=
ardware/key_stone
/k1/k1_docs/k1_usermanual/4.Electrical_Characteristics.md

>
> Thermal zones should be defined as part of the SBC board design,
> with the option to integrate PWM-controlled fan support in the future.

These thermal zones describe fixed hardware properties of the K1 SoC itself=
,
and are common for all K1-based boards.

And this is also done in Allwinner D1, StarFive JH7110 and some other chips=
.

>
> Thanks
> -Anand
>> +       thermal-zones {
>> +               soc-thermal {
>> +                       polling-delay-passive =3D <0>;
>> +                       polling-delay =3D <0>;
>> +                       thermal-sensors =3D <&thermal 0>;
>> +
>> +                       trips {
>> +                               soc-crit {
>> +                                       temperature =3D <115000>;
>> +                                       hysteresis =3D <0>;
>> +                                       type =3D "critical";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               package-thermal {
>> +                       polling-delay-passive =3D <0>;
>> +                       polling-delay =3D <0>;
>> +                       thermal-sensors =3D <&thermal 1>;
>> +
>> +                       trips {
>> +                               package-crit {
>> +                                       temperature =3D <115000>;
>> +                                       hysteresis =3D <0>;
>> +                                       type =3D "critical";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               gpu-thermal {
>> +                       polling-delay-passive =3D <100>;
>> +                       polling-delay =3D <0>;
>> +                       thermal-sensors =3D <&thermal 2>;
>> +
>> +                       trips {
>> +                               gpu-alert {
>> +                                       temperature =3D <85000>;
>> +                                       hysteresis =3D <2000>;
>> +                                       type =3D "passive";
>> +                               };
>> +
>> +                               gpu-crit {
>> +                                       temperature =3D <115000>;
>> +                                       hysteresis =3D <0>;
>> +                                       type =3D "critical";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               cluster0-thermal {
>> +                       polling-delay-passive =3D <100>;
>> +                       polling-delay =3D <0>;
>> +                       thermal-sensors =3D <&thermal 3>;
>> +
>> +                       trips {
>> +                               cluster0-alert {
>> +                                       temperature =3D <85000>;
>> +                                       hysteresis =3D <2000>;
>> +                                       type =3D "passive";
>> +                               };
>> +
>> +                               cluster0-crit {
>> +                                       temperature =3D <115000>;
>> +                                       hysteresis =3D <0>;
>> +                                       type =3D "critical";
>> +                               };
>> +                       };
>> +               };
>> +
>> +               cluster1-thermal {
>> +                       polling-delay-passive =3D <100>;
>> +                       polling-delay =3D <0>;
>> +                       thermal-sensors =3D <&thermal 4>;
>> +
>> +                       trips {
>> +                               cluster1-alert {
>> +                                       temperature =3D <85000>;
>> +                                       hysteresis =3D <2000>;
>> +                                       type =3D "passive";
>> +                               };
>> +
>> +                               cluster1-crit {
>> +                                       temperature =3D <115000>;
>> +                                       hysteresis =3D <0>;
>> +                                       type =3D "critical";
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>>         soc {
>>                 compatible =3D "simple-bus";
>>                 interrupt-parent =3D <&plic>;
>> @@ -434,6 +524,17 @@ syscon_apbc: system-controller@d4015000 {
>>                         #reset-cells =3D <1>;
>>                 };
>>
>> +               thermal: thermal@d4018000 {
>> +                       compatible =3D "spacemit,k1-tsensor";
>> +                       reg =3D <0x0 0xd4018000 0x0 0x100>;
>> +                       clocks =3D <&syscon_apbc CLK_TSEN>,
>> +                                <&syscon_apbc CLK_TSEN_BUS>;
>> +                       clock-names =3D "core", "bus";
>> +                       interrupts =3D <61>;
>> +                       resets =3D <&syscon_apbc RESET_TSEN>;
>> +                       #thermal-sensor-cells =3D <1>;
>> +               };
>> +
>>                 i2c6: i2c@d4018800 {
>>                         compatible =3D "spacemit,k1-i2c";
>>                         reg =3D <0x0 0xd4018800 0x0 0x38>;
>>
>> --
>> 2.52.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

--=20
Best regards,
Shuwei Wu
