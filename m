From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 20:18:42 -0700
Message-ID: <20100603031842.GB11311__10640.2436657392$1275535241$gmane$org@gvim.org>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<Pine.LNX.4.44L0.1005292026080.6300-100000@netrider.rowland.org>
	<AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<201005312338.55109.rjw@sisk.pl> <20100531232617.GF31155@gvim.org>
	<20100601090737.4bc243d9@schatten.dmk.lab>
	<20100601140519.GC1281@gvim.org>
	<AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6@mail.gmail.com>
	<20100602133910.GA9106@gvim.org>
	<AANLkTilSU79cnBODXFokzIPB1hRcZBxbwTgTQ59MeKcK@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilSU79cnBODXFokzIPB1hRcZBxbwTgTQ59MeKcK@mail.gmail.com>
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
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 02, 2010 at 02:58:30PM -0700, Arve Hj=F8nnev=E5g wrote:
> 2010/6/2 mark gross <640e9920@gmail.com>:
> > On Tue, Jun 01, 2010 at 08:50:02PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> On Tue, Jun 1, 2010 at 7:05 AM, mark gross <640e9920@gmail.com> wrote:
> >> > On Tue, Jun 01, 2010 at 09:07:37AM +0200, Florian Mickler wrote:
> >> ...
> >> >> +static void update_target_val(int pm_qos_class, s32 val)
> >> >> +{
> >> >> + =A0 =A0 s32 extreme_value;
> >> >> + =A0 =A0 s32 new_value;
> >> >> + =A0 =A0 extreme_value =3D atomic_read(&pm_qos_array[pm_qos_class]=
->target_value);
> >> >> + =A0 =A0 new_value =3D pm_qos_array[pm_qos_class]->comparitor(val,=
extreme_value);
> >> >> + =A0 =A0 if (extreme_value !=3D new_value)
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 atomic_set(&pm_qos_array[pm_qos_class]->t=
arget_value,new_value);
> >> >> +}
> >> >> +
> >> >
> >> > Only works 1/2 the time, but I like the idea!
> >> > It fails to get the righ answer when constraints are reduced. =A0But=
, this
> >> > idea is a good improvement i'll roll into the next pm_qos update!
> >> >
> >>
> >> I think it would be a better idea to track your constraints with a
> >> sorted data structure. That way you can to better than O(n) for both
> >> directions. If you have a lot of constraints with the same value, it
> >> may even be worthwhile to have a two stage structure where for
> >> instance you use a rbtree for the unique values and list for identical
> >> constraints.
> >
> > I don't agree, we went through this tree vrs list discussion a few times
> > before in other areas of the kernel. =A0Wherever the list tended to be
> > short, a simple list wins. =A0However; we can try it, after we have some
> > metrics and stress test cases identified we can measure its effectivenes
> > against.
> >
> =

> The list is not short. You have all the inactive and active
> constraints on the same list. If you change it to a two level list
> though, the list of unique values (which is the list you have to walk)
> may be short enough for a tree to be overkill.

what have you seen in practice from the wake-lock stats?

I'm having a hard time seeing where you could get more than just a
handfull.  However; one could go to a dual list (like the scheduler) and
move inactive nodes from an active to inactive list, or we could simply
remove them from the list uppon inactivity.  which would would well
after I change the api to have the client allocate the memory for the
nodes...  BUT, if your moving things in and out of a list a lot, I'm not
sure the break even point where changing the structure helps.

We'll need to try it.

I think we will almost never see more than 10 list elements.

--mgross
