Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD943ABDA8
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275556; cv=pass; b=ebQW9XwjhbEMu3UXB7w9HEJZqhyaCk8BUrtlaDhWDlOwp+sJAhBt6soriXJdfqJ9Li8iV6KyIMHsMoQFYqPJ2f1P/K9WCUntOEBSV/Xi+GimFX2ldFJGrJbn9LXFw9yQTfL2tB47mjcNerarA3Ow09Apk5/7YLdInM2XVUM8YNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275556; c=relaxed/simple;
	bh=IIIQqSLM52I4Dl3J6UVq5jxv5UJfW0trkx7wlCIr9I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzDftFCyMUQdDMpb9oNbzIUsFGXWrKv1RG2FadvB9wLW1sxBBnxbpggAWgS8lpnts/gWO/sfOjidRN+FKKQvm/KCERf2FN3+W+nbsToD26erTQ/Zzqa51SNUyfAfGxAQi+q79v3EDJN8EUT69mkKKQ6suU+8CS7g1sh/ChT0/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cU5yHVWW; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cU5yHVWW"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so2338692d50.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 01:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791275553; cv=none;
        d=google.com; s=arc-20260327;
        b=EhjTK7OQXRaH3aWqGByFPCS/klJB0WfLpiidw2gL1bZlFHZQGcCB/UFdJ2tDIwyr/4
         Fj3SlOnqLQ90mijHrI0XqPRoAHaJDlTP7N4Y7XaFgUh1CvcdxHInoeO5+kVyRAMYlvVp
         AQa84msVd2AC1gOyujFjpkSD9eqbYd/lHWOncekM7cAWnIKWT8v7/Aly/IKY+NMo077t
         Q2J+APZaKhuhGraU7iFiLCWKB8vbXPzbMCljsPPe/d3LnMSaLGTRSDge3uVw/fkL4m5e
         tHSw58WzzafnFMVz0KyjSH0PI4qXLNkJDB0HtA1YHLXJcdTdxA5Otjda4Z+qKPZ3TofK
         h3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3shV/IEEj+NmVizCeUDHMNW1W3PTgtTr4WQ4n8BMHxY=;
        fh=f7W/t/Ok/hkZGooJd+78Lpqn8qcHOzUVM3AWHA9MpNA=;
        b=l+o2N83v8U+TJq3aStiInZu9UT3+Q5oKQ8gajV6ksQ6m08iVTkngJhVDsrB88zv8vp
         RmD4J6wKRFBYWVXm7cjGXsJa+GEXAPmkRO1viU6IUK1/pELJrbhgdsXxn1eEOmkY5TiM
         qb1O54XGfcKOzcBPlmCnWqUlBZILUIuA2R8yvUFKSm/UT0JFO5uUFdP4NHf9GVlQAGev
         SprG6vTa6ReydoXXzMKqQ9SrbH/frFYw4yU/GLHEDPlF1FdxpQe0ALgGtZXukZhCbbJM
         cYy4sNUriRDv0N/FkNYpor0gPNEBnkrBy++Kwj8NifCWUSWY85N0+zQiqoERrZTKmymB
         HXXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791275553; x=1791880353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3shV/IEEj+NmVizCeUDHMNW1W3PTgtTr4WQ4n8BMHxY=;
        b=cU5yHVWWElFKjYhbMwU/mbdMyhpVpYOBM+dGuxrmyRaF0Eoz6isB839nJ21VTMSrrt
         7QHqItGtG61MiGg7wsxKPqOO/cPsOZKqTmkuXOIt/84FWNHWpjSmKtVv378LwD9W5GvX
         9Tv9MxuUqhkRoOIbnpRdvbhd1LqyWLaArOZV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791275553; x=1791880353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3shV/IEEj+NmVizCeUDHMNW1W3PTgtTr4WQ4n8BMHxY=;
        b=xHwKxdZ6+6hRuQbcTsTjQCAsDD+F14Vvxu6lpJxWxB4r0fyMDRRTHkRVc+PuhgxtVj
         XT1edNvxOGVUnNRseroUJW1L0NwYyB6cSVv38JYV/JtLKpmbWFQEBfKNgJsNeXCc8Gl7
         iT+UzplY9Nlzvv7zEEkpnVZtRRlW32R8zQM15++7UMAO1WbnA9DS4xbL32ZYhurT+u9V
         e5HViMxNF5SNTRT8xzFOCJLffUvXm62u5t/O4VWXfki/GY3QI87eJWCgKdeEMZ84kYIY
         pgdZGHNBxEOXLjw+/QzyAfkDisWPi/wBB5SmlHNQ28DEK+9iFVQdnpoVI/KImQF/Zdij
         Vh6g==
X-Forwarded-Encrypted: i=1; AKwUvBwkyZgRzWIQe6iHXmY9BQkCSgh4ArbJ52JpwRvJsnVay3G5LiyWQZ6hatSQz5kbTNAJc0vc45ETnQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYII2A0O49uY2ZNmzlEjihUnwMfVU0Lzl8klBJQ9LHpHO3h8onjp
	M21nf6lqSJEulsJXNR4GOAWAYJtkcqF56farJ8kJAGL3n9LZCBU2LgmaqqisMzBA7WbiaAC90OU
	Jw3avz4qCm0mFutliuNdAWZTqenvhSb2q6o9gDNzg
X-Gm-Gg: AYBFou1A+HBz0LfLr/ft84qoQx2j8o8iNvMxpotoKSUi+jMSeeegp+fLR1EdYafbJQz
	D8UJk8twrpfhdc/N9t/TTHqsjVLP9iMctL5gyWwF5uFJZfXyOZ4UznY31XBYb90bKPPDlHutm6g
	8iIW7/RAWCi8erDWIva59fnUPdexpTl4FU8000y/m1I1t3fQMsw9TwE/spdS348UdSJDEVauHWs
	oI9K87aO5bA0SbWdLRaAbUWSyrgUiY3NeXogq4Yg34Jvi53GeFoaiw2rviGJ5khHwi7y9syRg9C
	1JhccrWGQwBaaaEYnybKOqvLHeEkip/JvOjD/YVRR5NTtx6qOtjP5g==
X-Received: by 2002:a53:c0c2:0:b0:671:7b7f:abbb with SMTP id
 956f58d0204a3-677bd39aa4dmr2469021d50.59.1791275553415; Tue, 06 Oct 2026
 01:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006025410.506443-1-nils@buechner.me> <20261006025410.506443-3-nils@buechner.me>
In-Reply-To: <20261006025410.506443-3-nils@buechner.me>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 6 Oct 2026 10:32:21 +0200
X-Gm-Features: AclHuK8Gx2HsVGfCjYPgfM4FA2K14FiDyp_XESIE_p6YvoUuSuzEHEzfn-CxmWQ
Message-ID: <CAGXv+5F-5b+ESeUXBMYfKU=wUF9tAioyWOjWfYXoz09_-P8-bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: mtk-svs: Don't fail init01 on a bank
 whose buck is not at vboot yet
To: =?UTF-8?Q?Nils_B=C3=BCchner?= <nils@buechner.me>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 4:54=E2=80=AFAM Nils B=C3=BCchner <nils@buechner.me>=
 wrote:
>
> svs_init01() moves every bank to its vboot OPP and then immediately
> requires the bank's buck to read back exactly vboot. For the MT8183 GPU
> banks the buck follows panfrost devfreq, which has not necessarily acted
> on the OPP change yet (an idle GPU stays at its lowest OPP), so the
> check fails and the whole SVS probe aborts with -EPERM, leaving the CPU
> and CCI banks uncalibrated as well:
>
>   SVSB_GPU: buck voltage: 700000uV, expected vboot: 800000uV
>   mtk-svs 1100bc00.svs: error -EPERM: svs start fail
>
> Poll the buck for up to 500ms before giving up. If it still is not at
> vboot, skip only that bank: restore its default OPP voltages, disable it,
> and calibrate the others.
>
> On Acer Chromebook Spin 311 (MT8183) the GPU buck reaches vboot within
> the poll window and all four banks complete init01/init02.

Were both drivers (mtk-svs and panfrost) built-in, or as modules?
This would affect the timing.

> Runtime-tested on an Acer Chromebook Spin 311 (MT8183, juniper) with a
> 7.0-based kernel (the hardware is not set up to boot mainline);
> build-tested on mainline with W=3D1. On the device together with
> the auxadc_thermal per-sensor zone change: all four banks complete
> init01/init02 at boot (CPU little 1.99 GHz 1050 -> 1000 mV), stable
> under 60 s of full load on all cores at maximum frequency.
>
> The change and this changelog were drafted with an AI coding assistant
> during a debugging session on the hardware; they were reviewed and
> tested by the submitter.

This section could be moved after the "---".

> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Assisted-by: Claude Opus 5.5
> Signed-off-by: Nils B=C3=BCchner <nils@buechner.me>
> ---
>  drivers/soc/mediatek/mtk-svs.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-sv=
s.c
> index 99edecb20..2598a1ccb 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
>  #include <linux/module.h>
> @@ -1439,6 +1440,7 @@ static int svs_init01(struct svs_platform *svsp)
>         bool search_done;
>         int ret =3D 0, r;
>         u32 opp_freq, opp_vboot, buck_volt, idx, i;
> +       unsigned long skipped =3D 0;
>
>         if (!svs_mode_available(svsp, SVSB_MODE_INIT01))
>                 return 0;
> @@ -1542,13 +1544,20 @@ static int svs_init01(struct svs_platform *svsp)
>                                                       bdata->volt_step,
>                                                       bdata->volt_base);
>
> -               buck_volt =3D regulator_get_voltage(svsb->buck);
> -               if (buck_volt !=3D opp_vboot) {
> -                       dev_err(svsb->dev,
> -                               "buck voltage: %uuV, expected vboot: %uuV=
\n",
> -                               buck_volt, opp_vboot);
> -                       ret =3D -EPERM;
> -                       goto svs_init01_finish;
> +               /*
> +                * The consumer's DVFS (e.g. GPU devfreq while the GPU is=
 idle)
> +                * may not have moved to the vboot OPP yet. Give it a mom=
ent,
> +                * then calibrate the remaining banks without this one in=
stead
> +                * of failing the whole SVS probe.
> +                */
> +               if (read_poll_timeout(regulator_get_voltage, buck_volt,
> +                                     buck_volt =3D=3D opp_vboot, 10000, =
500000,
> +                                     false, svsb->buck)) {
> +                       dev_warn(svsb->dev,
> +                                "buck voltage: %uuV, expected vboot: %uu=
V, skipping bank\n",
> +                                buck_volt, opp_vboot);
> +                       __set_bit(idx, &skipped);
> +                       continue;
>                 }
>
>                 spin_lock_irqsave(&svs_lock, flags);
> @@ -1578,6 +1587,14 @@ static int svs_init01(struct svs_platform *svsp)
>                         if (r)
>                                 dev_err(svsb->dev, "opp %uHz enable fail:=
 %d\n",
>                                         svsb->opp_dfreq[i], r);
> +
> +                       /* A skipped bank keeps its default OPP voltages =
*/
> +                       if (test_bit(idx, &skipped))
> +                               dev_pm_opp_adjust_voltage(svsb->opp_dev,
> +                                                         svsb->opp_dfreq=
[i],
> +                                                         svsb->opp_dvolt=
[i],
> +                                                         svsb->opp_dvolt=
[i],
> +                                                         svsb->opp_dvolt=
[i]);
>                 }
>
>                 if (svsb->volt_flags & SVSB_INIT01_PD_REQ) {
> @@ -1599,6 +1616,9 @@ static int svs_init01(struct svs_platform *svsp)
>                 if (r)
>                         dev_err(svsb->dev, "%s disable fail: %d\n",
>                                 bdata->buck_name, r);
> +
> +               if (test_bit(idx, &skipped))
> +                       svsb->mode_support =3D SVSB_MODE_ALL_DISABLE;
>         }
>
>  svs_init01_resume_cpuidle:
> --
> 2.53.0
>
>
