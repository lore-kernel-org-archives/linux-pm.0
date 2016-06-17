From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PM / Domains: Convert pm_genpd_init() to return an error
 code
Date: Fri, 17 Jun 2016 13:07:37 +0100
Message-ID: <5763E809.3040200@nvidia.com>
References: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdVofBY-kNULQHWmoAuovLfK4HG4Ce1VORrKekOG9vAbWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1769 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933516AbcFQMHq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 08:07:46 -0400
In-Reply-To: <CAMuHMdVofBY-kNULQHWmoAuovLfK4HG4Ce1VORrKekOG9vAbWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>


On 17/06/16 11:59, Geert Uytterhoeven wrote:
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

It seems natural that you would WARN and skip any failing PM domains and
just initialise all the ones you can. Hopefully, not all would fail and
you would have some functionality ...

Cheers
Jon

-- 
nvpublic
