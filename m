From: tytso@mit.edu
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 15:55:34 -0400
Message-ID: <20100505195534.GD18762__19154.7157861807$1273091067$gmane$org@thunk.org>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<20100505192208.GB5085@srcf.ucam.org>
	<20100505195249.GC11441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100505195249.GC11441@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

I confess I've completely lost track of (a) what problem you are
trying to solve, and (b) how this might relate to some change that
you'd like to see in the suspend block API.  Could you do a quick
summary and recap?  I've gone over the entire thread, and it's still
not clear what change you're advocating for in suspend blockers.

Thanks, regards,

						- Ted

On Wed, May 05, 2010 at 08:52:50PM +0100, Mark Brown wrote:
> On Wed, May 05, 2010 at 08:22:08PM +0100, Matthew Garrett wrote:
> > On Wed, May 05, 2010 at 03:13:52PM -0400, Alan Stern wrote:
> 
> > > Does it know when a call is in progress?
> 
> > Perhaps you could infer that from the audio routing setup? I don't know 
> > enough about embedded codecs.
> 
> Yes, you can providing we extract a bit more information from the
> machine drivers and/or userspace - we already do our power management
> based on paths.  The implementation I'd do here is to provide a facility
> for marking some of the path endpoints as suspend insensitive then on
> suspend leave those endpoints in their current state, force the other
> endpoints off temporarily and re-run the standard power checks.
> 
> One thing I'll need to have a bit of a think about is if we need to
> provide the ability to offer control to userspace for the suspend state
> of path endpoints separately to their runtime state; I suspect the
> answer is yes.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
