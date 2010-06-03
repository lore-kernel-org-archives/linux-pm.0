From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 23:02:59 +0200
Message-ID: <201006032302.59947.rjw__33827.5624708787$1275598976$gmane$org@sisk.pl>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<201006030003.49486.rjw@sisk.pl> <20100603031024.GA11311@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603031024.GA11311@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: 640e9920@gmail.com, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thursday 03 June 2010, mark gross wrote:
> On Thu, Jun 03, 2010 at 12:03:49AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday 02 June 2010, mark gross wrote:
> > > On Tue, Jun 01, 2010 at 08:50:02PM -0700, Arve Hj=F8nnev=E5g wrote:
> > > > On Tue, Jun 1, 2010 at 7:05 AM, mark gross <640e9920@gmail.com> wro=
te:
> > > > > On Tue, Jun 01, 2010 at 09:07:37AM +0200, Florian Mickler wrote:
> > > > ...
> > > > >> +static void update_target_val(int pm_qos_class, s32 val)
> > > > >> +{
> > > > >> +     s32 extreme_value;
> > > > >> +     s32 new_value;
> > > > >> +     extreme_value =3D atomic_read(&pm_qos_array[pm_qos_class]-=
>target_value);
> > > > >> +     new_value =3D pm_qos_array[pm_qos_class]->comparitor(val,e=
xtreme_value);
> > > > >> +     if (extreme_value !=3D new_value)
> > > > >> +             atomic_set(&pm_qos_array[pm_qos_class]->target_val=
ue,new_value);
> > > > >> +}
> > > > >> +
> > > > >
> > > > > Only works 1/2 the time, but I like the idea!
> > > > > It fails to get the righ answer when constraints are reduced.  Bu=
t, this
> > > > > idea is a good improvement i'll roll into the next pm_qos update!
> > > > >
> > > > =

> > > > I think it would be a better idea to track your constraints with a
> > > > sorted data structure. That way you can to better than O(n) for both
> > > > directions. If you have a lot of constraints with the same value, it
> > > > may even be worthwhile to have a two stage structure where for
> > > > instance you use a rbtree for the unique values and list for identi=
cal
> > > > constraints.
> > > =

> > > I don't agree, we went through this tree vrs list discussion a few ti=
mes
> > > before in other areas of the kernel.  Wherever the list tended to be
> > > short, a simple list wins.  However; we can try it, after we have some
> > > metrics and stress test cases identified we can measure its effective=
nes
> > > against.
> > =

> > How many different values are there to handle?
> >
> =

> for the current pm_qos users its tiny.  I've never heard of more than a
> few < 10.  However; for the new "interactive" class to provide suspend
> blocker functionality, I expect the number to be up to 20.
> =

> but realistically I bet we never get more than 10ish.
> =

> One constraint constraint request per module from isr to user mode.
> Once in user mode there would be only a few (assuming Android user
> space) I think just from the power HAL, input HAL, and the RIL.
> =

> Still a pretty small number I don't think we need to worry about scaling
> as much as we need to worry about performance.

In that case sorting the structure is rather not going to improve things, b=
ut
it might be worth using a hashtable or something similar.

Rafael
