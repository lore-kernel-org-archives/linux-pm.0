From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V7] Report interrupt that caused system wakeup
Date: Thu, 10 Sep 2015 10:14:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509101012180.1422-100000@iolanthe.rowland.org>
References: <1441853301-3816-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53468 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752847AbbIJOOw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 10:14:52 -0400
In-Reply-To: <1441853301-3816-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Wed, 9 Sep 2015, Alexandra Yates wrote:

> This feature reports which IRQ cause the system to wakeup from sleep last
> time it was suspended.

I thought you said V7 of this patch was written based on the feedback I 
provided.  Obviously that is not true.

This feature does NOT report which IRQ caused the system to wake up
from sleep the last time it was suspended!  All it does is report one
of the IRQs which have occurred since the last time the system started
a sleep transition.

Alan Stern

