From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 0/6] BQ24190 charger fixes
Date: Mon, 16 Jan 2017 22:01:34 -0800
Message-ID: <CAKvHMgSEimsV7+VbqQi8Ex-ztqLCJbKQ7DD_NucyRB0bP5L4+g@mail.gmail.com>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170117032646.lf7hfrjsektfsxpk@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33501 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdAQGBf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 01:01:35 -0500
Received: by mail-it0-f66.google.com with SMTP id v14so14585916itb.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2017 22:01:35 -0800 (PST)
In-Reply-To: <20170117032646.lf7hfrjsektfsxpk@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>

On Mon, Jan 16, 2017 at 7:26 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Mon, Jan 16, 2017 at 06:28:28PM -0800, Liam Breck wrote:
>> These are misc fixes, tested on a custom OMAP3 board.
>>
>> Changes in v3
>>
>> #1 fixes figure ID to 37
>> #5 fixes line over 80 chars
>> #* adds Acked-by Tony & Mark
>
> You forgot to fix the whitespace issues Mark mentioned, also
> please use "git send-mail" or make sure, that your patchset
> is threaded (patch 1-6 are replies to "patch" 0) and the
> actual patch is inline and can be applied using "git am"
> (which currently complains).

Hi, would you accept the v3 patches as-is were I the module
maintainer? Because I am the de facto maintainer :-)

I contracted Mark to write this driver, and he hasn't had hardware on
which to test it for a few years...
