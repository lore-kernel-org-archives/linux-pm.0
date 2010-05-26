From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 14:20:51 +0100
Message-ID: <20100526132051.GA1834__4319.49805138192$1274880129$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<1274863987.5882.4892.camel@twins>
	<20100526124929.GA32580@srcf.ucam.org>
	<1274878665.27810.354.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1274878665.27810.354.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 26, 2010 at 02:57:45PM +0200, Peter Zijlstra wrote:

> I fail to see why. In both cases the woken userspace will contact a
> central governing task, either the kernel or the userspace suspend
> manager, and inform it there is work to be done, and please don't
> suspend now.

Thinking about this, you're right - we don't have to wait, but that does 
result in another problem. Imagine we get two wakeup events 
approximately simultaneously. In the kernel-level universe the kernel 
knows when both have been handled. In the user-level universe, we may 
have one task schedule, bump the count, handle the event, drop the count 
and then we attempt a suspend again because the second event handler 
hasn't had an opportunity to run yet. We'll then attempt a suspend and 
immediately bounce back up. That's kind of wasteful, although it'd be 
somewhat mitigated by checking that right at the top of suspend entry 
and returning -EAGAIN or similar.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
