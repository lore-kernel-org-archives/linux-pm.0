From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 23:27:49 +0100
Message-ID: <20100513222748.GA3240__39433.2509291873$1273789724$gmane$org@opensource.wolfsonmicro.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005132311.26293.rjw@sisk.pl>
	<1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
	<201005132327.16163.rjw@sisk.pl>
	<1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
	<20100513214653.GA21120@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100513214653.GA21120@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 13, 2010 at 02:46:53PM -0700, Greg KH wrote:
> On Thu, May 13, 2010 at 02:33:29PM -0700, Daniel Walker wrote:

> > You get the driver mainlined, then maintain a small patch to add
> > wakelocks. Not hard at all , with lots of incentive to do so since you
> > don't have to maintain such a large block of code out of tree.

> Sorry, but it doesn't seem to work that way.  Look at the large number
> of out-of-tree android device drivers that remain sitting there because
> of the lack of this interface being in the kernel.

Is that really the issue?  The ones I've looked at have mostly suffered
from being built on 2.6.29 and needing refreshes for current kernel APIs
or from general code quality issues - I don't recall ever looking at one
and thinking that the wakelocks were the one issue.

> Also note that such a driver, without wakelocks, would never get tested,
> and so, things start quickly diverging.

Chances are that if the driver is useful people will start using it in
non-Android systems anyway.  As people have already observed wakelocks
needn't have any practical effect on the running system so if the
drivers are broken without wakelocks they'd be broken anyway.  

If this really is a big concern with getting drivers into mainline then
surely we could just add some noop wakelock functions for the drivers to
call?  It's not particularly pretty but it'd deal with the driver merge
side of things.
