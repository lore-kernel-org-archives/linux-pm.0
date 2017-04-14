From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 08/13] power: max17042_battery: Add support for the
 TECHNOLOGY attribute
Date: Fri, 14 Apr 2017 20:20:41 +0200
Message-ID: <20170414182041.zhw7xmflzsarhesx@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-8-hdegoede@redhat.com>
 <20170414162632.7r3id7lkzbcjp3wj@kozik-lap>
 <db9a63d9-fd36-a19c-c24d-8c69027929c4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33113 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdDNSUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 14:20:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so18895104wmb.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 11:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <db9a63d9-fd36-a19c-c24d-8c69027929c4@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:06:56PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 14-04-17 18:26, Krzysztof Kozlowski wrote:
> > On Fri, Apr 14, 2017 at 02:59:14PM +0200, Hans de Goede wrote:
> > > The max17042 is intended for LiOn or LiPo batteries, add a TECHNOLOGY
> > > attribute to reflect this. Note this is hardcoded to LiOn as there is
> > > no way to tell the difference, this is done by many drivers and is
> > > better then not providing any technology info at all.
> > 
> > Same as Wolfgang's try:
> > https://patchwork.kernel.org/patch/9349945/
> > but with better explanation. :)
> 
> Hehe.
> 
> > Yet still I am not convinced that providing a wrong information (Li-Ion
> > in case of LiPo battery) is better than not providing any info at all.
> 
> Well lithium-ion polymer batteries to use their full name are a subset
> of the Li-Ion battery family so returning TECHNOLOGY_LION for them is
> technically correct. The technology attribute gets read by for example
> upower and then shown by for example mate-power-manager to the user:
> 
> https://github.com/mate-desktop/mate-power-manager/tree/master/src#L390

...which differentiates between Li-Ion and LiPo.

The same with kernel's power supply API - we have the
POWER_SUPPLY_TECHNOLOGY_LIPO for some reason.

> It would be nice to actually show something there, even if we're not
> correctly identifying what sub-family of lithium-ion battery we are
> actually dealing with.

You're right that it is a subfamily. I do not know what it is expected
from this interface, e.g. if stating LIPO as LION is okay or not. I see
some benefit of providing a fixed LION (especially that in mobile use
cases of max17042 these are Li-Ion). On the other hand, it might be
inaccurate. Probably harmless but inaccurate.

I do not oppose the patch.

You might consider giving some credits to Wolfgang's try with
Suggested-by.

Best regards,
Krzysztof
