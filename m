From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 18:09:12 -0700
Message-ID: <20100804010912.GK2407__21896.4524487548$1280884298$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<AANLkTi=hoGF7egpyB9sLKJoXv5aiGrxfa9_5iH-96SA=@mail.gmail.com>
	<20100803154112.GE2407@linux.vnet.ibm.com>
	<AANLkTim474Yp=MP3EX9pabc9XO8Q-McCns207SLPYuUb@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim474Yp=MP3EX9pabc9XO8Q-McCns207SLPYuUb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 03, 2010 at 03:23:00PM -0700, Arve Hj=F8nnev=E5g wrote:
> 2010/8/3 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> > On Mon, Aug 02, 2010 at 09:18:27PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> On Sat, Jul 31, 2010 at 10:58 AM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> ...
> >> > o =A0 =A0 =A0 Statistics of the power-control actions taken by power=
-aware
> >> > =A0 =A0 =A0 =A0applications must be provided, and must be keyed off =
of program
> >> > =A0 =A0 =A0 =A0name.
> >>
> >> We don't key the stats off the program name, but having useful
> >> statistics is critical too us. The current code in linux-next does not
> >> appear to allow this (I'm referring to pm_stay_awake here, etc not
> >> pm-qos.)
> >
> > OK, maybe I was confused earlier. =A0So you do not track statistics via
> > the device being open throughout the application's lifetime?
> =

> The suspend blocker patchset does track statistics while the device is
> open, but it it not keyed of the program name. The name is passed from
> user-space and a single process can have the device open several
> times. The wakelock interface that we currently use just creates a new
> object every time it sees a new name and never frees it.

Ah, good to know!

							Thanx, Paul

> ...
> >> > o =A0 =A0 =A0 If no power-aware or power-optimized application are i=
ndicating
> >> > =A0 =A0 =A0 =A0a need for the system to remain operating, the system=
 is permitted
> >> > =A0 =A0 =A0 =A0(even encouraged!) to suspend all execution, even if =
power-naive
> >> > =A0 =A0 =A0 =A0applications are runnable. =A0(This requirement did a=
ppear to be
> >> > =A0 =A0 =A0 =A0somewhat controversial.)
> >>
> >> I would say it should suspend even if power aware applications are
> >> runnable. Most applications do not exclusively perform critical work.
> >
> > The point being that a power-aware application does not block suspend
> > -unless- it holds a suspend blocker, correct?
> =

> Yes.
> =

> >
> > Or am I missing some other subtlety?
> =

> No.
> =

> ...
> >> > o =A0 =A0 =A0 Any initialization of the API that controls the system=
 power
> >> > =A0 =A0 =A0 =A0state must be unconditional, so as to be free from fa=
ilure.
> >> > =A0 =A0 =A0 =A0(I don't currently understand how this relates, proba=
bly due to
> >> > =A0 =A0 =A0 =A0my current insufficient understanding of the proposed=
 patch set.)
> >>
> >> Unconditional initialization makes it easier to add suspend blockers
> >> to existing kernel code since you don't have to add new failure exit
> >> paths. It is not a strong requirement.
> >
> > Ah, that makes more sense! =A0I moved this to a new "NICE-TO-HAVES"
> > section. =A0I also changed the last parenthesized sentence to read
> > "Such unconditional initialization reduces the intrusiveness of the
> > the Android patchset." =A0Does that work?
> >
> =

> Sure.
> =

> =

> =

> -- =

> Arve Hj=F8nnev=E5g
