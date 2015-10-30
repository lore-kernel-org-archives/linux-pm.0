From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH v2] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Fri, 30 Oct 2015 10:48:18 +0000
Message-ID: <1446202098.2815.8.camel@linaro.org>
References: <1445421333.2916.13.camel@linaro.org>
	 <20151021095725.GA7784@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from queue01a.mail.zen.net.uk ([212.23.3.234]:40329 "EHLO
	queue01a.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339AbbJ3KsX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 06:48:23 -0400
In-Reply-To: <20151021095725.GA7784@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>

On Wed, 2015-10-21 at 15:27 +0530, Viresh Kumar wrote:
> On 21-10-15, 10:55, Jon Medhurst (Tixy) wrote:
> > The check for correct frequency being set in bL_cpufreq_set_rate is
> > broken when the big.LITTLE switcher is active, for two reasons.
> > 
> > 1. The 'new_rate' variable gets overwritten before the test by the
> > code calculating the frequency of the old cluster.
> > 
> > 2. The frequency returned by bL_cpufreq_get_rate will be the virtual
> > frequency, not the actual one the intended version of new_rate contains.
> > 
> > This means the function always returns an error causing an endless
> > stream of: "cpufreq: __target_index: Failed to change cpu frequency: -5"
> > 
> > As the intent is to check for errors that clk_set_rate doesn't report
> > lets move the check to immediately after that and directly use
> > clk_get_rate, rather than the arm_big_little helpers which only confuse
> > matters. Also, update the comment to be hopefully clearer about the
> > purpose of the code.
> > 
> > Fixes: 0a95e630b49a ("cpufreq: arm_big_little: check if the frequency is set correctly")
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> > 
[...]
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Do I need to send this again with that Ack and Michael's Reviewed-by
added?

-- 
Tixy

