From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 4/4] dma: pl330: add Power Management support
Date: Tue, 23 Sep 2014 17:39:39 +0200
Message-ID: <CAPDyKFoaP74t7ZWM66=jDgRcY-9FBM1OxMiZKL++HAO1m19DWg@mail.gmail.com>
References: <1410857494-15936-1-git-send-email-k.kozlowski@samsung.com>
	<1410857494-15936-5-git-send-email-k.kozlowski@samsung.com>
	<CAPDyKFqoLQh=FYg33LTSp-HTs-oJDT4y_K6hGRoiu9zDxOX9sw@mail.gmail.com>
	<1411034996.23919.9.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:43998 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbaIWPjl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 11:39:41 -0400
Received: by mail-qg0-f50.google.com with SMTP id q107so4491233qgd.23
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2014 08:39:39 -0700 (PDT)
In-Reply-To: <1411034996.23919.9.camel@AMDC1943>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 18 September 2014 12:09, Krzysztof Kozlowski <k.kozlowski@samsung.co=
m> wrote:
> On =C5=9Bro, 2014-09-17 at 20:42 +0200, Ulf Hansson wrote:
>> On 16 September 2014 10:51, Krzysztof Kozlowski <k.kozlowski@samsung=
=2Ecom> wrote:
>
> [...]
>
>> >
>> > @@ -2585,6 +2620,34 @@ static int pl330_dma_device_slave_caps(stru=
ct dma_chan *dchan,
>> >         return 0;
>> >  }
>> >
>> > +/*
>> > + * Assume that IRQ safe runtime PM is chosen in probe and amba bu=
s driver
>> > + * will only disable/enable the clock in runtime PM suspend/resum=
e.
>> > + */
>> > +static int __maybe_unused pl330_suspend(struct device *dev)
>> > +{
>> > +       struct amba_device *pcdev =3D to_amba_device(dev);
>> > +
>> > +       if (!pm_runtime_suspended(dev))
>> > +               amba_pclk_disable(pcdev);
>>
>> I would suggest to use pm_runtime_force_suspend() instead of the abo=
ve.
>
> Sure, I can change it but... (see below)
>
>>
>> > +       amba_pclk_unprepare(pcdev);
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static int __maybe_unused pl330_resume(struct device *dev)
>> > +{
>> > +       struct amba_device *pcdev =3D to_amba_device(dev);
>> > +
>> > +       amba_pclk_prepare(pcdev);
>> > +       if (!pm_runtime_suspended(dev))
>> > +               return amba_pclk_enable(pcdev);
>>
>> The above if statement could be replaced with pm_runtime_force_resum=
e().
>
> But that would lead to runtime resuming the device even when it is no=
t
> needed. We don't have to fully wakeup the device during resume operat=
ion
> when the device was runtime suspended before suspend.

That's true - but that's not a big issue I believe. I think the below
problems are worse. :-)

1) You don't disable runtime PM, thus not preventing the runtime PM
callbacks from being invoked.
2) You don't update the runtime PM status, thus not reflecting the
actual state of the device.

Both the above may cause unbalanced clk_enable|disable calls.

Don't get me wrong, I certainly think the "don't do runtime PM resume
during system PM resume" is interesting to solve. But that it's a
common problem and should be supported by the runtime PM API somehow
instead. I have been thinking of extending the
pm_runtime_force_resume() API to support this, let's see when that
happens. :-)

>
>>
>> Doing that, means the amba_pclk_enable|disable() don't need to be
>> exported from the AMBA bus header, but entirely handled by the AMBA
>> bus itself.
>>
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static SIMPLE_DEV_PM_OPS(pl330_pm, pl330_suspend, pl330_resume);
>> > +
>> >  static int
>> >  pl330_probe(struct amba_device *adev, const struct amba_id *id)
>> >  {
>> > @@ -2738,6 +2801,9 @@ pl330_probe(struct amba_device *adev, const =
struct amba_id *id)
>> >                 pcfg->data_buf_dep, pcfg->data_bus_width / 8, pcfg=
->num_chan,
>> >                 pcfg->num_peri, pcfg->num_events);
>> >
>>
>> You need pm_runtime_set_active() here as well.
>
> This is done by amba/bus.c. Do I have to do it again?

Ohh, you are right! No need to add it!

>
>>
>> > +       pm_runtime_irq_safe(&adev->dev);
>> > +       pm_runtime_put_noidle(&adev->dev);
>>
>> Why pm_runtime_put_noidle(), that seems like you might end up leavin=
g
>> the device in active state - unless you get some request. Likely not
>> what you want?
>
> Hmmm... I am sorry but I do not get the point here. It could be
> pm_runtime_put() as well because initially we start with counter
> incremented by amba/bus.c.

The "no_idle" version will prevent the device from going inactive,
unless a new cycle of pm_runtime_get() to pm_runtime_put() happens,
which there are no guarantees of.

Kind regards
Uffe
