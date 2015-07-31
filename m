From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Sat, 01 Aug 2015 01:56:19 +0200
Message-ID: <1708156.vTh2kYamEW@vostro.rjw.lan>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org> <1437555322.5445.2.camel@suse.com> <CAJvTdKmAvygm9dt4qJetvRLeh-6pmPKP_rBd-xfFW-30_sQpXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57187 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751413AbbGaX3U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 19:29:20 -0400
In-Reply-To: <CAJvTdKmAvygm9dt4qJetvRLeh-6pmPKP_rBd-xfFW-30_sQpXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, July 31, 2015 12:02:36 PM Len Brown wrote:
> On Wed, Jul 22, 2015 at 4:55 AM, Oliver Neukum <oneukum@suse.com> wrote:
> > On Wed, 2015-07-22 at 03:25 +0200, Rafael J. Wysocki wrote:
> >> And it is more pain for me to change the user space on each of them to
> >> write to the new sysfs file on every boot than to set a kernel Kconfig
> >> option once.
> >
> > So why at all? If you really need this in sysfs, why not write
> > something like "memfast" into /sys/power/state ?
> 
> We fought this battle, and lost.
> 
> When we came out with "freeze", which is faster than "mem",
> no user-space changed to take advantage of it.

I do think that Chrome is going to use "freeze", so maybe it's not a lost
battle after all?

The problem with "memfast" and similar things is we'd also need "freezefast"
and "standbyfast" then, for consistency if nothing else, which makes a little
sense to me.

BTW, it should be noted that the whole "sync in the kernel is better, because
it doesn't race with user space writing to disks" argument was completely
bogus and useless, because in fact the sync in the kernel is done before
freezing user space and which means that it is susceptible to the very same
race condition as the sync from user space.

So if your user space does the sync before suspending, the next one in the
kernel is completely useless.

Thanks,
Rafael

