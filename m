From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 5 May 2010 13:09:06 -0700
Message-ID: <20100505200906.GA7450__45257.6486197815$1273094676$gmane$org@linux.intel.com>
References: <20100504160346.GA27938@linux.intel.com>
	<Pine.LNX.4.44L0.1005041252480.1729-100000@iolanthe.rowland.org>
	<20100505015050.GA30591@linux.intel.com>
	<20100505133131.GA24477@srcf.ucam.org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505133131.GA24477@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, markgross@thegnar.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 05, 2010 at 02:31:31PM +0100, Matthew Garrett wrote:
> On Tue, May 04, 2010 at 06:50:50PM -0700, mark gross wrote:
> 
> > In my sequence above I had the modem driver "magically" knowing to fail
> > this suspend attempt.  (that "magic" wasn't fully thought out though.)
> 
> If the modem driver knows to "magically" fail a suspend attempt until it 
> knows that userspace has consumed the event, you have something that 
> looks awfully like suspend blockers.
> 
> > There *has* to be a better way.
> 
> But nobody has reasonably proposed one and demonstrated that it works. 
> We've had over a year to do so and failed, and I think it's pretty 
> unreasonable to ask Google to attempt to rearchitect based on a 
> hypothetical.
>

These are not new issues being raised. They've had over a year to
address them, and all thats really happened was some sed script changes
from wake_lock to suspend_blocker.  Nothing is really different
here.

Rearchitecting out of tree code is as silly thing for you to expect from
a community member.  

sigh, lets stop wasting time and just merge it then.

I'm finished with this thread until I do some rearchecting and post
something that looks better to me.  I'll look for this stuff in 2.6.34
or 35.

--mgross 
ps It think the name suspend blocker is worse than wake-lock.  I'd
change it back.
