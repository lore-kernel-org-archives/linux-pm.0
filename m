From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
Date: Wed, 3 Jun 2015 21:05:57 +0530
Message-ID: <20150603153557.GA5983@dirshya.in.ibm.com>
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <55686DE5.6010001@linux.vnet.ibm.com>
 <20150530060141.GA19134@dirshya.in.ibm.com>
 <1433036302.4526.15.camel@au1.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:55831 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbbFCPgP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 11:36:15 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <svaidy@linux.vnet.ibm.com>;
	Wed, 3 Jun 2015 21:06:13 +0530
Content-Disposition: inline
In-Reply-To: <1433036302.4526.15.camel@au1.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, anton@samba.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

* Benjamin Herrenschmidt <benh@au1.ibm.com> [2015-05-30 20:38:22]:

> On Sat, 2015-05-30 at 11:31 +0530, Vaidyanathan Srinivasan wrote:
> > In shared lpar case, spinning in guest context may potentially take
> > away cycles from other lpars waiting to run on the same physical cpu.
> > 
> > So the policy in shared lpar case is to let PowerVM hypervisor know
> > immediately that the guest cpu is idle which will allow the hypervisor
> > to use the cycles for other tasks/lpars.
> 
> But that will have negative side effects under KVM no ?

Yes, you have a good point.  If one of the thread in the core goes to
cede, it can still come back quickly since the KVM guest context is
not switched yet.  But in single threaded guest, this can force an
unnecessary exit/context switch overhead.

Now that we have fixed the snooze loop to be bounded and exit
predictably, KVM guest should actually use snooze state to improve
latency.

I will test this scenario and enable snooze state for KVM guest.
 
> Suresh mentioned something with his new directed interrupts code that we
> had many cases where the interrupts ended up arriving shortly after we
> exited to host for NAP'ing ...
> 
> Snooze might fix it...

Right.  This scenario is worth experimenting and then introduce snooze
loop for guest.

--Vaidy

