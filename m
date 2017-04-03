From: Liam Breck <liam@networkimprov.net>
Subject: Re: Moving forward with the patches for using the bq24190 on x86 systems
Date: Mon, 3 Apr 2017 14:56:45 -0700
Message-ID: <CAKvHMgR+mvxSRYH69oAyGGL2ppZxO=s1CtUw_N2Cy-tZe-nAUg@mail.gmail.com>
References: <527947b5-948b-1aab-233f-c421bdf317e2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35426 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdDCV4r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 17:56:47 -0400
Received: by mail-it0-f65.google.com with SMTP id y18so9569795itc.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 14:56:47 -0700 (PDT)
In-Reply-To: <527947b5-948b-1aab-233f-c421bdf317e2@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

On Mon, Apr 3, 2017 at 12:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Sebastian, Liam,
>
> I still have 2 patches pending for using the bq24190 on x86 systems,
> which I would like to see merged in some form (and if possible in
> time for 4.12):

Is there a specific reason for urgency?

Can I ask how you got involved in porting Linux to this Atom box?


> 1) The "power: supply: bq24190_charger: Never reset the charger chip" patch.
>
> Sebastian you said you would merge this after letting it sit a bit longer
> on the list, unless any problems with it were noticed. I believe Liam
> would prefer for this to not get merged as-is. So I see 3 options:
>
> a) Merge as-is (AFAIK no problems with it have been noticed)
> b) Add a "no-reset-on-probe" boolean device property which will
> make the driver not do a reset on probe (nor on resume)
> c) Add a "reset-on-probe" boolean device property and make the
> driver only do a reset on probe (and on resume) if this is set
>
> Sebastian, can you please pick one of these 3 options ? Then I
> will adjust my patch as necessary and post a new version.

I've solicited Tony's input on this. He's studied the charger/driver a
lot, and is a guru-level kernel contributor.

> 2) The "power: supply: bq24190_charger: Remove battery power_supply device"
> patch
>
> The problem with this one is that it removes userspace ABI on which
> Liam is relying, so this cannot go upstream as is. I think that
> for now it is best to add a "disable-battery-power-supply-iface"
> boolean device-property (for kernel internal use only, not part
> of the DT bindings) and guard the power_supply_register call
> for the battery interface with a check for this.

That would be a reasonable near-term workaround, until I merge the
-battery properties into -charger.
