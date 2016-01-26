From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2] PM / Domains: Fix potential deadlock while
 adding/removing subdomains
Date: Tue, 26 Jan 2016 15:59:19 +0100
Message-ID: <CAPDyKFqb5q0fokUo2mU=9SrEEA7aq6ZVQfz9UvuEMKhj+edrUw@mail.gmail.com>
References: <1453288059-1988-1-git-send-email-ulf.hansson@linaro.org>
	<1538718.ZBD87lgpJv@vostro.rjw.lan>
	<CAMuHMdUfSCRh6Nxrfm9pSY2HvC3WKJ6_ZtFgzscv=9GoYR+puQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35239 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966399AbcAZO7U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2016 09:59:20 -0500
Received: by mail-yk0-f170.google.com with SMTP id u68so73349186ykd.2
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2016 06:59:19 -0800 (PST)
In-Reply-To: <CAMuHMdUfSCRh6Nxrfm9pSY2HvC3WKJ6_ZtFgzscv=9GoYR+puQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On 26 January 2016 at 14:13, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Sun, Jan 24, 2016 at 2:20 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, January 20, 2016 12:07:39 PM Ulf Hansson wrote:
>>> We must preserve the same order of how we acquire and release the lock for
>>> genpd, as otherwise we may encounter deadlocks.
>>>
>>> The power on phase of a genpd starts by acquiring its lock. Then it walks
>>> the hierarchy of its parent domains to be able to power on these first, as
>>> per design of genpd.
>>>
>>> From a locking perspective this means the locks of the parents becomes
>>> acquired after the lock of the subdomain.
>>>
>>> Let's fix pm_genpd_add|remove_subdomain() to maintain the same order of
>>> acquiring/releasing the genpd lock as being applied in the power on/off
>>> sequence.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Applied, thanks!
>
> It looks like you accidentally applied v1, introducing the lockdep warnings
> fixed in v2?
>

Correct, it's the v1.

Rafael, if you can't replace the patch I can send an incremental fix
on top. Just tell me what way you prefer.

Kind regards
Uffe
