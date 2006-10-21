From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Add include/linux/freezer.h and move definitions from
	sched.h
Date: Sun, 22 Oct 2006 08:27:21 +1000
Message-ID: <1161469641.17061.18.camel@nigel.suspend2.net>
References: <1161433266.7644.7.camel@nigel.suspend2.net>
	 <200610211541.19050.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161129AbWJUW10@vger.kernel.org>
In-Reply-To: <200610211541.19050.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>, suspend2-devel <suspend2-devel@lists.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2006-10-21 at 15:41 +0200, Rafael J. Wysocki wrote:
> On Saturday, 21 October 2006 14:21, Nigel Cunningham wrote:
> > Move process freezing functions from include/linux/sched.h to freezer.h,
> 
> Hm, I'd rather move them to suspend.h.  Is there any reason for introducing
> yet another header file?

Suspend.h sounds reasonable. I picked freezer.h because I thought it
made the purpose of the #include simple and crystal clear, and doesn't
pull in other dependencies (my freezer.h depends on nothing else, where
as suspend.h already depends on:

#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
#include <asm/suspend.h>
#endif
#include <linux/swap.h>
#include <linux/notifier.h>
#include <linux/init.h>
#include <linux/pm.h>

That said, suspend.h isn't anything like sched.h itself :)

Nigel
