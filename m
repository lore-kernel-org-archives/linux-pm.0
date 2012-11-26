From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] PM: Introduce Intel PowerClamp Driver
Date: Mon, 26 Nov 2012 15:27:25 -0800
Message-ID: <1353972445.2493.19.camel@joe-AO722>
References: <1353940633-20084-1-git-send-email-jacob.jun.pan@linux.intel.com>
	 <1353940633-20084-4-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:47866 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755309Ab2KZX10 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 26 Nov 2012 18:27:26 -0500
In-Reply-To: <1353940633-20084-4-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, 2012-11-26 at 06:37 -0800, Jacob Pan wrote:
> Intel PowerClamp driver performs synchronized idle injection across
> all online CPUs. The goal is to maintain a given package level C-state
> ratio.

trivial notes:

> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c

You should still add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
before any include so that all messages are prefixed with powerclamp:

> +
> +/* #define DEBUG */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
[]
> +static void adjust_compensation(int target_ratio, unsigned int win)
> +{
> +	int delta;

It'd be shorter code to use a temporary like

	struct powerclamp_calibration_data *d = &cal_data[target_ratio];

> +
> +	/*
> +	 * adjust compensations if confidence level has not been reached or
> +	 * there are too many wakeups during the last idle injection period, we
> +	 * cannot trust the data for compensation.
> +	 */
> +	if (cal_data[target_ratio].confidence >= CONFIDENCE_OK ||
> +		atomic_read(&idle_wakeup_counter) >
> +		win * num_online_cpus())
> +		return;
> +
> +	delta = set_target_ratio - current_ratio;
> +	/* filter out bad data */
> +	if (delta >= 0 && delta <= (1+target_ratio/10)) {
> +		if (cal_data[target_ratio].steady_comp)
> +			cal_data[target_ratio].steady_comp =
> +				roundup(delta+
> +					cal_data[target_ratio].steady_comp,
> +					2)/2;

so that this fits on a single line and becomes:

		if (d->steady_comp)
			d->steady_comp = roundup(delta + d->steady_comp, 2) / 2;
 
	etc.

What clamps target_ratio to the correct range?
I briefly scanned the code but didn't spot it.

