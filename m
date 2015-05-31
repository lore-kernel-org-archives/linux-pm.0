From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
Date: Sat, 30 May 2015 20:38:22 -0500
Message-ID: <1433036302.4526.15.camel@au1.ibm.com>
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	 <55686DE5.6010001@linux.vnet.ibm.com>
	 <20150530060141.GA19134@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:57355 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758072AbbEaBji (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 May 2015 21:39:38 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <benh@au1.ibm.com>;
	Sun, 31 May 2015 11:39:36 +1000
In-Reply-To: <20150530060141.GA19134@dirshya.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: svaidy@linux.vnet.ibm.com
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, anton@samba.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org

On Sat, 2015-05-30 at 11:31 +0530, Vaidyanathan Srinivasan wrote:
> In shared lpar case, spinning in guest context may potentially take
> away cycles from other lpars waiting to run on the same physical cpu.
> 
> So the policy in shared lpar case is to let PowerVM hypervisor know
> immediately that the guest cpu is idle which will allow the hypervisor
> to use the cycles for other tasks/lpars.

But that will have negative side effects under KVM no ?

Suresh mentioned something with his new directed interrupts code that we
had many cases where the interrupts ended up arriving shortly after we
exited to host for NAP'ing ...

Snooze might fix it...

Ben.


