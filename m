Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFD38836C
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531987; cv=pass; b=CHyBJ8WkG01bh37Fgjf7dAfuB7MczF3dUxELJrcf+dr00w3vHLwRcfVpz01S0k+fJ/mBZKgJLyuYu39USFABI2BsbgbUl29h42puaw238Whje34uqEDndKD2XAzxlcAPntXWepJlGEOMWn6vEBw4dWci4A/ozgJ068e9iN1akQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531987; c=relaxed/simple;
	bh=0gRN2SakYbEgJc/3ZWGnLbXr3HCroechbpStJaaI808=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTYYmd1n70n5eGano4A6VucW24jWzcpX+Nc1klPwFvsQ2qpI1pBYklRaVXnA2uR7+xYW8HUWY3CX7/xDAlt1jKurydo0WW0Cl5KI+mAdrcMpALgd1Dg+uQnolpAcMtpFQKGjWz4Mm+PPpJX4jrB3uNNAq4rXollOlDhrm9UnANQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRV6jeJ0; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRV6jeJ0"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5350cc60b51so59959131cf.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 00:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791531985; cv=none;
        d=google.com; s=arc-20260327;
        b=LbmczM2KWQb9yapMlBqOqvkIBto4CP0kasB4iVVgS+tbqUpONv9mjVgUmuHUM/q2Rb
         tpCPQXRrNWT7CmWlrrs7FO4dRXH9jsC2kHR2zdqYCH5Ob8HKEXnOECDw/uNjT1CP6wMr
         MKOE4uwezdtx6pRqv9VMAeZR9uCQmGQGRm0ts4JDX6ObUOs2ULobt6aSI2Lhhnqn8fRM
         YFczcsEzMaCyzb2VwgdyNQ+4JNnNVnBR3iHy4ZzBUl9RrBeNutAtaIdBbDw7FFv9GY7j
         IUb8+rN5H4/DgAbUGuA7xqgCVGU8v0DmcC2bHxvBmCq7TJ14XdOmECNnD29k6y59RlTO
         a8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IhbhXrSuqXoly0LP+ZlIux6BvCSs3BvpYjEi3pYxM6E=;
        fh=m32Xao2oB0VG8JAMsHvx12eJsBWKNuwZ8HrRwTSmcBw=;
        b=jajZQW5A+SRVnM3Ikp1A6lcQvijLUNS/S/jdkLC3ZOUMF8ImpK+K+y2cwCtXFPIxGi
         8ceOImuuWTeGBwSYlqvDBaXLgDKaAJjZRiDiGk4qJZgoC9+fqCji32ZcABtqtkfat4Yj
         its/JvoIondC9QpAd+2WXdxWm19k4Vo+KQEZUuRcyUkVDx6Dd0AYwy059BQaBIX2EZan
         Y8LLsenr8FZ9oEt2e6Z5J65442xj/OVy8evLp+Y0bVph7GSe8P5goPfXhAUkE9Nhse18
         WLuxNDIdVFYA0I+CzwMR1AK07W210BgBFMwPDXeJoMxqcNATZ09Sjln3GsR50upInwQS
         PBFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531985; x=1792136785; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IhbhXrSuqXoly0LP+ZlIux6BvCSs3BvpYjEi3pYxM6E=;
        b=KRV6jeJ0kIlXGoyfazccjIuPBD+0kcgmq9FyawAchST3ThtywFwF03gwOMBUKPVb7y
         s9U5+RCiJKIiG2kdNF5lYwTvQxH4lyVU753uRn5JbKX/7C0yNYCO/ml7FSB1Pr1LFU+7
         +X91Wuxa1S6pnB0+pdvrTvT834Zhq48te/477IzHnGeFHDdsQuz8pvyBGXS/sucHkriJ
         a5fddnyjDS5KPdd431dUPujZIHHcXR380LLvPOW8eLc+EJxmF118z+GL5HzGc6kVGaR9
         diVqs/wxYaHFyGx1b8GSJkyZLCmGjVtB9mtbJQFrBBQjHCdjKbVbGZfW2GV9My1UbUKO
         5XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531985; x=1792136785;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IhbhXrSuqXoly0LP+ZlIux6BvCSs3BvpYjEi3pYxM6E=;
        b=mK3F2lu57yf52WqJukcGJ7qOdzTXdghT6IErsEL45g83XXv0IceTQgrMnsTdRBPjxY
         r9S5PnbncrTD4DbkZlj50zVjXqVpppdPzpAJPo1idiiSIFCuWx/HVHJKfARAsohrvVvN
         Ah+UDZROktZ+MbfEApxTQORRCtgxjcPuytDem0To4ClxB9F+cjRXJUuP1SyHQSq1tbdi
         6HqPq1MQcd7P6Wz1Xw+ogJrt9dnWMz7U27+FXllZmZ9/IGDSYcQHeGlAck03X9pmXo9i
         SjT7sWZ5W3CdmZh4EV/+VHrTpJ1MXr1JdCfpEzGqkBasVYLkfOeONBKD3hcmvcizHNDK
         PCbA==
X-Forwarded-Encrypted: i=1; AKwUvBzUFXyMcIb4ZuINrT+cUjdJH/tDv61Q4B4PcxAgampcj1Ys5Aa2Dx0iRgWHbH7QWtmKHtTDW9VUig==@vger.kernel.org
X-Gm-Message-State: AFuF++kexokRWRRqr5j7AYS4IeFDXyk62Yl2BEzYyPa2SfNQr53SxjHG
	BHm1WMUmmQCxYmaqu1eIYUVFG1l3p7L/l1V4Y/DRSOzIGCW8o3RIL9Rd+KdctF0X4AKnY62Xn7u
	vQ2C/8puMaqEW4YCfTxA5ifCrTlcxvGo=
X-Gm-Gg: AYBFou2EL5mt6ngxuOtbwpj4aGbpiMtAVf5ixJjifWL305BGH/yDu5j7nuHLC4DVhIT
	XbbgVmWH9XJmii0n0E4xK4EJrvxCug/HtaTlQY6Xguk0i6/PwFraLXY/Xq5X9ycZ/ZyxYvWSiah
	8u7hevcXQYQlknu1OEdwqkyY3HrzJxf0mF6e6+cdEdxBNu2pc/R/w7BztZcGlcs4bYkexTvq6SK
	cnciW+mbRW03EasN0rGrbzguGekLxHUwddiQjfMulAh/dfo4Z0iA2QFtwM5HQy2YlfeyA3QRnXw
	9XDsDG4omtPcXN+5loEpBu7hqI+2Q32QU1aCy7z6+DOvRk584zEWKSSqiMxdoON0nm+BSoGjlaN
	vTPkKxW4r2Q==
X-Received: by 2002:a05:622a:e18f:20b0:535:a5f7:d593 with SMTP id
 d75a77b69052e-535a5f7deabmr2793261cf.77.1791531984791; Fri, 09 Oct 2026
 00:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810143057.651478-1-ansuelsmth@gmail.com> <20260810143057.651478-2-ansuelsmth@gmail.com>
 <20260817-strange-belligerent-gazelle-d55c5c@quoll>
In-Reply-To: <20260817-strange-belligerent-gazelle-d55c5c@quoll>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Fri, 9 Oct 2026 09:46:11 +0200
X-Gm-Features: AclHuK-f0LLvQaXw4HZlaL3j-e2e5sO13kwV5bV5TdRjah04dpSMzW4-ITExMkA
Message-ID: <CA+_ehUwTH-mn2p44Qi=TGi+55PngRra=3Ovf3mCUv8ZZ=Cky4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: add Airoha SoC devfreq driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 17 ago 2026 alle ore 09:46 Krzysztof Kozlowski
<krzk@kernel.org> ha scritto:
>
> On Mon, Aug 10, 2026 at 04:30:55PM +0200, Christian Marangi wrote:
> > Add simple Airoha SoC devfreq driver. This simple driver register a
> > driver from a given clock and register a passive governor to scale the
> > frequency with the CPU frequency.
> >
> > required-opp on the CPU frequency will be used to correctly bind the
> > clock to the related CPU frequency.
> >
> > GSW, NPU, SOE, BUS and many other clock will register this devfreq
> > driver to scale all these internal peripheral  from idle to performance
> > mode.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/devfreq/Kconfig          | 10 ++++
> >  drivers/devfreq/Makefile         |  1 +
> >  drivers/devfreq/airoha-devfreq.c | 99 ++++++++++++++++++++++++++++++++
> >  3 files changed, 110 insertions(+)
> >  create mode 100644 drivers/devfreq/airoha-devfreq.c
> >
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index c999c4a1e567..1e857a7e9caf 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -75,6 +75,16 @@ config DEVFREQ_GOV_PASSIVE
> >
> >  comment "DEVFREQ Drivers"
> >
> > +config ARM_AIROHA_DEVFREQ
> > +     tristate "Scaling support for Airoha SoC"
> > +     depends on ARCH_AIROHA || COMPILE_TEST
> > +     select DEVFREQ_GOV_PASSIVE
> > +     help
> > +       This adds the DEVFREQ driver for the Airoha SoC.
> > +
> > +       The driver register with the cpufreq notifier and find the right frequency
> > +       based on the required OPP set in DT.
> > +
> >  config ARM_EXYNOS_BUS_DEVFREQ
> >       tristate "ARM Exynos Generic Memory Bus DEVFREQ Driver"
> >       depends on ARCH_EXYNOS || COMPILE_TEST
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 404179d79a9d..5ca27684dee3 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -8,6 +8,7 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)   += governor_userspace.o
> >  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)    += governor_passive.o
> >
> >  # DEVFREQ Drivers
> > +obj-$(CONFIG_ARM_AIROHA_DEVFREQ)     += airoha-devfreq.o
> >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ) += exynos-bus.o
> >  obj-$(CONFIG_ARM_HISI_UNCORE_DEVFREQ)        += hisi_uncore_freq.o
> >  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)    += imx-bus.o
> > diff --git a/drivers/devfreq/airoha-devfreq.c b/drivers/devfreq/airoha-devfreq.c
> > new file mode 100644
> > index 000000000000..cb6d8b49e4a4
> > --- /dev/null
> > +++ b/drivers/devfreq/airoha-devfreq.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/devfreq.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/slab.h>
> > +#include <linux/pm_opp.h>
> > +
> > +struct airoha_devfreq_data {
> > +     struct clk *clk;
> > +
> > +     struct devfreq_passive_data gov_data;
> > +};
> > +
> > +static int airoha_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
> > +{
> > +     struct airoha_devfreq_data *data = dev_get_drvdata(dev);
> > +
> > +     *freq = clk_get_rate(data->clk);
> > +
> > +     return 0;
> > +};
> > +
> > +static int airoha_devfreq_target(struct device *dev, unsigned long *freq,
> > +                              u32 flags)
> > +{
> > +     struct airoha_devfreq_data *data = dev_get_drvdata(dev);
> > +
> > +     return clk_set_rate(data->clk, *freq);
> > +};
>
> Some odd copy-paste.
>
> Anyway, your driver is heavily incomplete. You can scale the clock
> directly from each device driver (each should register devfreq). You do
> not need completely new driver for that.
>

I sent a v2, the thing is that those subsystems need to scale with the
CPU frequency. It's not something where driver configure a static frequency.

There is a specific governor for devfreq driver that follow the CPU cpufreq
OPP call and with the help of DT required-opp, each subsystem is scaled
to the frequency.

It's to handle idle state for power saving and temperature and scale to
"turbo" when the SoC needs the extra perf.
