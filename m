From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Date: Wed, 16 Dec 2015 17:10:34 +0100
Message-ID: <CAMuHMdU7gZze1F4eRJJKRsv7gM+D0k6w10NwHX67nSk3O_OT1Q@mail.gmail.com>
References: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
	<Pine.LNX.4.44L0.1512161011070.1751-100000@iolanthe.rowland.org>
	<20151216154358.GA14817@katana>
	<CAMuHMdV81YwhVn_BYTaEybZhW04KFg_gERPJ88UsKSSSwWcvKg@mail.gmail.com>
	<20151216160642.GB14817@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20151216160642.GB14817@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

On Wed, Dec 16, 2015 at 5:06 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Wed, Dec 16, 2015 at 04:55:28PM +0100, Geert Uytterhoeven wrote:
>> On Wed, Dec 16, 2015 at 4:43 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > I have another case, may I ask your advice about this, too? When an I2C
>> > bus is marked in DT as multi-master, then RuntimePM also needs to be
>> > disabled, because arbitration detection needs to stay awake. I am
>> > currently implementing this for the i2c-rcar driver:
>> >
>> > -       pm_runtime_enable(dev);
>> > +       /* No RuntimePM in multi-master to keep arbitration working */
>> > +       if (!of_get_property(dev->of_node, "multi-master", NULL)) {
>> > +               pm_runtime_enable(dev);
>> > +               priv->flags |= ID_P_PM;
>> > +       }
>> > +
>> >         pm_runtime_get_sync(dev);
>> >         ...
>> >
>> > @@ -664,7 +673,8 @@ static int rcar_i2c_remove(struct platform_device *pdev)
>> >         struct device *dev = &pdev->dev;
>> >
>> >         i2c_del_adapter(&priv->adap);
>> > -       pm_runtime_disable(dev);
>> > +       if (priv->flags & ID_P_PM)
>> > +               pm_runtime_disable(dev);
>> >
>> >         return 0;
>> >  }
>> >
>> > Here, I'd tend to keep using enable/disable, although get/put would
>> > probably also work. What is the rule of thumb using this pattern or the
>> > other?
>>
>> Have you actually tried the above?
>
> Nope, I just finished the sketching phase when Alan's mail came along.
>
>> All our drivers rely on Runtime PM for the power/clock domain handling.
>> I believe the pm_runtime_get_sync() won't do anything if you haven't enabled
>> Runtime PM for the device, so the device's module clock won't be enabled at
>> all.
>
> This was another question I had: Is this a bug or a feature :) But if
> you say it is policy, I will count this as "feature" and switch to
> get/put here as well.

It's a feature ;-)

Without using Runtime PM, your driver has to care about clocks and power
domains, which may or may not be present, depending on the SoC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
