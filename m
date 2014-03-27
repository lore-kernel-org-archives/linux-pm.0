From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 15:53:36 +0530
Message-ID: <CAKohponoSP2s3BYNb04mZOxCegcQHua1Pz7=dWN2nGo70OJOjw@mail.gmail.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	<20140327093050.GA27777@in.ibm.com>
	<CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
	<5333FBA8.1040107@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:47462 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbaC0KXh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 06:23:37 -0400
Received: by mail-oa0-f46.google.com with SMTP id i7so4077507oag.33
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 03:23:37 -0700 (PDT)
In-Reply-To: <5333FBA8.1040107@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 27 March 2014 15:51, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> smp_processor_id() maps to debug_smp_processor_id() only if
> CONFIG_DEBUG_PREEMPT is set. Otherwise, it is same as raw_smp_processor_id().
> So I think its best to keep it as it is.

That was the case in .configs and so suggested raw_* variant. Keep it
as you want to :)
