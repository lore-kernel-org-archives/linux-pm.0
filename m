From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
Date: Wed, 9 Dec 2015 11:25:36 +0000
Message-ID: <20151209112536.GB17876@x1>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
 <3682335.fAt9xNcJFr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33077 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbLILZk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 06:25:40 -0500
Received: by wmec201 with SMTP id c201so255154578wme.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 03:25:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3682335.fAt9xNcJFr@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, ajitpal.singh@st.com, maxime.coquelin@st.com

On Wed, 09 Dec 2015, Arnd Bergmann wrote:

> On Tuesday 08 December 2015 14:32:01 Lee Jones wrote:
> > @@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops =3D=
 {
> >         .smp_secondary_init     =3D sti_secondary_init,
> >         .smp_boot_secondary     =3D sti_boot_secondary,
> >  };
> > +
> > +/**
> > + * CPUFreq Registration
> > + */
> > +void init_cpufreq(void)
> > +{
> > +       platform_device_register_simple("sti-cpufreq", -1, NULL, 0)=
;
> > +}
> >=20
>=20
> Can you please do this under drivers/cpufreq somewhere?
>=20
> I really don't want to any more of these in platform code. Requiring =
a
> device to be created just to probe the driver is really silly.

Already on it.  Bear with.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
