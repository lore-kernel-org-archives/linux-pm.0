From: Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] Allow userspace control of runtime disabling/enabling of
 driver probing
Date: Wed, 4 Jan 2017 12:10:04 -0600
Message-ID: <CAPeXnHudW-YDmoK8NrFzQgAq4WuRDgFNC5-0GaG0+jVkq+3meQ@mail.gmail.com>
References: <20170103225831.GA113525@beast> <20170104093236.GB31677@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33391 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968759AbdADSKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2017 13:10:06 -0500
Received: by mail-vk0-f53.google.com with SMTP id 137so290730237vkl.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2017 10:10:05 -0800 (PST)
In-Reply-To: <20170104093236.GB31677@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Lukas Wunner <lukas@wunner.de>, Madalin Bucur <madalin.bucur@nxp.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Petr Tesarik <ptesarik@suse.com>, linux-pm@vger.kernel.org, kernel-hardening@lists.openwall.com

On Wed, Jan 4, 2017 at 3:32 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Ick, hiding this in the power management code?  That's messy, and
> complex, as Rafael pointed out.

It's in code that's used in the power management layer, not in power
management code. This is all in the driver core.

> Turning on and off at random times "new devices can not be bound, wait,
> now they can!" is ripe for loads of issues and is going to be a pain to
> properly maintain over time.

What kind of issues?

> What's wrong with the facility that the USB layer provides today to
> allow only "authenticated" devices to be enabled?  That has been used
> for a few years now to prevent these "don't allow random devices that
> are plugged into the computer to be enabled" type attacks.  Doing much
> the same thing, in a different manner, is ripe for problems (how do the
> two interact now?)

The USB authentication feature was intended for handling wireless USB
devices - it can be reused for this, but the code isn't generic enough
to apply to other bus types. The two interact in exactly the way you'd
expect, ie they don't. If you use both, then you need to handle both.

> If you are worried about PCI devices, why not just implement what USB
> did for PCI?  Or better yet, move the USB functionality into the driver
> core, adding that type of authentication ability to any bus that wishes
> to have it (and not break existing working systems that are using the
> USB solution today.)

The USB approach requires userspace to keep track of which devices
were added while the session was locked, whereas the kernel already
has the logic to do all of this. All the complexity already exists and
is used every time anybody suspends and resumes, so why add additional
complexity?

I'm not clear on how this patch breaks anybody using the existing USB solution?
