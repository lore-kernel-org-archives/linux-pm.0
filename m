From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/12] cpufreq: governor: Move io_is_busy to struct
 dbs_data
Date: Thu, 18 Feb 2016 10:58:50 +0530
Message-ID: <20160218052850.GH2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <291154692.LHGJ2D0EYz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36669 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbcBRF3E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 00:29:04 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so24240437pab.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 21:29:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <291154692.LHGJ2D0EYz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The io_is_busy governor tunable is only used by the ondemand governor
> and is located in the ondemand-specific data structure, but it is
> looked at by the common governor code that has to do ugly things to
> get to that value, so move it to struct dbs_data and modify ondemand
> accordingly.
> 
> Since the conservative governor never touches that field, it will
> be always 0 for that governor and it won't have any effect on the
> results of computations in that case.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   27 +++++++++------------------
>  drivers/cpufreq/cpufreq_governor.h |    2 +-
>  drivers/cpufreq/cpufreq_ondemand.c |   12 +++++-------
>  3 files changed, 15 insertions(+), 26 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
