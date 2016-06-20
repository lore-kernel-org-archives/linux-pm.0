From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Convert pm_genpd_init() to return an error code
Date: Mon, 20 Jun 2016 13:17:17 +0200
Message-ID: <CAPDyKFqhTyGARX+ijvtsfN8GWpFQ=S00K0EidfqmaWXqz+fJ2w@mail.gmail.com>
References: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org> <CAMuHMdVofBY-kNULQHWmoAuovLfK4HG4Ce1VORrKekOG9vAbWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37123 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcFTLRT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2016 07:17:19 -0400
Received: by mail-wm0-f44.google.com with SMTP id a66so73761729wme.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 04:17:19 -0700 (PDT)
In-Reply-To: <CAMuHMdVofBY-kNULQHWmoAuovLfK4HG4Ce1VORrKekOG9vAbWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 17 June 2016 at 12:59, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Fri, Jun 17, 2016 at 12:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The are already cases when pm_genpd_init() can fail. Currently we hide the
>> failures instead of propagating an error code, which is a better method.
>>
>> Moreover, to prepare for future changes like moving away from using a
>> fixed array-size of the struct genpd_power_state, to instead dynamically
>> allocate data for it, the pm_genpd_init() API needs to be able to return
>> an error code, as allocation can fail.
>>
>> Current users of the pm_genpd_init() is thus requested to start dealing
>> with error codes. In the transition phase, users will have to live with
>> only error messages being printed to log.
>
> What can we do in case of error? It's not like anything is going to work
> if PM domains are failing...

I guess that would depend on the SoC and what particular PM domain
that would be failing.

Due to that, I would prefer to allow the user to be able to act on
errors - currently they can't.

Kind regards
Uffe
