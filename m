From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: make sync() on suspend-to-RAM optional
Date: Fri, 31 Jul 2015 12:02:36 -0400
Message-ID: <CAJvTdKmAvygm9dt4qJetvRLeh-6pmPKP_rBd-xfFW-30_sQpXg@mail.gmail.com>
References: <1436927091-32520-1-git-send-email-lenb@kernel.org>
	<CAJZ5v0gNKRRaXvfqvj4YEjb+7X1aEobfvWuWyAnAcKArcxtZPA@mail.gmail.com>
	<20150721151941.GA19581@amd>
	<7453812.eRsb3OQU2z@vostro.rjw.lan>
	<1437555322.5445.2.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34703 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbGaQCi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 12:02:38 -0400
In-Reply-To: <1437555322.5445.2.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>, "Brown, Len" <len.brown@intel.com>, Austin S Hemmelgarn <ahferroin7@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jul 22, 2015 at 4:55 AM, Oliver Neukum <oneukum@suse.com> wrote:
> On Wed, 2015-07-22 at 03:25 +0200, Rafael J. Wysocki wrote:
>> And it is more pain for me to change the user space on each of them to
>> write to the new sysfs file on every boot than to set a kernel Kconfig
>> option once.
>
> So why at all? If you really need this in sysfs, why not write
> something like "memfast" into /sys/power/state ?

We fought this battle, and lost.

When we came out with "freeze", which is faster than "mem",
no user-space changed to take advantage of it.
"mem" is what they use on all platforms, and they simply want it to be fast.

I don't like the run-time sysfs attribute in this patch.
There are only 4 use-cases, and we can handle the 3 that matter
without a sysfs attribute:

1. OS wants sync, run-time never changes mind
    compile kernel with sync
    this is default, and what everybody is accustomed to.

2. OS does not want sync, run-time never changes mind
    compile kernel without sync
    This gives OS' that care about suspend/resume latency what they want.
    I'm fine with Austin's suggestion "depends on EXPERT"

3. OS  wants sync, run-time wants to opt-OUT
    Sorry, we'll not support his case.
    If your run a distro kernel that builds in the sync, you are stuck with it.
    If you care, then build a kernel from scratch, or run a different distro.

4. OS does not want sync, run-time sometimes wants to opt-IN
    As it turns out, Linux kernel has always invoked sync before freezing
    user-threads.  Sorry, invoking sync in kernel suspend path does not close
    a race that isn't also currently present by invoking sync from user-space.

   (yes, as discussed, the proper long term fix involves notifying file systems)

    As this user will not have a sysfs attribute to tweak to tell the
kernel to sync,
    they can simply invoke sync from user-space.

thanks,
Len Brown, Intel Open Source Technology Center
