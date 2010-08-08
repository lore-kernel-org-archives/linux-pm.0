From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sun, 8 Aug 2010 11:07:49 -0700
Message-ID: <20100808180749.GG19600__973.851551725779$1281292910$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100804195704.GA23681@linux.vnet.ibm.com>
	<20100806225453.GA3947@linux.vnet.ibm.com>
	<AANLkTik3qF2yScLJiDBWLN5=Ez0FsvbOo0M76WbOAGvO@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik3qF2yScLJiDBWLN5=Ez0FsvbOo0M76WbOAGvO@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: david@lang.hm, tytso@mit.edu, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 08, 2010 at 03:40:28PM +0300, Felipe Contreras wrote:
> On Sat, Aug 7, 2010 at 1:54 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > o =A0 =A0 =A0 "Ill-behaved application" AKA "untrusted application" AKA
> > =A0 =A0 =A0 =A0"crappy application".
> =

> > o =A0 =A0 =A0 "PM-driving application" are applications that are permit=
ted
> > =A0 =A0 =A0 =A0to acquire suspend blockers on Android.
> =

> These definitions are wrong.

Indeed they are, given the way you quoted small portions of them.  ;-)

> 1) There are trusted applications that misbehave (the user clicks Yes
> when asked about PM permissions)

These would be buggy PM-driving applications.  Of course, any type of
application might have bugs, including PM-driving applications.

> 2) There are untrusted applications that are power optimized (The user
> clicks No)

I did indeed exclude this category by saying "power-optimized applications
are those PM-driving applications that have been aggressively tuned
to reduce power consumption."  The reason I excluded this case is that
that there are a number of cases where removing the PM-driving attribute
could destroy the power optimization.

If you have an example power-optimized application that retains its
power-optimized property despite lacking PM-driving privileges, please
put it forward.  In doing so, please keep two things in mind:

1.	The definition of power-optimized is more aggressive than many
	people are used to -- look at http://lkml.org/lkml/2010/8/4/409
	and search for "POWER-OPTIMIZED APPLICATIONS".

2.	In a number of the implementations that do not use suspend blockers,
	-all- applications are in effect PM-driving applications.
	So it is quite possible that different people are using subtly
	different flavors of the "PM-driving applications" definition.

	For example, an Android person might consider a application to
	be PM-driving only if it is permitted to use suspend blockers,
	while a Maemo person might consider an application to be
	PM-driving if it had permission to invoke pm_qos functions.
	If these two hypothetical people each try to apply their
	definition of PM-driving to each others' platforms, they will
	likely have severe problems communicating with each other,
	right?  ;-)

But if you do have a good example, perhaps I will need to change my
definition of power-optimized application.

> The proponents of suspend blockers in user-space have tried to ignore
> this fact, but the truth is that PM permissions and power optimization
> are orthogonal to each other.

In fact, you might have noticed that the proponents of each platform
have been quite persistent in shouting past each other from the warmth
and security of their own particular viewpoints.  ;-)

							Thanx, Paul
