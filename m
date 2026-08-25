Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D837F74C
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682414; cv=none; b=LWe/FPNO+apqMXE7VF8p1rj1kMo0Jk2/6WMHCubWWtwUz5fQ0No8vsza0UHsEs2+4hYipTBpCA/4nM0+Dl3RANN/QsMW/AIMoBEoVXmkrx8zvz7ljkSxAPkc6Yimu9FCetOT5Cf6X6B4X9Uvr5lg/e3DI4F8IlHka86QXQFcFLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682414; c=relaxed/simple;
	bh=gWgajyS7AA4yvorTq/vYOMEwNppGKrgKzyBJAvAW9k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY9aPEs7jFpJjU2zbnLbK7otokbRUOiIsIqh/0SXcfGPHC5cQ4WECnc/zcsMayDh3+eYzeiBVN0984VpiQ5g7odL4BjRZ/+Z5c3AonxsoVFjxq9N/nRC9p1VN40mxFXiipgYUWnhMTMmmiEjWqfESWwAshMD8CJuxz60yE/JZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As+0g5qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As+0g5qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5101F000E9
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787682412;
	bh=4Ws0awPZ/w3QOslOp/sTgch2LWxVCO+bIKQuOiObOW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=As+0g5qy8go8l65S0eojIg5fAtG+29CmpsR3PzAdCAeofworLehn15NNmsYFKTyhi
	 9TJE6jf4qJm2o5lDBDnAH1fGf+M9TOJfcn3U7HR4gqdJlJnRzYqLTx4tJ6kSDkxuzg
	 WtjQ9Q7lTEFd8iP3XDz9juEcL/Uh5/5xQdPK/ZCPJhLFk0aHZhx7ZxL7cwxrFxAOMu
	 lAUslW1wv+lsrQlfHcsGmf87yw1qPHbx2ATXFmGCUJAvFVLfsifaRV7KqHqEOPnMq4
	 GoHRz+dAbIM/GC5ibqlyCAq84UtKINcZSNz/tCRoHAxhgYjWuaNHcWRQEbJHOIrCjJ
	 zLzaFJGGoO+wQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a1eb6fa0f4so225201fa.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 11:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rry++740f9riv0MPU17ZwKLEDeWllV0+L8OWjNEmBqPq6u3BIq9d/MbWycM+pjTT6DPbpNqSHy0vA==@vger.kernel.org
X-Gm-Message-State: AFuF++nON4JZnShdjkO4hEaQvsMWuy6U1SqVj2nRXZ/u4PAmQMv0yY6w
	GUxBmCUV4dFF0jvp6jCxQtu63pAvtR50oD9UoN46SQ3gOj30sQDJpZ9HkFFXBVW41TfcEhuCn5D
	f8pXyqYooFzsMBcpjaAGIR5UefCKTQbo=
X-Received: by 2002:a05:651c:2124:b0:39c:624d:82b9 with SMTP id
 38308e7fff4ca-3a1fd5c907fmr992911fa.4.1787682410962; Tue, 25 Aug 2026
 11:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aohvcP8ch-Zn6tV-@sirena.org.uk> <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
 <6027571.DvuYhMxLoT@rafael.j.wysocki> <508052c8-7f6a-47b2-83ed-ff8ad72a3bb7@infradead.org>
In-Reply-To: <508052c8-7f6a-47b2-83ed-ff8ad72a3bb7@infradead.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 20:26:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcBpvkh12HLdEP0Mb31cQad57CZa9CG6G3-mJm_jDybQ@mail.gmail.com>
X-Gm-Features: AcwNN1Wr6oRjEsn0iGoj3jZW3gzCPOSA3wmEHz5rTlU3PE--9ySrQqgqTLQR5B0
Message-ID: <CAJZ5v0hcBpvkh12HLdEP0Mb31cQad57CZa9CG6G3-mJm_jDybQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 21 (drivers/thermal/qcom/qcom-spmi-mbg-tm.ko)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux ARM MSM <linux-arm-msm@vger.kernel.org>, amitk@kernel.org, 
	Thara Gopinath <thara.gopinath@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 8/25/26 6:27 AM, Rafael J. Wysocki wrote:
> > On Monday, August 24, 2026 9:15:16 PM CEST Randy Dunlap wrote:
> >>
> >> On 8/21/26 8:32 AM, Mark Brown wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20260820:
> >>>
> >>> None.
> >>>
> >>> Non-merge commits (relative to Linus' tree): 7073
> >>>  5989 files changed, 509370 insertions(+), 156446 deletions(-)
> >>
> >> on x86_64 allmodconfig:
> >>
> >> WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module use=
s symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not=
 import it.
> >> WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module use=
s symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but do=
es not import it.
> >
> > Does the appended patch address it?
>
> Yes, the warnings are gone now. Thanks.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>

Cool, thanks!

> > Interestingly enough, it doesn't complain for me when I build the
> > thermal tree merged on top of the current mainline.
> >
> > How exactly do you build it?
>
> make O=3Dxx64 allmodconfig
> make O=3Dxx64 -s all

OK

> > ---
> >  drivers/thermal/qcom/qcom-spmi-mbg-tm.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> > +++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
> > @@ -252,5 +252,6 @@ static struct platform_driver mbg_tm_dri
> >  };
> >  module_platform_driver(mbg_tm_driver);
> >
> > +MODULE_IMPORT_NS("IIO_CONSUMER");
> >  MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
> >  MODULE_LICENSE("GPL");
> >
> >
> >
> >
>
> --
> ~Randy
