Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF83ACA5C
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273957; cv=none; b=RqlZqT+cPlGaLDDWvuYrfh8aNifECDmItrzAN8HMkVFqFsa4BeTyXtkivaIi51rTkofyo5AvRKPWx7jodoKrBeV6i9slercu0+ArWG+qINwQAengV1J+Yo6pEzJpjjQE5XJkAFA7gbAvfPpLy7gAyuTY16qDhmhb1y7JPjNDTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273957; c=relaxed/simple;
	bh=PKOaxsGDMIgOXzeweIs8sUzDZW4hMml0P2cMEtFkvy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgSTjKs997QglBqYqNPgLM5WnwLwsw3P8d/2A90YM3euC1HTrnCNz78toyGwmbVIR7H4zpbUT/Gb6ZvVFhgZAPZIzk8bjOQq3x+mwfmJz0MPWvMSPuGCrNbRj47Byjh/YOSkbwGuLLmMMNecJ8hB0kGe9ceiUtJQnckKm6irTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAjXjAET; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAjXjAET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0974AC4AF09
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273957;
	bh=PKOaxsGDMIgOXzeweIs8sUzDZW4hMml0P2cMEtFkvy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rAjXjAETdgMmZoSn0snw7UmLLBuBHYlqRy2yPTTz+WgUaiFNONUtq0YPGM5K3vQuS
	 Msp427Hr7z2mIpL1puBR0g1v75EfDhzhv5meUWoN/Z4PklqR6QGSnuikZYS4uZ7a6P
	 duxCFM0MCVvjcKJdwj+shk1lOB0WJJ0epA0tlTWlzXU/Tpi55O6+jq6wCML3mrU2Va
	 jY289lKaBVAH2Qq+DFFo2xz5DVSDSW/dzH3I6ss2DMzKxbBBU9wvVVqgKiFJg1Wdl5
	 BkoTm9VTG+GfFsIKanEDTPhzcWJWPsT6eJvfSLumxypGvG0HRU96BoC6OnONx7ANv6
	 eVRfBLp41FCLA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-466f00535cfso2519807b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 06:52:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvwcGU6d5bLVBcnBVNcI6lr/S0rvApXKZehPGCf9uxNqGjcxmWBK+sPVT5N071NB2jX44ijAulIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Pcf1FkTSr5NI7LGebeGD2w4Vy6kucgasPdNWaGoKH9/eGa6Y
	BHrtDsAjcIOBxMy84ymK2QrpwTrtGbwjq/KPNFyVKZVYj+LIiI+5JYa6uuSaXIsKnINMTxAUq2u
	2FQ//ieQMjQf41xZnX57xMxogAgng0hE=
X-Received: by 2002:a05:6808:221f:b0:467:27d2:969f with SMTP id
 5614622812f47-467e5de68c3mr7390963b6e.17.1774273956139; Mon, 23 Mar 2026
 06:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323094018.2264-1-mohd.abd.6602@gmail.com> <d46ef894-ff62-4493-bd17-660004640eca@arm.com>
In-Reply-To: <d46ef894-ff62-4493-bd17-660004640eca@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Mar 2026 14:52:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jDvH64Ci8Td+fzo6WMOEVQNQ_UUeQSzjgou_NiHSzt0g@mail.gmail.com>
X-Gm-Features: AaiRm51N6ZnSGLH27T9bTxYfK28SXlci0_g0zgvMKPtReYjSzz2xaomqEtS1JSc
Message-ID: <CAJZ5v0jDvH64Ci8Td+fzo6WMOEVQNQ_UUeQSzjgou_NiHSzt0g@mail.gmail.com>
Subject: Re: [PATCH] thermal: devfreq_cooling: avoid unnecessary kfree of freq_table
To: Lukasz Luba <lukasz.luba@arm.com>, Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: rui.zhang@intel.com, daniel.lezcano@kernel.org, linux-pm@vger.kernel.org, 
	rafael@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:44=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
>
>
> On 3/23/26 09:40, Anas Iqbal wrote:
> > dfc->freq_table is only allocated in the non-EM path via
> > devfreq_cooling_gen_tables(). In the EM path, it remains NULL.
> >
> > Avoid calling kfree() unnecessarily when freq_table was never allocated=
.
> >
> > This resolves a Smatch warning:
> > calling kfree() when 'dfc->freq_table' is always NULL.
> >
> > Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> > ---
> >   drivers/thermal/devfreq_cooling.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfre=
q_cooling.c
> > index 597e86d16a4e..1c7dffc8d45f 100644
> > --- a/drivers/thermal/devfreq_cooling.c
> > +++ b/drivers/thermal/devfreq_cooling.c
> > @@ -472,7 +472,8 @@ of_devfreq_cooling_register_power(struct device_nod=
e *np, struct devfreq *df,
> >   remove_qos_req:
> >       dev_pm_qos_remove_request(&dfc->req_max_freq);
> >   free_table:
> > -     kfree(dfc->freq_table);
> > +     if (!dfc->em_pd)
> > +             kfree(dfc->freq_table);
> >   free_dfc:
> >       kfree(dfc);
> >
>
> LGTM, let's calm down that warning.
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 7.1 material, thanks!
