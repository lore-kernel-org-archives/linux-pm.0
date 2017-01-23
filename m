From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Delayed acpi frequency governor call
Date: Mon, 23 Jan 2017 15:41:45 +0530
Message-ID: <20170123101145.GB26681@vireshk-i7>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
 <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33685 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAWKME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2017 05:12:04 -0500
Received: by mail-pg0-f51.google.com with SMTP id 204so44077094pge.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2017 02:12:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, venkatesh.pallipadi@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 20-01-17, 16:27, Philipp Miedl wrote:
> This is not my issue. The code I'm referring to can be found in
> cpufreq_governor.c:
> <-->
> if (unlikely(wall_time > (2 * sampling_rate) &&
>        j_cdbs->prev_load)) {

This only confirms that the CPU was idle for sometime.

>   load = j_cdbs->prev_load;
> 
>   /*
>    * Perform a destructive copy, to ensure that we copy
>    * the previous load only once, upon the first wake-up
>    * from idle.
>    */
>   j_cdbs->prev_load = 0;
> } else {
>   load = 100 * (wall_time - idle_time) / wall_time;
>   j_cdbs->prev_load = load;
> }
> <-->
> 
> How can it happen that "unlikely(wall_time > (2 * sampling_rate)" is true
> although the CPU utilization was 5%?

I am not sure how your test works, etc. Maybe try to generate traces for your
CPUs to see if they are going into idle or not. Maybe you are having a hard time
because of SMP platform ?

-- 
viresh
