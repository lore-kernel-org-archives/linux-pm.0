From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 16:59:24 +0530
Message-ID: <CAKohpom7TekvQmAO6yPqSrPQ2yz10vOezKrWh=aA5vWCE=jS+A@mail.gmail.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
	<20140327093050.GA27777@in.ibm.com>
	<CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
	<20140327112031.GC27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:56046 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbaC0L3Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 07:29:25 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so4101824obc.17
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 04:29:24 -0700 (PDT)
In-Reply-To: <20140327112031.GC27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 27 March 2014 16:50, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> (That said, in the future if we want to export additional
> information, say pertaining to the voltage, we will have to keep a
> separate array anyway :-) )

Lets handle that once it comes.

> However, as of now, I am wary about reusing a variable provided by
> the core, whose type is fixed (which is not the type I am interested
> in) and whose interpretation is ambiguous (since it is also being used
> as a BOOST indicator).

I understand that..

> When we have a .is_boost field, or a flags field in the cpufreq_table,

Probably we might keep it as is and take the patch which I already
sent. In that case as well your stuff will continue to work..

> and once the .driver_data field is completely opaque, I would be
> comfortable making use of .driver_data to store the pstate_ids. So
> I'll send out those patches once the fixes are present in the
> core. For now, let this code stay as it is. I think we should be ok
> with the additional overhead of 1kb as of now.

Chances are more that all my changes would make it before this
driver and then you would be required to update this driver
before submission.
