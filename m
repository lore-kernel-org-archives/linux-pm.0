From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / Sleep: Use workqueue for user space wakeup sources garbage collector
Date: Thu, 16 Jul 2015 02:29:36 +0200
Message-ID: <3758249.elpppgtaPW@vostro.rjw.lan>
References: <1435739328-17021-1-git-send-email-cleaneye.kim@lge.com> <1435906640-27641-1-git-send-email-cleaneye.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43519 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753938AbbGPAC6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:02:58 -0400
In-Reply-To: <1435906640-27641-1-git-send-email-cleaneye.kim@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SungEun Kim <cleaneye.kim@vger.kernel.org>
Cc: pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "cleaeye.kim" <cleaneye.kim@lge.com>

On Friday, July 03, 2015 03:57:20 PM SungEun Kim wrote:
> From: "cleaeye.kim" <cleaneye.kim@lge.com>
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
> 
> Signed-off-by: SungEun Kim <cleaneye.kim@lge.com>

Queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
