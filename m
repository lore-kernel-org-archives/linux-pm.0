From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 13 May 2010 23:54:24 +0200
Message-ID: <201005132354.24259.rjw__33507.475074339$1273787719$gmane$org@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1273786409.19100.104.camel@c-dwalke-linux.qualcomm.com>
	<20100513213656.GL3428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100513213656.GL3428@atomide.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg KH <gregkh@suse.de>, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 May 2010, Tony Lindgren wrote:
> * Daniel Walker <dwalker@fifo99.com> [100513 14:28]:
> > On Thu, 2010-05-13 at 23:27 +0200, Rafael J. Wysocki wrote:
> > 
> > > Because someone would have to remove suspend blockers (or rather wakelocks)
> > > from the drivers, test that they work correctly without suspend blockers and
> > > submit the modified versions.  Going forward, every party responsible for such
> > > a driver would have to maintain an out-of-tree version with suspend blockers
> > > (or wakelocks) anyway, so the incentive to do that is zero.
> > 
> > They should work without wakelock since wakelock are optional .. I mean
> > there's nothing in suspend blockers I've seen that indicates it's
> > required for some drivers to work. So it's just a matter of patching out
> > the wakelocks, with no need to re-test anything.
> > 
> > You get the driver mainlined, then maintain a small patch to add
> > wakelocks. Not hard at all , with lots of incentive to do so since you
> > don't have to maintain such a large block of code out of tree.
> > 
> > > Practically, as long as the opportunistic suspend is out of tree, there will be
> > > a _growing_ number of out-of-tree drivers out there, which is not acceptable
> > > in the long run.
> > 
> > I don't see why your saying that. These driver should work with out all
> > of this, which means they can get mainlined right now.
> 
> I agree with Daniel here. We should keep merging the drivers separate
> from the suspend blocks issues.

Unfortunately, that's completely unrealistic.  Please refer to the Greg's reply
for details.

Rafael
