From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: max77693_charger: Better sysfs creation and using
 devm APIs
Date: Sat, 10 Dec 2016 21:56:27 +0200
Message-ID: <20161210195627.GA22744@kozik-lap>
References: <1481273498-4957-1-git-send-email-s.ritolia@samsung.com>
 <20161210074854.GB2991@kozik-lap>
 <CADeeJYCSaqW+dayookXKVtWaEKrtHKKixBmXY3gQa86v-s7b8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35649 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbcLJT4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Dec 2016 14:56:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so2870866wme.2
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2016 11:56:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADeeJYCSaqW+dayookXKVtWaEKrtHKKixBmXY3gQa86v-s7b8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srikant Ritolia <srikant.ritolia@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Srikant Ritolia <s.ritolia@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, d.wadhawan@samsung.com, vidushi.koul@samsung.com

On Sat, Dec 10, 2016 at 07:49:25PM +0530, Srikant Ritolia wrote:
> On Sat, Dec 10, 2016 at 1:18 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Fri, Dec 09, 2016 at 02:21:38PM +0530, Srikant Ritolia wrote:
 >
> >>                                               &max77693_charger_desc,
> >>                                               &psy_cfg);
> >>       if (IS_ERR(chg->charger)) {
> >>               dev_err(&pdev->dev, "failed: power supply register\n");
> >>               ret = PTR_ERR(chg->charger);
> >> -             goto err;
> >
> > Missing sysfs cleanup.
> >
> > Best regards,
> > Krzysztof
> >
> 
> Thanks for pointing this out.
> To overcome this I will use sysfs_create_group after devm_power_supply_register.
> Then I would not need to do this sysfs cleanup on failure of power
> supply register.

I am not sure if this is good idea. This patch does not bring any
particular noticeable benefit except less lines of code. It is not worth
breaking things just for that reason...

Best regards,
Krzysztof
