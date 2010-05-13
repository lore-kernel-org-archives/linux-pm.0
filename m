From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 14:46:53 -0700
Message-ID: <20100513214653.GA21120__21958.7021311328$1273787477$gmane$org@suse.de>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005132311.26293.rjw@sisk.pl>
	<1273785399.19100.98.camel@c-dwalke-linux.qualcomm.com>
	<201005132327.16163.rjw@sisk.pl>
	<1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 13, 2010 at 02:33:29PM -0700, Daniel Walker wrote:
> On Thu, 2010-05-13 at 23:27 +0200, Rafael J. Wysocki wrote:
> 
> > Because someone would have to remove suspend blockers (or rather wakelocks)
> > from the drivers, test that they work correctly without suspend blockers and
> > submit the modified versions.  Going forward, every party responsible for such
> > a driver would have to maintain an out-of-tree version with suspend blockers
> > (or wakelocks) anyway, so the incentive to do that is zero.
> 
> They should work without wakelock since wakelock are optional .. I mean
> there's nothing in suspend blockers I've seen that indicates it's
> required for some drivers to work. So it's just a matter of patching out
> the wakelocks, with no need to re-test anything.
> 
> You get the driver mainlined, then maintain a small patch to add
> wakelocks. Not hard at all , with lots of incentive to do so since you
> don't have to maintain such a large block of code out of tree.

Sorry, but it doesn't seem to work that way.  Look at the large number
of out-of-tree android device drivers that remain sitting there because
of the lack of this interface being in the kernel.

Also note that such a driver, without wakelocks, would never get tested,
and so, things start quickly diverging.

thanks,

greg k-h
