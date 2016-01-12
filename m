From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v4 4/4] cpufreq: powernv: Add sysfs attributes to
 show throttle stats
Date: Tue, 12 Jan 2016 16:43:01 +0530
Message-ID: <20160112111301.GB4187@in.ibm.com>
References: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452594267-12844-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:43442 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbcALLNK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 06:13:10 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Tue, 12 Jan 2016 06:13:10 -0500
Content-Disposition: inline
In-Reply-To: <1452594267-12844-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

Hi Shilpa,

On Tue, Jan 12, 2016 at 04:24:27AM -0600, Shilpasri G Bhat wrote:

> +static inline int get_chip_index(struct kobject *kobj)

Probably have "get_chip_index(int id)". See the reason below.
> +{
> +	int i, id;
> +
> +	i = kstrtoint(kobj->name + 4, 0, &id);
> +	if (i)
> +		return i;
> +
> +	for (i = 0; i < nr_chips; i++)
> +		if (chips[i].id == id)
> +			return i;

This pattern to obtain a chip index from the chip id is repeated in
multiple place inside this file. Might be worthwhile to move this to a
helper function, i.e get_chip_index(id)!

> +	return -EINVAL;
> +}
> +
> +static ssize_t throttle_freq_show(struct kobject *kobj,
> +				  struct kobj_attribute *attr, char *buf)
> +{
> +	int i, count = 0, id;
> + 
        We obtain the id from kobj here and then obtain the index from
	id via the function below.
	

> +	id = get_chip_index(kobj);


> +	if (id < 0)
> +		return id;
> +
> +	for (i = 0; i < powernv_pstate_info.nr_pstates; i++)
> +		count += sprintf(&buf[count], "%d %d\n",
> +			       powernv_freqs[i].frequency,
> +			       chips[id].pstate_stat[i]);
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute attr_throttle_frequencies =
> +__ATTR(throttle_frequencies, 0444, throttle_freq_show, NULL);
> +
--
Thanks and Regards
gautham.

