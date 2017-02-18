From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 0/8] Runtime PM for Thunderbolt on Macs
Date: Sat, 18 Feb 2017 14:06:36 +0100
Message-ID: <CAJZ5v0iCrt9N0Qs4=+1SJ1S_0w6Bu_me6A80PXym+goyn1yEAA@mail.gmail.com>
References: <cover.1486913733.git.lukas@wunner.de> <20170218095250.GC1335@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33135 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbdBRNHx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Feb 2017 08:07:53 -0500
Received: by mail-oi0-f68.google.com with SMTP id e123so1023032oig.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Feb 2017 05:06:37 -0800 (PST)
In-Reply-To: <20170218095250.GC1335@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Andreas Noever <andreas.noever@gmail.com>, Linux PM <linux-pm@vger.kernel.org>

On Sat, Feb 18, 2017 at 10:52 AM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Rafael,
>
> On Sun, Feb 12, 2017 at 05:07:45PM +0100, Lukas Wunner wrote:
>> Power down Thunderbolt controllers on Macs when nothing is plugged in
>> to save around 2W per controller and fix a power regression introduced
>> in v3.17 that affects millions of machines (all Macs with Thunderbolt)
>
> Patches 4, 5 and 6 of this series pertain to the PM subsystem:
> https://patchwork.kernel.org/patch/9568441/
> https://patchwork.kernel.org/patch/9568443/
> https://patchwork.kernel.org/patch/9568445/
>
> I've been posting these unmodified over the course of four iterations
> since mid December but haven't seen comments from you.  Are there any
> objections?  If not, would it be possible for you to include them in
> your second pull for 4.11?  This would help greatly as I wouldn't have
> to post them over and over again.

I was assuming that they would be applied along with the other patches
in the series which still are under discussion.

Is there any particular need, from the code perspective, to apply them now?

If not and if the changes in them will only be useful for Thunderbolt
PM support, I'd rather wait for the PCI discussion to settle.

That said I haven't seen anything objectional in them, so I'll look
again and respond to the patches with ACKs in the next couple of days.

Thanks,
Rafael
