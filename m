From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 15:52:01 +0530
Message-ID: <CAKohpokqQGZPSsPXNeteEPu-HvDZtqvWPfFY+naWXkRAtXB_nA@mail.gmail.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	<20140327093050.GA27777@in.ibm.com>
	<20140327101137.GA8747@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38459 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbaC0KWB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 06:22:01 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so4021550oag.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 03:22:01 -0700 (PDT)
In-Reply-To: <20140327101137.GA8747@dirshya.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 27 March 2014 15:41, Vaidyanathan Srinivasan
<svaidy@linux.vnet.ibm.com> wrote:
>> > Why do you need to get these from DT? And not find that yourself here instead?

> DT provides the values that we should use.  Ideally these are the
> upper and lower limits of the PState table,  however as per the
> platform spec, we should use the PState IDs between these limits.  We
> would like to parse it and keep it in the driver for debug purposes.
>
> The platform exports this info in the DT to be more explicit and not
> have a strong dependency on the PState numbering or PState table
> itself.  In the driver we parse it for debug/validation purpose.

I couldn't find how they are used for debugging except this:

+ pr_info("cpufreq pstate min %d nominal %d max %d\n", pstate_min,
+ pstate_nominal, pstate_max);

This is the only place where these values are used.

Anyway, you can keep it if you really want to..
