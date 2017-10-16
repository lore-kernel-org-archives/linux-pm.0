From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V13 1/7] PM / Domains: Add support to select
 performance-state of domains
Date: Mon, 16 Oct 2017 14:26:34 +0530
Message-ID: <20171016085634.GC21613@vireshk-i7>
References: <431a7a5803b4a552dfe2a71700e19b904c6d16dc.1507703370.git.viresh.kumar@linaro.org>
 <990605fb7b17b75abe63c542a4be2e176152b9f6.1507800860.git.viresh.kumar@linaro.org>
 <7hk1zvx36t.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:52012 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdJPI4h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Oct 2017 04:56:37 -0400
Received: by mail-pf0-f177.google.com with SMTP id n14so15325826pfh.8
        for <linux-pm@vger.kernel.org>; Mon, 16 Oct 2017 01:56:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hk1zvx36t.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

On 16-10-17, 03:59, Kevin Hilman wrote:
> I have some usecases in mind where the performance state might need to
> be selected based on OPP voltage, but that's now a change that can be
> added later when that feature is needed.

I will be more than happy to get that in.

> Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Thanks.

Do you think its a good time to get some bindings for this stuff now? The
bindings would be required for only users and not PM domains themselves for now.
Users are:

- OPP core: need per-OPP entry value for performance state.
- Devices: devices directly using the PM domain without OPP core (don't have
  DVFS). They can use the same property.

It might look similar to the properties I initially started with, I can just get
them refreshed.

-- 
viresh
