From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq: use correct values of cpus in __cpufreq_remove_dev_finish()
Date: Thu, 12 Sep 2013 12:17:19 +0530
Message-ID: <CAKohpomz-EDbRNqv58zn6B+kC1jdjrxx68hoDrAj==+YbeTj=g@mail.gmail.com>
References: <cover.1378963070.git.viresh.kumar@linaro.org>
	<8f777cc6b41b2fed4bf71ce2adc36800353d5738.1378963070.git.viresh.kumar@linaro.org>
	<523161D1.9040005@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:37527 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab3ILGrU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 02:47:20 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so10464335oag.28
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 23:47:19 -0700 (PDT)
In-Reply-To: <523161D1.9040005@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12 September 2013 12:10, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> That said, your fix doesn't look correct. See below.

I thought I was perfect !! :(

> ... and change this suitably (from 1 to 0 etc..) ? To add to it, it will look more
> clear as well:
>
> if (cpus == 0) {
>         /* No cpus in policy, so free it */
> } else {
>         /* Restart governor */
> }

Currently cpus never become zero as we clear mask only while there are
more than one cpu in a policy... Wait let me see what's the cleanest way
to get this fixed..
