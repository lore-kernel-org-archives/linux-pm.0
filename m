From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v10 1/5] PM / Runtime: Allow accessing irq_safe if no
 PM_RUNTIME
Date: Wed, 12 Nov 2014 11:44:52 +0100
Message-ID: <1415789092.4247.6.camel@AMDC1943>
References: <CAPDyKFp+cZa6PrAwQHbQE4xEzmRKBwN5J_uRByOdM0h8yoV2vg@mail.gmail.com>
 <Pine.LNX.4.44L0.1411101346430.13641-100000@netrider.rowland.org>
 <CAPDyKFqzWvcr7qrnBed=atbtGoUTJ5-8URvn7ZMYJZoZk2+dYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:27950 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaKLKo4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Nov 2014 05:44:56 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NEX0068H9ZEUA30@mailout4.w1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 12 Nov 2014 10:47:38 +0000 (GMT)
In-reply-to: <CAPDyKFqzWvcr7qrnBed=atbtGoUTJ5-8URvn7ZMYJZoZk2+dYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


On =C5=9Bro, 2014-11-12 at 11:39 +0100, Ulf Hansson wrote:
> On 10 November 2014 19:59, Alan Stern <stern@rowland.harvard.edu> wro=
te:
> > [CC: list severely trimmed]
> >
> > On Mon, 10 Nov 2014, Ulf Hansson wrote:
> >
> >> >> There are an important advantage of using the pm_runtime_force_=
suspend() here.
> >> >>
> >> >> For the driver to handle clock gating at system PM suspend, it =
first
> >> >> needs to bring the device into full power, through
> >> >> pm_runtime_get_sync(). Otherwise it's not safe to gate the cloc=
k,
> >> >> since it may already be gated.
> >> >
> >> > That's fine, but it has nothing to do with pm_runtime_force_susp=
end().
> >> >
> >> > Besides, if the real question is whether or not to gate the cloc=
k (or
> >> > in other words, has the clock already been gated), why not just =
store a
> >> > "clock_is_gated" flag somewhere?
> >>
> >> You could do that, but it's easier to not.
> >
> > I'm not convinced.  And you haven't said how this is related to
> > pm_runtime_force_suspend().
> >
> >> You will need to update the runtime PM status and disable runtime =
PM
> >> anyway, done by the API.
> >
> > So what?  And what API are you referring to: the runtime PM API or
> > something else?
>=20
> Sorry if I was unclear, I was referring to pm_runtime_force_suspend()=
=2E
>=20
> >
> > I get the feeling that I'm missing a lot of important points here.
> > What have you left out?
>=20
> First, this patch which we are discussing is about how the amba
> bus/drivers should cope with irq_safe devices. I think we have alread=
y
> solved that through Rafael's latest suggestion.
>=20
> In principle what you want me to elaborate upon, is why the
> pm_runtime_force_suspend|resume() helpers is a good choice for AMBA
> bus/drivers to use, right?
>=20
> Indeed the pm_runtime_force_suspend|resume() helpers was discussed
> thoroughly before Rafael, decided to merge them. I do now realize tha=
t
> I forgot to add some information about them into the runtime PM
> documentation, my bad. Will fix it soon.
>=20
> Anyway, this is copied from the function header, which gives you an
> overall idea why they are good for AMBA.
>=20
> /**
>  * pm_runtime_force_suspend - Force a device into suspend state if ne=
eded.
>  * @dev: Device to suspend.
>  *
>  * Disable runtime PM so we safely can check the device's runtime PM =
status and
>  * if it is active, invoke it's .runtime_suspend callback to bring it=
 into
>  * suspend state. Keep runtime PM disabled to preserve the state unle=
ss we
>  * encounter errors.
>  *
>  * Typically this function may be invoked from a system suspend callb=
ack to make
>  * sure the device is put into low power state.
>  */
>=20
> Since AMBA bus/drivers are handling runtime PM resources like
> clocks/pinctrl/etc from their runtime PM callbacks, using
> pm_runtime_force_suspen|resume() from their system PM callbacks makes
> perfect sense to me.
>=20
> >
> > As I understand the problem, you've got a bus type where some of th=
e
> > drivers have IRQ-safe runtime PM (and therefore carry out their
> > suspend/resume operations in interrupt context) and others don't.  =
The
> > subsystem core wants to maximize the power saving by deconfiguring =
some
> > clocks whenever a device is suspended, but this requires a process
> > context and so it can't be done directly when IRQ-safe runtime PM i=
s
> > used.
> >
> > Is that a good summary?  If it is, there are ways of dealing with t=
his
>=20
> Yes.
>=20
> > that don't involve messing around with the runtime PM internals, or
> > using pm_runtime_force_suspend().
>=20
> The logic to handle that would in principle mean to keep track of the
> device's runtime PM status. That doesn't make sense, it's the job of
> the runtime PM core to do that!?
>=20
> Additionally, you would also need to protect the runtime PM resume
> callback from doing clock enable during system PM, unless you also
> disable runtime PM.
>=20
> To me, pm_runtime_force_suspend|resume() will do exactly what we need
> for the AMBA case.

Hmm... you're saying that runtime resume/suspend could happen during
execution of system resume/suspend callback?

Or maybe the runtime resume callback could be called after suspending
the device but before system sleep finishes?

In pl330 I wanted to do something like:

static int __maybe_unused pl330_suspend(struct device *dev)
{
	struct amba_device *pcdev =3D to_amba_device(dev);

	if (!pm_runtime_status_suspended(dev)) {
		/* amba did not disable the clock */
		amba_pclk_disable(pcdev);
	}
	amba_pclk_unprepare(pcdev);

	return 0;
}

However I still wonder how this is safe against concurrent runtime PM..=
=2E

Best regards,
Krzysztof

