From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 5 May 2010 00:56:44 +0100
Message-ID: <20100504235644.GA5231__28467.9999146194$1273017541$gmane$org@opensource.wolfsonmicro.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<20100504135907.GA3651@opensource.wolfsonmicro.com>
	<87r5lrh780.fsf@deeprootsystems.com>
	<201005042223.41370.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005042223.41370.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Paul Walmsley <paul@pwsan.com>, Geoff Smith <geoffx.smith@intel.com>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 04, 2010 at 10:23:41PM +0200, Rafael J. Wysocki wrote:
> On Tuesday 04 May 2010, Kevin Hilman wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> Guys, please.

> The opportunistic suspend feature is _not_ to replace runtime PM by any means!

Certainly in my case and I think Kevin's I agree with the need for the
bodge at the minute if we can get a clearer idea of how it's supposed to
work.

> when to put devices into low power states and save energy this way.  Still,
> even if all subsystems do that 100% efficiently, there may be more savings
> possible by putting the entire system into a sleep state (like on ACPI-based
> PCs) and we can reach there by runtime PM alone.

Right, this is likely to be a win for PCs - for embedded systems we
rarely have other software to interoperate with so if you can make the
hardware do it then it's unlikely there would be any fundamental issue
with Linux doing it at runtime.

> > > I'd be a lot more comfortable with this if it came with a mechanism for
> > > communicating the intended effect of a suspend on a per-device level so
> > > that the drivers have a clear way of figuring out what to do when the
> > > system suspends.  If there isn't one we can add subsystem or driver
> > > specific hooks, of course, but it'd be better to address this at the
> > > system level.

> > I agree.

> I'm not sure.  Why _exactly_ would you need that?

The use case that causes serious issues with this at the minute in the
domains I work is this:

On a mobile phone when the system is in a voice call the data flow for
the call is entirely handled outside the CPU (normally referred to as
Applications Processor or AP here) by the baseband and audio CODEC,
which are either integrated or directly connected by analogue or digital
audio links on the board.  If the user has the phone to their ear and is
talking away with the screen blanked then the AP is just waiting for
input, will appear idle and so trigger an opportunistic suspend.  If the
audio CODEC is managed by Linux (as is standard) then running through
the suspend process will as things stand cause the audio subsystem to be
suspended.  Since in the normal course of affairs suspend means power
down that's what will happen, but this is clearly highly undesirable in
this situation.

Now, the solution here if we're going to use opportunistic suspend like
this is to provide some method for the audio subsystem to figure out
that the system doesn't actually want it to suspend when it gets told do
do so.  Like I say ideally we'd provide some standard interface in the
PM subsystem for userspace to communicate this to subsystems and drivers
so that we've got a joined up story when people run into issues in cases
like this, though obviously if this goes in then we'll have to put in
something subsystem or driver specific for affected areas.  I know what
I'd implement generically for audio, but I've held back since the option
is fairly messy when not used in conjunction with a deliberate choice to
use opportunistic suspend and I was expecting a standard mechanism to
slot into to provide control for userspace.

In other words, the issue is that we run into situations where we need
an element of suspend control to go along with the opportunistic suspend
in order to allow some elements to be kept running - since suspend
blocking is taken suspend suppression seems like a reasonable term.
