From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Thu, 21 Apr 2016 12:50:42 +0200
Message-ID: <20160421105042.GI3408@twins.programming.kicks-ass.net>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39107 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbcDUKuq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 06:50:46 -0400
Content-Disposition: inline
In-Reply-To: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: tglx@linutronix.de, oleg@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Apr 20, 2016 at 09:56:07PM -0700, Lianwei Wang wrote:
> Currently it just print a warning message but did not
> reset cpu_hotplug_disabled when the enable/disable is
> unbalanced. The unbalanced enable/disable will lead
> the cpu hotplug work abnormally.
> 
> Reset it to 0 when an unablanced enable detected.

How can this happen in the first place?
