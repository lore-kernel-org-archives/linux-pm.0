From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC][PATCH] PM / Runtime: Use alloc_workqueue() for
 creating PM workqueue
Date: Thu, 16 Sep 2010 10:11:30 +0200
Message-ID: <4C91D132.6090607__42491.6371739984$1284624747$gmane$org@kernel.org>
References: <201009152156.30749.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009152156.30749.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello, Rafael.

On 09/15/2010 09:56 PM, Rafael J. Wysocki wrote:
> I'm not sure about that WQ_RESCUER thing.  Can you please tell me what
> exactly it is for?

It's to guarantee forward progress for workqueues which process work
items which may be used to reclaim memory.  It reserves a rescue
worker thread to be used under memory pressure.  I finished workqueue
documentation a few days ago and sent pull request to Linus.

  http://git.kernel.org/?p=linux/kernel/git/tj/wq.git;a=blob;f=Documentation/workqueue.txt;h=e4498a2872c37a0b3b156ddc7ad7135d030d224d;hb=c54fce6eff197d9c57c97afbf6c9722ce434fc8f

So, for pm_wq, there's no reason to use WQ_RESUER.
alloc_workqueue("pm", WQ_FREEZEABLE, 0) should do it.

Thanks for doing it.

-- 
tejun
