From: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
Date: Wed, 15 Jul 2015 15:47:01 +0930
Message-ID: <1436941021.17171.12.camel@jms.id.au>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	 <1436796602-10228-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36467 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbbGOGRJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 02:17:09 -0400
In-Reply-To: <1436796602-10228-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello,

On Mon, 2015-07-13 at 19:39 +0530, Shilpasri G Bhat wrote:
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d0c18c9..1f59958 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -414,6 +415,71 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
>  
> +static char throttle_reason[][30] = {
> +					"No throttling",
> +					"Power Cap",
> +					"Processor Over Temperature",
> +					"Power Supply Failure",
> +					"Over Current",
> +					"OCC Reset"
> +				     };
> +
> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
> +				   unsigned long msg_type, void *_msg)
> +{
> +	struct opal_msg *msg = _msg;
> +	struct opal_occ_msg omsg;
> +
> +	if (msg_type != OPAL_MSG_OCC)
> +		return 0;
> +
> +	memcpy(&omsg, msg->params, sizeof(omsg));

You need to ensure the of the members of struct opal_occ_msg are in the
correct byte order when copying them over.

Have you tested this code with in a little endian configuration?

Do the messages you're sending make sense for a system that has a BMC
instead of a FSP?

Cheers,

Joel

> +
> +	switch (omsg.type) {

