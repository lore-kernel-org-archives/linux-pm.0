From: Olaf Hering <olaf@aepfle.de>
Subject: Re: WARNING: CPU: 1 PID: 0 at kernel/time/tick-broadcast.c:667
Date: Thu, 17 Oct 2013 11:38:54 +0200
Message-ID: <20131017093854.GA19052@aepfle.de>
References: <52157D88.3070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:46459 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3JQJi6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2013 05:38:58 -0400
Content-Disposition: inline
In-Reply-To: <52157D88.3070701@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: poma <pomidorabelisima@gmail.com>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

> Waking up from system sleep state S3:

> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 0 at kernel/time/tick-broadcast.c:667
> tick_broadcast_oneshot_control+0x181/0x190()


Thomas,

this WARN_ON_ONCE happens on resume on my HP ProBook 6555b.
Is it still needed to be verbose in such case? It was introduced with
commit 26517f3e99248668315aee9460dcea21628cdd7f ("tick: Avoid
programming the local cpu timer if broadcast pending").


Olaf
