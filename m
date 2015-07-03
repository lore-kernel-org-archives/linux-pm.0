From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / Sleep: Use workqueue for user space wakeup sources garbage collector
Date: Fri, 03 Jul 2015 02:15:49 +0200
Message-ID: <1544571.4tSqBEqESU@vostro.rjw.lan>
References: <1435718938-19088-1-git-send-email-cleaneye.kim@lge.com> <1435739328-17021-1-git-send-email-cleaneye.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54350 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754258AbbGBXta (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 19:49:30 -0400
In-Reply-To: <1435739328-17021-1-git-send-email-cleaneye.kim@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SungEun Kim <cleaneye.kim@lge.com>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, July 01, 2015 05:28:48 PM SungEun Kim wrote:
> From: "SungEun Kim" <cleaneye.kim@lge.com>
> 
> The synchronous synchronize_rcu in wakeup_source_remove makes user process
> which writes to /sys/kernel/wake_unlock blocked sometimes.
> 
> For example, when android eventhub tries to release wakelock,
> this blocking process can occur, and eventhub can't get input event
> for a while.
> 
> Using workqueue instead of direct function call at pm_wake_unlock
> can prevent this unnecessary delay of an user space process.

The idea is defendable, but the patch is too simple.

For example, if the garbage collection is in progress, it is not useful
to start a new one.

Also the incrementation and clearing of wakelocks_gc_count should be under
the lock.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
