From: Mark Gross <mgross@linux.intel.com>
Subject: Re: OLS 2006 PM-BOF notes
Date: Fri, 11 Aug 2006 16:20:13 -0700
Message-ID: <20060811232013.GA6930@linux.intel.com>
References: <200608111914.k7BJEJ0Q029765@olwen.urbana.css.mot.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200608111914.k7BJEJ0Q029765@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 11, 2006 at 02:14:19PM -0500, Scott E. Preece wrote:
> =

> =

> | From: Mark Gross<mgross@linux.intel.com>
> | =

> | OLS 2006 PM BOF notes
> | =

> | I'm sorry for taking so long to get these out, I misplaced my notes suc=
h as
> | there are.  The discussions where fragmented and hard to keep up with.  =

> | ...
> | Device / driver Policy manager for application based PM:
> | =

> | Can drivers be put into lower power states based on application hints, =
such as
> | I'm doing DVD play back and don't need HD, Ethernet, USB, BT so shut th=
ose down
> | for now.
> ---
> =

> Problem, of course, is that in general-use kind of environment, one
> application doesn't know what another is doing. So, an app could say "I
> need X, Y, Z" or "I don't need X, Y, Z", but something needs to track
> the requirements across the system as a whole. And, then, you either
> have to trust the applications (which seems unworkable, as long as the
> software set can be changed on a deployed system) or else you have to
> have a backup approach that controls things by watching the system. And,
> if you have that, do you really need the app hints, too?

point

> =

> Now, a narrow consumer device with non-replaceable software might be
> able to get away with just voluntary controls, but (a) the FLOSS
> community is getting sensitive about whether non-replaceable software is
> permissible and (b) a lot of consumer devices are skewing more towards
> general use, anyway, so being able to count on cooperative apps is
> probably unrealistic.
> =

> Look at the narrow case of CPU demand; most apps (other than simple
> filter-style apps) have multiple execution regimes while they're
> running - the DVD player doesn't need a lit of CPU while it's waiting for
> you to press PLAY. So coders would have to remember to change hints as
> they changed modes, which seems like a stretch. And you need a means of
> expressing your hints in a way that doesn't depend on knowledge of the
> platform, or else the developer needs to test on every supported
> platform and calculate requirements for that hardware.

Now that we have dynaticks coming with HRT in the next few kernels we
have part of the problme solved.  The next step is to enable better
resource need predition at the system level based on both responivenes
and throughput needs to round out the PM story.

If we could know that we need Xmsec responce in UI events, and we have
Ysec of playback buffer in the audio hardware, and we have similar data
from key IO devices that know about latencies and throughput collected
somewhere that a policy manager could do a good job of knowing what
lower power states can be attempted and by what devices, that would help
a lot.

> =

> The MontaVista/IBM white paper on DPM talked about seeing gains just
> from stopping during the inter-frame breaks in video decoding. If you've
> got dynamic ticks, and the app is tied to a timer to restart its
> activity for the next frame, you can probably do as well by just letting
> the scheduler drive that as by asking the app to carefully indicate when
> it's not going to need processing.

What is needed is a way for media applications to set a deadline based
on how large the playback buffer is, fill it, yeald and then if the
system is otherwise idle, drop into a deep C state (x86) or high latency
sleep (ARM) as a function of how much time is left before the buffer is
drained out.

For this to work you need the system to know how long before it needs to
ramp back up and schedule it to do so.

It would be good to consider how this type of latency and CPU wake up
from deep idle scheduling could look in Linux.

--mgross =
