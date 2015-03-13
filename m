From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/9] pm: domains: avoid potential oops in pm_genpd_remove_device()
Date: Fri, 13 Mar 2015 13:45:52 +0100
Message-ID: <CAMuHMdWmVLPqKs2ZyLjZ2DA2UAjhqzrr1LEtsW2CRYSTh+uoeQ@mail.gmail.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sq-0003m6-89@rmk-PC.arm.linux.org.uk>
	<CAPDyKFq8P7eceHkPFDnyUwpfjEN_0ao0NDLoxNjE7h4KDBL=qA@mail.gmail.com>
	<20150313092030.GC8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36858 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbCMMpx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 08:45:53 -0400
Received: by obcva2 with SMTP id va2so19391069obc.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 05:45:52 -0700 (PDT)
In-Reply-To: <20150313092030.GC8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Mar 13, 2015 at 10:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 13, 2015 at 09:56:02AM +0100, Ulf Hansson wrote:
>> On 12 March 2015 at 19:31, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> > pm_genpd_remove_device() should only be called with valid and present
>> > pm domain.  There are circumstances where we may end up with something
>> > that isn't a generic PM domain in dev->pm_domain (eg, vga_switcheroo
>> > stuff.)
>>
>> Could the "vga_switcheroo" code deal with this instead?
>
> How is there any possibility what so ever that vga_switcherroo could
> deal with this?
>
> The problem is if something which isn't a generic PM domain is registered
> in dev->pm_domain, pm_genpd_remove_device() will treat it as a generic PM
> domain, and try and de-reference it as if it were a generic PM domain.
>
> The problem is the generic PM domain code _assuming_ that whatever it
> finds in dev->pm_domain is always a generic PM domain.  That is a broken
> assumption.

Indeed, currently it's not possible to know which derivative of dev_pm_domain
is used. For genpd, you have to look it up in the genpd list.
This also complicates adding debug code.
In addition, it can be statically or dynamically allocated. Hence sometimes %ps
can tell you the type, sometimes it can't.

Should we add a type field to struct dev_pm_domain?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
