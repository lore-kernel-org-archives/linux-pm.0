From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: max77693_charger: Better sysfs creation and using
 devm APIs
Date: Sat, 17 Dec 2016 18:28:47 +0200
Message-ID: <20161217162847.GA30265@kozik-lap>
References: <1481273498-4957-1-git-send-email-s.ritolia@samsung.com>
 <20161210074854.GB2991@kozik-lap>
 <CADeeJYCSaqW+dayookXKVtWaEKrtHKKixBmXY3gQa86v-s7b8w@mail.gmail.com>
 <20161210195627.GA22744@kozik-lap>
 <20161217160446.hakmgpqp5hvb6h5k@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34104 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbcLQQ2w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 11:28:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so10898416wme.1
        for <linux-pm@vger.kernel.org>; Sat, 17 Dec 2016 08:28:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161217160446.hakmgpqp5hvb6h5k@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Srikant Ritolia <srikant.ritolia@gmail.com>, Srikant Ritolia <s.ritolia@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, d.wadhawan@samsung.com, vidushi.koul@samsung.com

On Sat, Dec 17, 2016 at 05:04:46PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Dec 10, 2016 at 09:56:27PM +0200, Krzysztof Kozlowski wrote:
> > On Sat, Dec 10, 2016 at 07:49:25PM +0530, Srikant Ritolia wrote:
> > > On Sat, Dec 10, 2016 at 1:18 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > On Fri, Dec 09, 2016 at 02:21:38PM +0530, Srikant Ritolia wrote:
> >  >
> > > >>                                               &max77693_charger_desc,
> > > >>                                               &psy_cfg);
> > > >>       if (IS_ERR(chg->charger)) {
> > > >>               dev_err(&pdev->dev, "failed: power supply register\n");
> > > >>               ret = PTR_ERR(chg->charger);
> > > >> -             goto err;
> > > >
> > > > Missing sysfs cleanup.
> > > >
> > > > Best regards,
> > > > Krzysztof
> > > >
> > > 
> > > Thanks for pointing this out.
> > > To overcome this I will use sysfs_create_group after devm_power_supply_register.
> > > Then I would not need to do this sysfs cleanup on failure of power
> > > supply register.
> > 
> > I am not sure if this is good idea. This patch does not bring any
> > particular noticeable benefit except less lines of code. It is not worth
> > breaking things just for that reason...
> 
> I like less lines of code. How does the changed registration order
> break anything? The changed registration order makes sense anyways,
> since it then matches the (reversed) removal order.

By broken things I meant possible errors introduced with devm
conversion (like that one spotted above). To me personally, converting
to devm on its own mostly does not bring benefits except few cases when
a lot of code disappears. On the other hand it hides the order of
cleanup making it slightly more difficult to review. Overall - not many
benefits, some things hidden.

However I understand that this is highly subjective so I am not against
if others like this approach.

Best regards,
Krzysztof

