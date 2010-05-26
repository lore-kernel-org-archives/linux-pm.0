From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 14:57:45 +0200
Message-ID: <1274878665.27810.354.camel__7155.60638714141$1274878718$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins> <1274863987.5882.4892.camel@twins>
	<20100526124929.GA32580@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526124929.GA32580@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-05-26 at 13:49 +0100, Matthew Garrett wrote:

Lack of quoting makes it hard to see what your 'this' refers to. I'll
assume its the userspace suspend manager.

> While this approach could be made to work, it's ugly in other ways. 
> After wakeup, userspace has to pause for a while before it can trigger 
> another sleep in order to give all the apps an opportunity to check for 
> wakeup events and block suspend if they wish to. That's additional 
> runtime that doesn't exist in the kernel-mediated case.

I fail to see why. In both cases the woken userspace will contact a
central governing task, either the kernel or the userspace suspend
manager, and inform it there is work to be done, and please don't
suspend now.

Also, since we did get woken, there clearly is work to do and we should
only try suspending again once someone did inform us of completing it.

In both cases, once the event is fully handled, will there be
communication of this fact and suspend can be attempted.

I don't see a reason to 'wait' for anything -- except maybe speculate on
the avgerage wakeup rate and decide not to suspend quite yet.
