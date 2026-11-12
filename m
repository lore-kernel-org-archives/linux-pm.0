Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492216;
	b=f5pIA24gwgFlDtXIKLtIVtNQr1/btUULUxcFyJwwhlEQtTIHPwYN62kKag4JthNu13JC
	 c2yp5pL+6G0vBiBEMGkvnvDUDYdNsmErahsJ4/S0QnL2wZBkPI5OBDShlbtDCaM6usNp8
	 DmRvfnzG3ujsVPTzOSF93mjBvQLV40xrAYaNVWh7WoZF8KMISbSPgKMpuMkZn0iQFJEz/
	 af39phikEUGpRWfa5v9mEw9RLMkPKxUTbLXQtXxL86Lf0P3EPNpBYDbwZm/+9vUHP8+J9
	 KR5j5v0FkGPY/xlSt10seTQLhVYx+4muovDkLVi0fF1UpB0JA7LgEEIV7/vjRZW9aWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492216;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zmPWh+NYf7w6PPrSZKb5ErSaLMlekSlLFc1zs9w8z0Q=;
	b=VTq4HASj2U3bAjq82Alhacsq5SD4mLhfnwJdq3q+SlrsY1zkALjv79esif/qgiEtAJgF
	 8IeljwMzCSXFKh/5ZEjeluYfA2li4t4dQvqtlWs1METnQMW3LjhSKn/2bz92zioJmoelE
	 gmEiOss5XQqgX2oz5cu3gXFMIaFvf5Ar5AaSrhkuHaGXv2YYKaj/JXxDA5CtedXQqhHx3
	 vwK4YgeY32z93XUchHUrDJn6PX9zMqDG1wtJFsKIrmwdspNCS9QebS0tkN87M6kYs0KAY
	 Bm1hA8OXhDuUrs9ykDiXaqU+GbXgNInHcOGKiJvjRs+33qcwRHL1QXDPR853MHGS4mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orsbQZ0F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD160A261E
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=orsbQZ0F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9111F00A0C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492215;
	bh=zmPWh+NYf7w6PPrSZKb5ErSaLMlekSlLFc1zs9w8z0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=orsbQZ0Fs9Yc8FoXyxHjcSt+uJVAY+FT7P5zPQScjNFhGP+bVpgRbU3Y7B2W4r5ip
	 jYZ9/Q19ow3k5lCv00/d1zZk9ds6paCeSflAFSlCvbbLvyeiiaAW4Rq+kHZBeRW4Pp
	 bTr+jvfP6jzc6TcM/YurJSBpq5Wtu9sgabNOIxa4E1NqT7TPcCIN34HGb5mzwwhJw+
	 +BSvzMnr8Ru5liz74l5qe1mFxtxLV9B1KTq2GpRMWsDQ9w4AsJy8W1i3zy9f8H2JQ7
	 5uRyQi5gB9uowIXCvriwEaOesFmJhMU3QZ0k6xQHTxWXqVhrdlI942Gh4e9e2TUEJf
	 Eu7mfm85Zywug==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso2843532e87.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 06:03:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH5K26vSCjRx4gznXjVRr5zu+fx7mNTatOvVrlSZXmPqz+s0tmECM3NerygR+FoeT4BqpeXzpUbhQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/JsjAsuWGA/LWK7pgw/fJtYx2vYJUAcmWmxoVfT1ENl21xwPuE
	uXzqwi2pxnaMyRowCpttq5XvwXhXgphamsJJGG0k3/h6LUUZiZ6HhxujdxL1W70K86Y9YzygqiO
	H0CoDETozPizsrEXR4nGuXU2yEHvT/1I=
X-Received: by 2002:a05:6512:1325:b0:5c1:4a5d:6ae1 with SMTP id
 2adb3069b0e04-5c15d62c5dcmr2107662e87.14.1794492214280; Thu, 12 Nov 2026
 06:03:34 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-b4-pm-sleep-hibernation-fixes-v1-0-51fac96d080d@oss.qualcomm.com>
 <20261102-b4-pm-sleep-hibernation-fixes-v1-2-51fac96d080d@oss.qualcomm.com> <CAPx+jO86pgUXuHMPKAMKN6Tq9unxnpd9kB8eE9byZw_B=0xxyw@mail.gmail.com>
In-Reply-To: <CAPx+jO86pgUXuHMPKAMKN6Tq9unxnpd9kB8eE9byZw_B=0xxyw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 12 Nov 2026 15:03:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gEDWA_zc6KTJqCPNwHt74+pt6WfBC8Ka6XCp8ZSK15HA@mail.gmail.com>
X-Gm-Features: AclHuK8e-AJ-XjrSAXBkD-hu4PMVxz0LC00YFvk3ACIuaq22lQdmQ2x0hsZZ62o
Message-ID: <CAJZ5v0gEDWA_zc6KTJqCPNwHt74+pt6WfBC8Ka6XCp8ZSK15HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Do not arm wakeup IRQs for hibernation
 freeze and quiesce
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 2:46=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Mon, Nov 2, 2026 at 3:47=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.=
com> wrote:
> >
> > Freezing devices to take a hibernation image and quiescing them before
> > jumping into one go through the regular noirq suspend path, which arms
> > the wakeup IRQs of all devices that may wake up the system. A wakeup
> > IRQ firing then aborts the hibernation or the restore:
> >
> >   PM: Triggering wakeup from IRQ 180
> >   Wakeup pending. Abort CPU freeze
> >   PM: hibernation: Failed to load image, recovering.
> >
> > On a Qualcomm Glymur CRD this happens on every hibernation and every
> > restore. The WWAN modem keeps asserting WAKE# once its root port goes
> > down, after its driver has shut it down for the freeze, and the WAKE#
> > GPIO of a PCIe port is a dedicated wakeup IRQ with wakeup enabled by
> > default.
> >
> > Neither transition is one the system can be woken up from, as nothing
> > goes to sleep, and Documentation/driver-api/pm/devices.rst already says
> > that in the freeze_late and freeze_noirq phases a device "should not be
> > allowed to generate wakeup events". Do not arm the wakeup IRQs for
> > them, and only disarm them in the noirq resume path if they have been
> > armed. Wakeup IRQs are still armed for the final transition to sleep,
> > PM_EVENT_HIBERNATE, and for suspend.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>
> This seems reasonable to me, but I can't judge from a reasonably brief
> review if this is the proper place to fix this. Rafael, what do you
> think?

I think I'd do it differently, but give me some more time to think it throu=
gh.

> Nevertheless, please add:
>
> Reviewed-by: Ulf Hansson <ulfh@kernel.org>
>
> Kind regards
> Uffe
>
> > ---
> >  drivers/base/power/main.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 16a1f017051e..34ba0e5941a3 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -949,6 +949,9 @@ static void dpm_noirq_resume_devices(pm_message_t s=
tate)
> >         trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, fals=
e);
> >  }
> >
> > +/* Whether dpm_suspend_noirq() has armed the wakeup IRQs of devices */
> > +static bool dpm_wake_irqs_armed;
> > +
> >  /**
> >   * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices=
.
> >   * @state: PM transition of the system being carried out.
> > @@ -961,7 +964,11 @@ void dpm_resume_noirq(pm_message_t state)
> >         dpm_noirq_resume_devices(state);
> >
> >         resume_device_irqs();
> > -       device_wakeup_disarm_wake_irqs();
> > +
> > +       if (dpm_wake_irqs_armed) {
> > +               device_wakeup_disarm_wake_irqs();
> > +               dpm_wake_irqs_armed =3D false;
> > +       }
> >  }
> >
> >  static void async_resume_early(void *data, async_cookie_t cookie);
> > @@ -1685,7 +1692,17 @@ int dpm_suspend_noirq(pm_message_t state)
> >  {
> >         int ret;
> >
> > -       device_wakeup_arm_wake_irqs();
> > +       /*
> > +        * Freezing devices to take a hibernation image, and quiescing =
them
> > +        * before jumping into one, are not transitions the system can =
be woken
> > +        * up from, as nothing goes to sleep. A wakeup IRQ of a device =
that
> > +        * signals for attention once its link goes down, like a PCIe e=
ndpoint
> > +        * asserting WAKE#, would only abort the hibernation or the res=
tore.
> > +        */
> > +       if (state.event !=3D PM_EVENT_FREEZE && state.event !=3D PM_EVE=
NT_QUIESCE) {
> > +               device_wakeup_arm_wake_irqs();
> > +               dpm_wake_irqs_armed =3D true;
> > +       }
> >         suspend_device_irqs();
> >
> >         ret =3D dpm_noirq_suspend_devices(state);
> >
> > --
> > 2.54.0
> >
