Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52ECC433E0
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 21:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECCA20756
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 21:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597180194;
	bh=tRswQoz3Io4eMiflFk/mgoD1e+JXoOIFlknWdgL+hpY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=P/VKuYuQahHkA22YIMOfVPihLzZZTgHjHdwShJ2JgOPzyp1Fs3OmlgHLtseiuNEX5
	 tRnTfv4U5K3/3XxoySK/U8cuoYYhCiWS75Ef5ibCWgcA2h41XWLOB3PWdAFC6uTeNE
	 R16IWUEBTAIb1Tgb0ZLhe80YhBU05/GZGC7+VwX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKVJy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgHKVJx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 17:09:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF7B20756;
        Tue, 11 Aug 2020 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597180193;
        bh=tRswQoz3Io4eMiflFk/mgoD1e+JXoOIFlknWdgL+hpY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WmURh5WkywPN/blLRM+aGB36g8bCzzVjMJpdf93L+PHOu3H1Ec6Dws0y5hOntY/NB
         EzrviXE6f4BvXf0TjLYUbvZcWF8Qh7qv0iayQG2szwFLNFfSZsW6fLbu9HNSVW3Unj
         XTnyr/QXj2bvdgtAiVza3O+LsVHICGzgxR3VGhZg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH] opp: Fix dev_pm_opp_set_rate() to not return early
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, nm@ti.com,
        viresh.kumar@linaro.org, vireshk@kernel.org
Date:   Tue, 11 Aug 2020 14:09:51 -0700
Message-ID: <159718019170.1360974.4800051292737590657@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rajendra Nayak (2020-08-10 00:06:19)
> dev_pm_opp_set_rate() can now be called with freq =3D 0 inorder
> to either drop performance or bandwidth votes or to disable
> regulators on platforms which support them.
> In such cases, a subsequent call to dev_pm_opp_set_rate() with
> the same frequency ends up returning early because 'old_freq =3D=3D freq'
> Instead make it fall through and put back the dropped performance
> and bandwidth votes and/or enable back the regulators.
>=20
> Fixes: cd7ea582 ("opp: Make dev_pm_opp_set_rate() handle freq =3D 0 to dr=
op performance votes")
> Reported-by: Sajida Bhanu <sbhanu@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/opp/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 0c8c74a..a994f30 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -901,6 +901,9 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned =
long target_freq)
> =20
>         /* Return early if nothing to do */
>         if (old_freq =3D=3D freq) {
> +               if (opp_table->required_opp_tables || opp_table->regulato=
rs ||
> +                   opp_table->paths)
> +                       goto skip_clk_only;

This is a goto maze! Any chance we can clean this up?

        if (!opp_table->required_opp_tables && !opp_table->regulators &&
	    !opp_table->paths)
	    if (old_freq =3D=3D freq) {
		    ret =3D 0
		    dev_dbg(..)
	    } else if (!_get_opp_count(opp_table)) {
		    ret =3D _generic_set_opp_clk_only(dev, clk, freq);
	    }
	} else {
		temp_freq =3D old_freq;
		old_opp =3D _find_freq_ceil(opp_table, &temp_freq);
		...
	        dev_pm_opp_put(opp);
	put_old_opp:
		if (!IS_ERR(old_opp))
			dev_pm_opp_put(old_opp);
	}
put_opp_table:
	dev_pm_opp_put_opp_table(opp_table);

And that stuff in the else should probably go to another function.

>                 dev_dbg(dev, "%s: old/new frequencies (%lu Hz) are same, =
nothing to do\n",
>                         __func__, freq);
>                 ret =3D 0;
> @@ -919,6 +922,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned =
long target_freq)
>                 goto put_opp_table;
>         }
> =20
> +skip_clk_only:
>         temp_freq =3D old_freq;
>         old_opp =3D _find_freq_ceil(opp_table, &temp_freq);
>         if (IS_ERR(old_opp)) {
> @@ -954,8 +958,10 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned=
 long target_freq)
>                                                  IS_ERR(old_opp) ? NULL :=
 old_opp->supplies,
>                                                  opp->supplies);
>         } else {
> +               ret =3D 0;
>                 /* Only frequency scaling */
> -               ret =3D _generic_set_opp_clk_only(dev, clk, freq);
> +               if (freq !=3D old_freq)
> +                       ret =3D _generic_set_opp_clk_only(dev, clk, freq);
>         }

And write this as=20

	else if (freq !=3D old_freq) {
		ret =3D _generic_set_opp_clk_only(..)
	} else {
		ret =3D 0;
	}
