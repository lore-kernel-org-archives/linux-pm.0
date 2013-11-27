From: jacob pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 0/3] Hook up powerclamp with PM QOS and cpuidle
Date: Wed, 27 Nov 2013 08:47:32 -0800
Message-ID: <20131127084732.00006425@unknown>
References: <1385508011-26914-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<20131127115634.GA10022@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8419 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757237Ab3K0Qr7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Nov 2013 11:47:59 -0500
In-Reply-To: <20131127115634.GA10022@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>

On Wed, 27 Nov 2013 12:56:34 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Nov 26, 2013 at 03:20:08PM -0800, Jacob Pan wrote:
> > This patchset is intended to address the behavior change and
> > efficiency loss introduced by using consolidated idle routine in
> > powerclamp driver.
> > 
> > Specifically,
> > [PATCH 3/8] idle, thermal, acpi: Remove home grown idle
> > implementations
> > 
> > The motivation is that after using common idle routine, powerclamp
> > driver can no longer pick the deepest idle state needed to conserve
> > power. Idle state is selected by governors which can be influenced
> > by PM QOS and other factors. This patchset hooks up powerclamp idle
> > injection with PM QOS and eventually influce idle governors to pick
> > the power saving target states.
> > 
> > There are some downside of this approach. Due to overhead,
> > communication with PM QOS is at enable/disable idle injection time
> > instead of each injection period. The implication is that if the
> > system natual idle is more than target injected idle, powerclamp
> > will skip some injection period. During this period however,
> > deepest idle state may still be chosen necessarily regardless the
> > latency constraint.
> 
> Does the QoS stuff have a means of notifying its users of constraints
> violation? I suspect some applications might light to be told if their
> requests aren't honoured.
> 
Each class has a notifier. This patchset is calling the notifier
when the qos class is disable/enable. the receiver of these
notifications are in the kernel.

I don't see the qos core code has a way to signal userspace about
target change.

