From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 08:22:54 -0700
Message-ID: <20100813152254.GD2511__16712.3607163832$1281713029$gmane$org@linux.vnet.ibm.com>
References: <20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
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

On Thu, Aug 12, 2010 at 10:34:47PM +0300, Felipe Contreras wrote:
> On Thu, Aug 12, 2010 at 8:43 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, Aug 12, 2010 at 02:11:22PM +0300, Felipe Contreras wrote:
> >> So far, nobody has refuted these:
> >> =A01) opportunistic suspend needs a good behaved user-space to work pr=
operly
> >
> > As does dynamic power management.
> =

> Thus remains unrefuted.

Glad we agree that both dynamic power management and opportunistic
power management need applications to be written carefully.  Of course,
dynamic power management requires all of the code in those applications
to be carefully written, while experience indicates that opportunistic
suspend requires only a small fraction to be carefully written.

> >> =A02) if suspend blockers are enabled in a system, *all* user-space mu=
st
> >> implement them to work correctly
> >
> > Really? =A0From what I can see, only PM-driving applications need to use
> > suspend blockers.
> =

> "PM-driving applications" is a new invention, so how do you know if an
> application belongs to this category or not? Some application might be
> non-PM-driving most of the time, but suddenly become PM-driving. Well,
> you have to analyze *all* of them.

A PM-driving application is one that exerts control over the system's
power state.  In the case of Android, a PM-driving application is one
that is permitted to acquire suspend blockers.

> Think about this... is bash a PM driving application? No, but what if
> you run: 'sleep 3600 && alarm.sh'.

That is an excellent example, as it applies equally to dynamic power
management.  By how much are you allowed to delay the wakeup?

> Perhaps I should rewrite that as:
> 2) if suspend blockers are enabled in the system; *all* user-space is aff=
ected

That is speculation on your part.

> >> =A03) implementing suspend blockers in user-space is not a straight-fo=
rward task
> >
> > Fortunately, experience thus far has shown that only a small fraction of
> > applications need to use suspend blockers.
> =

> Wrong. We don't have any experience on that at all on typical linux
> ecosystems (remember that Android's user-space is very special).

Android's experience might not apply exactly to typical Linux ecosystems,
but we really can learn quite a bit from it -- at least if we can bring
ourselves to do so.

> >> So, as the length of this thread has shown, the benefits of
> >> opportunistic suspend are *dubious* at best, and more likely not worth
> >> the changes needed in user-space which eventually will get pretty
> >> close to what suspend blockers can achieve even in ideal circumstances
> >> by just doing dynamic PM.
> >
> > The length of this thread (and the ones preceding it) is mostly due to
> > people talking past each other.
> =

> Perhaps half of the thread, or even one quarter of the thread can be
> attributed to that, but still the rest I think it's because people
> keep pushing in, and people keep pushing out.

Fair enough.  I wasn't differentiating between people mistakenly talking
past each other and intentionally talking past each other, but if you
want to differentiate, feel free to do so.

> > For example, the Android folks seem to
> > believe that it is important that relatively unskilled people be able
> > to write simple apps, and that the system nevertheless be able to run
> > these apps in a relatively energy efficient manner. =A0Your proposals do
> > not address this issue. =A0This might be because you are not aware of
> > this desire, because you are not aware of the computing history that
> > argues in favor of this requirement, or because you simply don't like
> > this requirement. =A0Whatever the reason, until you face this requireme=
nt
> > head on, either addressing it or proving that it need not be addressed,
> > you will continue to be talking past the Android folks.
> =

> This "requirement" is specific to Android's user-space, isn't it?

That is your speculation.

> Not Ubuntu, not Fedora, not MeeGo, not anyone with a typical
> user-space seems to be having this problem. I can argue to you that
> this problem can be solved in easier ways, but instead I will argue
> that perhaps we should wait for somebody besides Android to complain
> about it before providing a "solution". Because after all, what good
> is a "solution" provided by the kernel, if the user-space is not going
> to use it, ever.

At this point in the discussion, I am quite prepared to believe that you
will avoid using suspend blockers, and that you will further do everything
in your power to prevent anyone else from using suspend blockers.  ;-)

							Thanx, Paul
