From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 00/12] thermal/x86_pkg_temp: Sanitize hotplug and locking
Date: Tue, 22 Nov 2016 17:57:04 -0000
Message-ID: <20161122175256.922158782@linutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60552 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933928AbcKVSAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 13:00:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

Changes vs. V1: Fix the package removal wreckage reported by Srinivas

We solely intended to convert that driver to the hotplug state machine and
stumbled over a large pile of insanities, which are all interwoven with the
package management:

 - The work cancelation code, the thermal zone unregistering, the work code
   and the interrupt notification function are racy against each other and
   against cpu hotplug and module exit. The random locking sprinkeled all
   over the place does not help anything and probably exists to make people
   feel good. The resulting issues (mainly use after free) are probably
   hard to trigger, but they clearly exist

 - Work cancelation in the cpu hotplug code can leave the work marked
   scheduled and the package interrupts disabled forever.

 - Storage for a boolean information whether work is scheduled for a
   package is kept in separate allocated storage, which is resized when the
   number of detected packages grows.

 - Delayed work structs are held in a static percpu storage, which makes no
   sense at all because work is strictly per package.

 - Packages are kept in a list, which must be searched over and over.

Fixing the whole pile of races with a few duct tape fixes was pretty much
impossible, so I decided to do a major rewrite to fix all of the
above. Here are the major changes:

 - Rewrite the offline code with proper locking against interrupts and work
   function and make sure that canceled work is rescheduled if there is
   another online cpu in the package.

 - Use the cpu offline callback on module exit to fix the work cancelation
   race.

 - Move the bool which denotes scheduled work into the package struct
   where it belongs.

 - Move the delayed work struct into the package struct, which is the only
   sensible place to have it and schedule the work on the cpu which is the
   target for the sysfs files as this makes the cancellation and
   rescheduling in the cpu offline path simple.

 - Add a large pile of comments documenting the cpu teardown mechanism

 - Code sanitizing, revamp the horrible name choices plus a general coding
   style cleanup.

   Note, that I did the namespace and code cleanup in the middle of the
   series, because staring at that mess just made my eyes bleeding.

 - Store the package pointers in an array which is allocated at init
   time. Sizing of the array is determined from the topology
   information. That makes the package lookup a simple array lookup.

As a last step the driver is converted to the hotplug state machine.

Thanks,
	
	tglx
---
 x86_pkg_temp_thermal.c |  593 ++++++++++++++++++++-----------------------------
 1 file changed, 249 insertions(+), 344 deletions(-)





