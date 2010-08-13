From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 10:13:19 -0700
Message-ID: <20100813171319.GL2511__15296.1963009604$1281719656$gmane$org@linux.vnet.ibm.com>
References: <20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100811004223.GH2379@linux.vnet.ibm.com>
	<AANLkTik7Po9OuKC-QBZ=E83J70sU_ewNi+nNWgcjjLXd@mail.gmail.com>
	<20100811221258.GI2516@linux.vnet.ibm.com>
	<AANLkTi=fJjM=uWeV+L66ajM9rhrL0t1OO-C7ThNRdbae@mail.gmail.com>
	<20100812161935.GC2524@linux.vnet.ibm.com>
	<AANLkTi=51cFa0t5ZYj2CMiauuW80ZWTrm1tQkn63Et0F@mail.gmail.com>
	<20100813151451.GC2511@linux.vnet.ibm.com>
	<AANLkTimGHYZ4ndznJY-vjBb164xMSiGMeoJs=9=baSFi@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimGHYZ4ndznJY-vjBb164xMSiGMeoJs=9=baSFi@mail.gmail.com>
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
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 13, 2010 at 06:28:27PM +0300, Felipe Contreras wrote:
> On Fri, Aug 13, 2010 at 6:14 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, Aug 12, 2010 at 08:52:22PM +0300, Felipe Contreras wrote:
> >> =A04) no, we can't say anything about what opportunistic suspend means=
 in practice
> >
> > Here I disagree. =A0The Android folks have used it for quite some time.
> > We might not be able to apply their experience directly to other softwa=
re
> > stacks, but we should nevertheless be able to learn quite a bit from it.
> =

> So when it comes to practice you are relying solely on what Android peopl=
e say.

So when it comes to practice with suspend blockers, only the Android
people have any experience, so theirs is the only experience with
suspend blockers that there is to rely on.  ;-)  ;-)  ;-)

> If it's true that it's easy to spot the "PM-driving applications",
> then it shouldn't be hard for a guy from the Android team to assemble
> a basic typical system (X.org, dbus, etc.) with suspend-blockers in a
> couple of days.

I am happy to let the Android guys determine the best use for their time.

							Thanx, Paul
