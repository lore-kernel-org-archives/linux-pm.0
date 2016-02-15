From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/9] cpufreq: governor: Reset sample delay in
 store_sampling_rate()
Date: Mon, 15 Feb 2016 14:23:32 +0530
Message-ID: <20160215085332.GN6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <2770889.gQMC67V8WG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34213 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbcBOIxk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 03:53:40 -0500
Received: by mail-pf0-f174.google.com with SMTP id x65so84237520pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 00:53:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2770889.gQMC67V8WG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>

On 15-02-16, 02:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If store_sampling_rate() updates the sample delay when the ondemand
> governor is in the middle of its high/low dance (OD_SUB_SAMPLE sample
> type is set), the governor will still do the bottom half of the
> previous sample which may take too much time.
> 
> To prevent that from happening, change store_sampling_rate() to always
> reset the sample delay to 0 which also is consistent with the new
> behavior of cpufreq_governor_limits().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
