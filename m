From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 17:55:23 -0700
Message-ID: <200607261755.25808.david-b@pacbell.net>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
	<200607241149.01700.david-b@pacbell.net>
	<083b1ba275390c298727816bc51f21b4@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <083b1ba275390c298727816bc51f21b4@nomadgs.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: patrick.mochel@intel.com, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 July 2006 12:44 am, Matthew Locke wrote:
> =

> On Jul 24, 2006, at 11:48 AM, David Brownell wrote:
> =

> > So I was glad to see it split out as fully optional... although from =

> > what I
> > see, the internal models in the code have derived from this sysfs =

> > model, so
> > I'd argue those need to change too.
> =

> Is there something specific in the internal model that are you =

> referring to?

I touched on some of the issues in earlier emails to Eugeny.

One is that the struct declaration seems too monolithic to
handle board-specific differences well.  Related to that is the
way things are just packaged as a set/struct of numbers, rather
than a set of objects/components with internal rules/models
(which might be individually reusable, e.g. "SOC X").

Maybe another way to think of it is that this sysfs stuff defines
some structural notions that seem to be artifacts of one style
for creating operating points ... and I'd be more comfortable
deriving those structural notions by addressing requirements of
specific board families (not just SOCs!).  And _then_ coming up
with a sysfs model to suit.


> > It'd be lots better to just have named operating points that get =

> > selected just
> > the /sys/power/state file selects the, erm, "sleep point".
> =

> I've tried to fit sleep into the operating point concept before but =

> sleep always ends up being a special case.   The code has to check to =

> see if the selected operating the "sleep point" and call the suspend =

> function.  I think tying in sleep to the op point concept needs more =

> discussion and probably should be handled separately until we get =

> further along with power op.

I'm comfortable with discussing sleep point separately from operating
points, so long as everyone understands how fuzzy a line that is.  In
a system with dedicated asymmetric CPUs for example, is "this cpu is
asleep and that one is running" a sleep state?  Or an operating point?
Ditto with hardware components that may be running or not, and don't
get to brag about some fancy instruction set.  :)

In fact, I find it maybe easier to think of "run states" and "sleep
states", where a "run state" would include a collection of specific
operating points and some mechanism to select some operating point
to activate.  I don't think that notion of "operating point" is what
you are talking about here with PowerOP, though...


> btw, we are in complete agreement about using named points.  This first =

> set of patches is meant to introduce the operating point concept into =

> the kernel without requiring massive changes to cpufreq.  This layer =

> extends the bottom part of cpufreq to enable the control of multiple =

> parameters beyond just cpu frequency and voltage across architectures.

I guess I haven't read the patches enough to see how it extends that.


> Currently, cpufreq does not use named operating points so we need to =

> make sure cpufreq can use the power op API and continue to function.  =

> This topic also ties into our other email discussion on creating op =

> points and names are assigned to op points.

Hmm, I'll be watching to see how that works out.  I keep thinking that
in the big picture, a "governor" type component may not map well to
choosing operating points ... though a given component might well use
such a mechanism internally.

- Dave
