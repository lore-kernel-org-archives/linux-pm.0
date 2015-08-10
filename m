From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/6] cpufreq: powernv: Register for OCC related opal_message notification
Date: Mon, 10 Aug 2015 18:19:08 +1000
Message-ID: <m3zj1zd08z.fsf@oc8180480414.ibm.com>
References: <1437033863-15864-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1437033863-15864-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <m3y4hjex8q.fsf@oc8180480414.ibm.com> <55C857F8.6090502@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:45694 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389AbbHJITO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 04:19:14 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Mon, 10 Aug 2015 04:19:13 -0400
In-Reply-To: <55C857F8.6090502@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, joel@jms.id.au

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> Also, do we export this information via sysfs somewhere? It would seem
>> to want to go along with other cpufreq/cpu info there.
>
> No we don't export the throttling status of the cpu via sysfs. Since the
> throttling state is common across the chip, the per_cpu export will be
> redundant. Did you mean something like one of the below:
>
> 1)/sys/devices/system/cpu/cpufreq/chipN_throttle
>
> 2)/sys/devices/system/cpu/cpuN/cpufreq/throttle

yeah, I was thinking something like that.

