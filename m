From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 01:26:16 +0100
Message-ID: <200902090126.17899.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090040.22364.rjw@sisk.pl>
	<d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sun, Feb 8, 2009 at 3:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday 08 February 2009, Brian Swetland wrote:
> >> Out of curiosity, do these changes provide a model where the system can
> >> be in suspend 99+% of the time, waking up for specific events
> >> (voice/data telephony, user interaction, etc), and rapidly returning to
> >> suspend when the processing required is complete?
> >
> > The changes I was referring to above were rather related to the "normal"
> > suspend (ie. the one happening as a result of writing "mem" into
> > /sys/power/state).  Namely, we believe that for some devices it is not
> > necessary or even desirable to allow the driver to perform all of the p=
ower
> > management operations by itself.  For example, we are going to make the=
 PCI
> > PM core (which in fact is the PCI bus type driver) handle the saving and
> > restoration of PCI devices' configuration registers as well as putting =
the
> > devices into low power states and back into the full power state.  We c=
an do
> > that, because in the "normal" suspend code path the suspend routines of=
 a
> > driver are executed by the appropriate bus type's suspend routines and =
not
> > directly by the PM core.  The "early suspend" mechanism seems to go rou=
nd this
> > by calling directly into device drivers.
> =

> How do you handle devices that should be in a low power mode when
> closed, and a high(er) power mode when open. While adding
> early-suspend hooks to a driver may be ugly, it does not need any more
> support than open and close does.

I don't really see how the early-suspend helps here.  Can you please explai=
n?

> > Also, please observe that if there is a mechanism allowing us to put in=
dividual
> > devices, or entire subsystems (such as a bus with devices attached to i=
t), into
> > low power states at run time, without placing the entire system in a sl=
eep
> > state, and put them back into the full power state as needed, we won't =
need
> > anything like the "early suspend" introduced by this series of patches.
> =

> While early-suspend is not needed, it is still convenient on an
> embedded device where some drivers are clearly only used when the
> screen is on.

Ah, that's interesting.  So in fact you want some devices to go into low po=
wer
states as soon as the screen is off and that's why you fint the early-suspe=
nd
useful.  Is this correct?

> > As far as the wakelocks are concerned, the goal they are designed to ac=
hieve is
> > quite simple: you want to prevent suspend from happening in certain sit=
uations.
> > In principle, one flag is sufficient for that.  Still, there are many c=
ode
> > paths that might set and unset this flag and it would have been bad if =
the flag
> > had been set by one code path and then immediately unset by another one.
> > To prevent this from happening one can use a reference count with the r=
ule that
> > suspend can only happen if it is equal to zero.
> =

> We also want accountability.

You can still have it, to some extent, by implementing the routines for get=
ting
and releasing the reference appropriately.

Still, I'm very much interested in your reply to the last paragraph of my
message, the one that you removed.

Thanks,
Rafael
