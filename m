From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: Introduce cpufreq_update_current_freq()
Date: Tue, 22 Mar 2016 08:46:16 +0530
Message-ID: <20160322031616.GS27778@vireshk-i7>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan>
 <4711274.maD9A8j7Lu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33755 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbcCVDQT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 23:16:19 -0400
Received: by mail-pf0-f172.google.com with SMTP id 4so159137284pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 20:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4711274.maD9A8j7Lu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21-03-16, 15:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the part of cpufreq_update_policy() that obtains the current
> frequency from the driver and updates policy->cur if necessary to
> a separate function, cpufreq_get_current_freq().
> 
> That should not introduce functional changes and subsequent change
> set will need it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
