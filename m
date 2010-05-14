From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 14 May 2010 23:25:07 +0200
Message-ID: <201005142325.08061.rjw__4553.05820000849$1273872322$gmane$org@sisk.pl>
References: <alpine.DEB.2.00.1005122118530.7624@utopia.booyaka.com>
	<201005132356.21355.rjw@sisk.pl>
	<878w7mgqse.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <878w7mgqse.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, Kernel development list <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Oleg Nesterov <oleg@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Friday 14 May 2010, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Thursday 13 May 2010, Tony Lindgren wrote:
> >> * Rafael J. Wysocki <rjw@sisk.pl> [100513 14:16]:
> 
> [...]
> 
> >>  
> >> > It solves a practical issue that _at_ _the_ _moment_ cannot be solved
> >> > differently, while there's a growing number of out-of-tree drivers depending
> >> > on this framework.  We need those drivers in and because we don't have any
> >> > viable alternative at hand, we have no good reason to reject it.
> >> 
> >> Nothing is preventing merging the drivers can be merged without
> >> these calls.
> >
> > And yet, there _is_ a growing nuber of drivers that don't get merge because
> > of that.  That's _reality_.  Are you going to discuss with facts, or what?
> 
> It may be reality, but IMO, "preventing other drivers" isn't a good
> *technical* argument for merging a feature.  It feels like these "for
> the 'good' of the community" arguments are being used to trump the
> technical arguments.  Maybe we need to keep the separate.
> 
> Distros (especially embedded ones) have long had out of tree features
> that create barriers to getting other drivers upstream.  While it
> might be nice to see all those features upstream, no one has argued
> that they should get merged simply because they create a barrier.  Each
> feature should be merged on its own technical merit.

Well, this is very much like the selinux vs apparmour (& friends) issue.
One can argue we need only one of them, but in fact we're not worse off having
both in.

The feature is not technically unacceptable to me and since having it in
would potentially make it easier to merge quite a few drivers, I regard that as
a good enough argument for.  YMMV.

Thanks,
Rafael
