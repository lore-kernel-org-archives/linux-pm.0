Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4512C15A0
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 05:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837436; cv=pass; b=fHF0iX3cEkzknhKod1Hm9NW8BPjs15GRwDsAKWKeuJB2HT/6Y5pU1TGpdtLmuZfUMl+01P+O0DgtiGly5GpD06uv4iBcMt4MvLNj5vCNLUkI7I8QDIIEqBYq/I5cEaSdkr/p1IPq4vjE+1tKQGa3U07mNA0VasTmRpGdqRQALEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837436; c=relaxed/simple;
	bh=son5GUfBCXkJka3b7rHSwRZcR0H7LmRjWetn/EiAmVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBlh1APedSXPzc9eoNF/adV03eS8DjAeb8wG07Tbl3uoy8/jzbBvUylwOsqTZRX/SHelCGuQcPJYs2LIeTHyxILtmYqD4C3GCA19AYo+xSB3n474/nW1EZKu2gwAiGpZlp627uZow7+H5yhGs2Jc+M3tgFkvgayYBnpNWhfB8pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwWZfu9d; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwWZfu9d"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so603588766b.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 22:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776837432; cv=none;
        d=google.com; s=arc-20240605;
        b=BEC7yQI/0VkN5GiO6VlN3LcBx7nrMDZ6IpilXEdU90qY9ykDek1if1qoAKRXsMrgtQ
         x96A4gQPsK8xq4QwoL6V5VjrbWWUXYKZF9I/mvzNXeo1hbBfZXgdN9oWXMhTD1kcdWAe
         bN6FXH9ts8j+k7wKSTGDNwuyHYnlc6pAdi0MJcLQ/Meh6jpr5AtbdRdg78gcVcwzBzLC
         89AET+N8MYihHFlR9AUtwSObWuv+D1gFJNWzvcexO4Vs9jWpoHbgimIbfQq1c5BKuhM2
         bVtZrQyTM4ihK/CrU09lmkLBiRmZuFPkIPYFhJoCujO6A8zAY/eTPiZ4KSExZ70gmctr
         D8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6mfQrHmJg8pkYiq0O9V0bit0vPU2fxUi56Y7yDGTSLA=;
        fh=t3oGFVpwNj5cfAwxK0k4fI0/wb4s/PolyoFeQVxCHC8=;
        b=SYaXAHgbSI/u0Rvs1HqAORFdUW/nWMIYcIGcI6g0UWy5riMyxb8dcmaznQ9PG+oLIw
         H9T3OF01fWc5BTSN6v738kyDGOYEiLbTowIhrkmfV3kxKilYoUZlyQEuaGp3UDMvWZ+G
         ancs/Hhh1IiErP2fpcoOcgiZTKybBSJcZvl40OgpkCywPtEg6wLUHnWalLGlfmAc9guv
         kbrtrRiJ7SPOjeF7TBL9VHMSlHRnUd146Yid09gs3/tCRWdhMDs7TeqkM++fSNXXwbyQ
         fi9DLQKcwRKOaXT1OSRKE/43+nxavxHOc8Fpt+ZbWTOT+V2Cp0yZbyV4kzyQt4KWi4Yn
         f4OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776837432; x=1777442232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6mfQrHmJg8pkYiq0O9V0bit0vPU2fxUi56Y7yDGTSLA=;
        b=FwWZfu9dRVT99gz2CjUN93mRoFXQLjyqUuYqhqrRvqzrbkRuQIeasHYpcAL7/h82Pe
         uAmK+xC8F37G8Sb2fHEq8kKdX6EeHjNb1etpnO9pCSNbbpGLLNbjWwVyJ7B1WdRaIoOv
         KunOF5r5Fc8zPPIOyFkYlM+lAVI9KCB6X75GgQFepfKLV7VoRlA+jIoBFRNKh6l71sWx
         u563VV94qGXjpf8K8IFld/s3FI2ydL2KDLN50ntjIeIiiDnbWfDVaycVMunxyTwtk/Ry
         5mKg7kY67d/mTlfZQVTYr+v8iqcxS4tEuHReyG0Ixa8N/mJeZmdHUJsVZxj9e2NysDl8
         09+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837432; x=1777442232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mfQrHmJg8pkYiq0O9V0bit0vPU2fxUi56Y7yDGTSLA=;
        b=SUs6Ny9yvKUjxPOTjqySHfi0DhjBlxp+OP7Mjxzg1AhXuYdV6Jz2wOZY/VEXg/p66E
         wH3CJY0UCKtHubiPc1t9J+C2LMTKJY8wtgLo5mX9fEgFtUkfpMT1uZC5wypqVVmdAUuG
         ap533QtwRlvEfONczBdpNHYV+DV1n/KKT6jqmfkYFetz7bd0Ji/pBqkl6zF/ecpYsEDQ
         z1Wd25eJ4CeRcjt3H6eEvwbNZtr0JyOqz5L0Ka6QRs8Jp65+5WURXDPY5gNzFNeisxgR
         UDrhZRRkt0fElWwbBfjklKX7jktcGoQEsWcDNgao18BW5jbAAMfVwnZALW5atPvHseFS
         +d6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/74pREKLydIPt/h+/OAQyttgZraOZWsu1swz5txqaKtzzEKZIgU3Awg4yg8BK4B5xyEmqeQQYhqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9OIjaRi7ffTQ3VxEHuG/L1smTq3ue1imtNGj+8t2xvJ89tnm
	LSeDVXyqXQiY53zIg1XnrO7pbidiZZkChINiOFzokYWsMIFositrl/X+jhhCfUmL7fm1cgvItrT
	Z1g6Zm+ELEj3A1m+U7iWqqmBX7lyrPJo=
X-Gm-Gg: AeBDievD2nR1EY9rOC80sG+GcP9fkUfJ5kz8RS7bp9ywhYNg+cZMu+9ETuhq0nPskAV
	k9jT2vKKj6Bzmks5V0YhmjR/opGWZ1po5Yeyhj3XnTULKz+kC+A9HpLK/j/ajmFTM/JYvOKQtoG
	hv1gIkOFTaYsPCauo//lCVQCIDJW780Wm2+aG/pTd1uFwbFdE+RdfTWX4YvyJuJi9ZTJIlIkIXN
	qNkmyJD6t6W0wpL4fQLB3m5G9r08VuyQaP3R7NiowxotQm9Lgkc93ZMD6B+RP8X2pxKvFlb8O2z
	DWXhc17gqUGLOJo=
X-Received: by 2002:a17:907:d09:b0:ba7:7a1f:1096 with SMTP id
 a640c23a62f3a-ba77a1f52a9mr604591266b.19.1776837432114; Tue, 21 Apr 2026
 22:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-patchv2-k1-thermal-v3-0-3d82c9ebe8a4@163.com> <20260119-patchv2-k1-thermal-v3-3-3d82c9ebe8a4@163.com>
In-Reply-To: <20260119-patchv2-k1-thermal-v3-3-3d82c9ebe8a4@163.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 22 Apr 2026 11:26:56 +0530
X-Gm-Features: AQROBzAs7FAeBD4enf-d2fMmvL5o4M1AgFGifNPyDM3Z4riMQcMNULcXuvp1c4I
Message-ID: <CANAwSgTOmbb+Vzhck1riVaFM89zYLdMe3dn6DRHrc7p+rkR2DQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: spacemit: Add thermal sensor for K1 SoC
To: Shuwei Wu <shuweiwoo@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shuwei,

On Mon, 19 Jan 2026 at 08:13, Shuwei Wu <shuweiwoo@163.com> wrote:
>
> Include the Thermal Sensor node in the SpacemiT K1 dtsi
> with definitions for registers, clocks, and interrupts.
> Additionally, configure thermal zones for the soc, package, gpu, and
> clusters to enable temperature monitoring via the thermal framework.
>
> Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
> ---
> Changes in v2:
> - Update compatible to "spacemit,k1-tsensor"
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 101 +++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index 7818ca4979b6..0fe7396ea6e4 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -338,6 +338,96 @@ osc_32k: clock-32k {
>                 };
>         };
>
I feel the thermal zones appear to be configured at significantly
higher temperatures
compared to the thresholds typically used in commercial-grade and
industrial-grade device
test environments 1.2 Test Environment

[1] https://www.spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k1/k1_hw/avl_veri_sop.md

Thermal zones should be defined as part of the SBC board design,
with the option to integrate PWM-controlled fan support in the future.

Thanks
-Anand
> +       thermal-zones {
> +               soc-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&thermal 0>;
> +
> +                       trips {
> +                               soc-crit {
> +                                       temperature = <115000>;
> +                                       hysteresis = <0>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               package-thermal {
> +                       polling-delay-passive = <0>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&thermal 1>;
> +
> +                       trips {
> +                               package-crit {
> +                                       temperature = <115000>;
> +                                       hysteresis = <0>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               gpu-thermal {
> +                       polling-delay-passive = <100>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&thermal 2>;
> +
> +                       trips {
> +                               gpu-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               gpu-crit {
> +                                       temperature = <115000>;
> +                                       hysteresis = <0>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cluster0-thermal {
> +                       polling-delay-passive = <100>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&thermal 3>;
> +
> +                       trips {
> +                               cluster0-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cluster0-crit {
> +                                       temperature = <115000>;
> +                                       hysteresis = <0>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +
> +               cluster1-thermal {
> +                       polling-delay-passive = <100>;
> +                       polling-delay = <0>;
> +                       thermal-sensors = <&thermal 4>;
> +
> +                       trips {
> +                               cluster1-alert {
> +                                       temperature = <85000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +
> +                               cluster1-crit {
> +                                       temperature = <115000>;
> +                                       hysteresis = <0>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +       };
> +
>         soc {
>                 compatible = "simple-bus";
>                 interrupt-parent = <&plic>;
> @@ -434,6 +524,17 @@ syscon_apbc: system-controller@d4015000 {
>                         #reset-cells = <1>;
>                 };
>
> +               thermal: thermal@d4018000 {
> +                       compatible = "spacemit,k1-tsensor";
> +                       reg = <0x0 0xd4018000 0x0 0x100>;
> +                       clocks = <&syscon_apbc CLK_TSEN>,
> +                                <&syscon_apbc CLK_TSEN_BUS>;
> +                       clock-names = "core", "bus";
> +                       interrupts = <61>;
> +                       resets = <&syscon_apbc RESET_TSEN>;
> +                       #thermal-sensor-cells = <1>;
> +               };
> +
>                 i2c6: i2c@d4018800 {
>                         compatible = "spacemit,k1-i2c";
>                         reg = <0x0 0xd4018800 0x0 0x38>;
>
> --
> 2.52.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
