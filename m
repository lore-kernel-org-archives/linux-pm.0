From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Thu, 12 Aug 2010 10:43:03 -0700
Message-ID: <20100812174303.GD2524__22373.7367931337$1281635056$gmane$org@linux.vnet.ibm.com>
References: <20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
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
Cc: david@lang.hm, Theodore Tso <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 02:11:22PM +0300, Felipe Contreras wrote:
> On Thu, Aug 12, 2010 at 1:47 PM, Theodore Tso <tytso@mit.edu> wrote:
> > One thing I'm not clear on --- what's your goal? =A0 Is your goal to ke=
ep suspend-blockers out of the kernel? =A0 Is it to try to convince the and=
roid team suspend-blockers are a bad idea and to change Android to not use =
them? =A0Is it to push some other agenda? =A0Is it to discourage the Androi=
d team from trying to waste more time trying to get suspend-blockers (or eq=
uivalent functionality) from being added into the kernel?
> =

> My goal is to shine light. I've heard many invalid arguments in favor
> of suspend blockers, I want to shut them down.
> =

> In my mind it's crystal clear that independently of what opportunistic
> suspend is supposed to be fixing, the fact of the matter is that it's
> not a silver bullet as it's claimed to be.

The question is not whether suspend blockers are a silver bullet (in my
opinion there are no silver bullets), but rather whether or not suspend
blockers are useful.

> So far, nobody has refuted these:
>  1) opportunistic suspend needs a good behaved user-space to work properly

As does dynamic power management.

>  2) if suspend blockers are enabled in a system, *all* user-space must
> implement them to work correctly

Really?  From what I can see, only PM-driving applications need to use
suspend blockers.

>  3) implementing suspend blockers in user-space is not a straight-forward=
 task

Fortunately, experience thus far has shown that only a small fraction of
applications need to use suspend blockers.  (Or perhaps you are instead
saying that the implementation of the suspend-blocker infrastructure
itself is not straightforward?  It is not clear from your words.)

>  4) there's a point where sleeping (not doing work) has diminished returns

This one I agree with.

> So, as the length of this thread has shown, the benefits of
> opportunistic suspend are *dubious* at best, and more likely not worth
> the changes needed in user-space which eventually will get pretty
> close to what suspend blockers can achieve even in ideal circumstances
> by just doing dynamic PM.

The length of this thread (and the ones preceding it) is mostly due to
people talking past each other.  For example, the Android folks seem to
believe that it is important that relatively unskilled people be able
to write simple apps, and that the system nevertheless be able to run
these apps in a relatively energy efficient manner.  Your proposals do
not address this issue.  This might be because you are not aware of
this desire, because you are not aware of the computing history that
argues in favor of this requirement, or because you simply don't like
this requirement.  Whatever the reason, until you face this requirement
head on, either addressing it or proving that it need not be addressed,
you will continue to be talking past the Android folks.

							Thanx, Paul
