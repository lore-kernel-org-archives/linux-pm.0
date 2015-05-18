From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] PM / sleep: Make ->enter_freeze callbacks depend on
 CONFIG_SUSPEND
Date: Mon, 18 May 2015 14:18:26 +0200
Message-ID: <20150518121826.GG21418@twins.programming.kicks-ass.net>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan>
 <2834114.lD6BFXhtqK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45241 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481AbbERMSk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 08:18:40 -0400
Content-Disposition: inline
In-Reply-To: <2834114.lD6BFXhtqK@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>

On Sat, May 16, 2015 at 01:38:48AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ->enter_freeze callbacks of cpuidle drivers are only used if
> CONFIG_SUSPEND is set, so make them explicitly depend on that
> Kconfig option.

No real objection, but is it worth it to sprinkle that CONFIG stuff over
all drivers?
