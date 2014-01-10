From: poma <pomidorabelisima@gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 0 at kernel/time/tick-broadcast.c:667
Date: Fri, 10 Jan 2014 04:00:57 +0100
Message-ID: <52CF6269.8030105@gmail.com>
References: <52157D88.3070701@gmail.com> <20131017093854.GA19052@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:42893 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbaAJDBD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 22:01:03 -0500
In-Reply-To: <20131017093854.GA19052@aepfle.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On 17.10.2013 11:38, Olaf Hering wrote:
>> Waking up from system sleep state S3:
> 
>> ------------[ cut here ]------------
>> WARNING: CPU: 2 PID: 0 at kernel/time/tick-broadcast.c:667
>> tick_broadcast_oneshot_control+0x181/0x190()
> 
> 
> Thomas,
> 
> this WARN_ON_ONCE happens on resume on my HP ProBook 6555b.
> Is it still needed to be verbose in such case? It was introduced with
> commit 26517f3e99248668315aee9460dcea21628cdd7f ("tick: Avoid
> programming the local cpu timer if broadcast pending").

3.10.2 - 3.13.0-0.rc7:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at kernel/time/tick-broadcast.c:668
tick_broadcast_oneshot_control+0x17d/0x190()
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.13.0-0.rc7.git2.2.fc21.x86_64 #1
Call Trace:
 [<ffffffff81680a6a>] dump_stack+0x45/0x56
 [<ffffffff8106841d>] warn_slowpath_common+0x7d/0xa0
 [<ffffffff810684fa>] warn_slowpath_null+0x1a/0x20
 [<ffffffff810cf16d>] tick_broadcast_oneshot_control+0x17d/0x190
 [<ffffffff810cdcb8>] clockevents_notify+0x178/0x1a0
 [<ffffffff8101c17b>] amd_e400_idle+0x7b/0x100
 [<ffffffff8101c916>] arch_cpu_idle+0x26/0x30
 [<ffffffff810bb425>] cpu_startup_entry+0xc5/0x290
 [<ffffffff81040bab>] start_secondary+0x22b/0x2e0
---[ end trace a6717546b328eaba ]---


poma


