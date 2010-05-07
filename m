From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Fri, 7 May 2010 13:25:20 +0100
Message-ID: <20100507122520.GD21498__7592.76389512724$1273235182$gmane$org@rakim.wolfsonmicro.main>
References: <20100505185225.GA4411@srcf.ucam.org>
	<Pine.LNX.4.44L0.1005051511040.1885-100000@iolanthe.rowland.org>
	<m2oa55d774e1005051356n3610d780ra42200c1785e02bd@mail.gmail.com>
	<20100505234025.GB4838@opensource.wolfsonmicro.com>
	<l2kd6200be21005052125rc43217a2r8c65bc98e7a5d3d4@mail.gmail.com>
	<20100507100406.GA21498@rakim.wolfsonmicro.main>
	<w2kd6200be21005070357r9aad2896l355168a23bf85eae@mail.gmail.com>
	<20100507112102.GC21498@rakim.wolfsonmicro.main>
	<81818215-44A2-4B74-A43F-E2644C950F5C@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <81818215-44A2-4B74-A43F-E2644C950F5C@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Tso <tytso@MIT.EDU>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, rebecca@android.com, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 07, 2010 at 07:29:47AM -0400, Theodore Tso wrote:

> This sounds like it may be something unique to your board/product.  Or
> am I missing something?

I suspect you're missing something here - I'm approaching this as one of
the maintainers of the embedded audio subsystem for the kernel.  I need
to worry about any system running Linux which has an embedded style
audio subsystem.  The problem might be unique to audio, but I can't say
that for certain.

> One of the challenges with PM in the embedded world is that everybody
> seems to have slightly different assumptions, and hardware that doesn't
> behave the same way.

This isn't really a problem for audio - we've already got a subsystem
which copes well with pretty much all systems and does runtime PM that's
equivalent to suspending already, which is half the problem here.  If we
had less generalisation this would probably not have come up.

> More than once this discussion has wandered off into the weeds wrt to
> whether this patch series is ready to be merged, since there are so many
> drivers blocked on it....

Once more, my main objective here has been to make sure that when this
is merged we've got a joined up story about how people think this hangs
together, which I think we have now.  As I say now that we have that
understanding I don't see any reason to block merge.

It's unfortunate that I only noticed that this was actually wakelocks
very late in the day but I think I can get an implementation which
handles paths that ignore suspends done quickly.
