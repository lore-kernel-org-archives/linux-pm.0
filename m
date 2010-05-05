From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 22:44:03 +0200
Message-ID: <201005052244.03225.rjw__6431.71075867048$1273095537$gmane$org@sisk.pl>
References: <20100505185225.GA4411@srcf.ucam.org>
	<20100505195534.GD18762@thunk.org>
	<20100505202637.GH7139@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505202637.GH7139@rakim.wolfsonmicro.main>
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
Cc: Paul Walmsley <paul@pwsan.com>, tytso@mit.edu, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 May 2010, Mark Brown wrote:
> On Wed, May 05, 2010 at 03:55:34PM -0400, tytso@mit.edu wrote:
> 
> > I confess I've completely lost track of (a) what problem you are
> > trying to solve, and (b) how this might relate to some change that
> > you'd like to see in the suspend block API.  Could you do a quick
> > summary and recap?  I've gone over the entire thread, and it's still
> > not clear what change you're advocating for in suspend blockers.
> 
> The issue isn't suspend blockers, it's the opportunistic suspend stuff
> that goes along with them.  When that is in use the system suspends
> vastly more aggressively, including in situations where a runtime PM
> based approach like mainline had been adopting would not suspend since
> some devices still need to be active, the classic case being keeping the
> audio subsystem and baseband live when in a phone call.  This problem
> did not appear to have been considered as things stood.  
> 
> I'm not really advocating a change in what's there.  What I'm looking
> for is some sort of agreement as to how subsystems and drivers that need
> to not act on suspend requests from the core in these situations should
> do that.  If there is a generic solution it'd probably be an additional
> mostly orthogonal interface rather than a change to what's being
> proposed here.
> 
> What we look like we're converging on is a subsystem/driver local
> solution since it doesn't look like a terribly widespread problem.
> That's totally OK, it's just that as I have said I don't want to go off
> and do that without the general PM community being aware of it so we
> avoid anyone running into nasty surprises further down the line.

To me, the above may be summarized that in your opinion some components of
the system will generally need to stay powered when it's suspended
opportunistically, so we need an interface to specify which components they are.
Is that correct?

Rafael
