From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM: Print pending wakeup IRQ preventing suspend
Date: Fri, 19 Sep 2014 13:21:37 +0200
Message-ID: <20140919112137.GA13233@amd>
References: <1411082555-4425-1-git-send-email-amit.pundir@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54259 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbaISLVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 07:21:41 -0400
Content-Disposition: inline
In-Reply-To: <1411082555-4425-1-git-send-email-amit.pundir@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Pundir <amit.pundir@linaro.org>
Cc: linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>

On Fri 2014-09-19 04:52:35, Amit Pundir wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Currently when a pending wakeup irq stops suspend, it can be difficult
> to determine why suspend was prevented and which IRQ was actually
> responsible. In order to help debug such situation, this patch prints the
> IRQ number and action name of that pending wakeup irq.
> 

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
