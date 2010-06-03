From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 20:10:24 -0700
Message-ID: <20100603031024.GA11311__11721.3935860947$1275534721$gmane$org@gvim.org>
References: <AANLkTik_4ezDAQoAQjkpEgwD9SLKeOjDzy2H7T2v6uCP@mail.gmail.com>
	<AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6@mail.gmail.com>
	<20100602133910.GA9106@gvim.org> <201006030003.49486.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006030003.49486.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 03, 2010 at 12:03:49AM +0200, Rafael J. Wysocki wrote:
> On Wednesday 02 June 2010, mark gross wrote:
> > On Tue, Jun 01, 2010 at 08:50:02PM -0700, Arve Hj=F8nnev=E5g wrote:
> > > On Tue, Jun 1, 2010 at 7:05 AM, mark gross <640e9920@gmail.com> wrote:
> > > > On Tue, Jun 01, 2010 at 09:07:37AM +0200, Florian Mickler wrote:
> > > ...
> > > >> +static void update_target_val(int pm_qos_class, s32 val)
> > > >> +{
> > > >> +     s32 extreme_value;
> > > >> +     s32 new_value;
> > > >> +     extreme_value =3D atomic_read(&pm_qos_array[pm_qos_class]->t=
arget_value);
> > > >> +     new_value =3D pm_qos_array[pm_qos_class]->comparitor(val,ext=
reme_value);
> > > >> +     if (extreme_value !=3D new_value)
> > > >> +             atomic_set(&pm_qos_array[pm_qos_class]->target_value=
,new_value);
> > > >> +}
> > > >> +
> > > >
> > > > Only works 1/2 the time, but I like the idea!
> > > > It fails to get the righ answer when constraints are reduced.  But,=
 this
> > > > idea is a good improvement i'll roll into the next pm_qos update!
> > > >
> > > =

> > > I think it would be a better idea to track your constraints with a
> > > sorted data structure. That way you can to better than O(n) for both
> > > directions. If you have a lot of constraints with the same value, it
> > > may even be worthwhile to have a two stage structure where for
> > > instance you use a rbtree for the unique values and list for identical
> > > constraints.
> > =

> > I don't agree, we went through this tree vrs list discussion a few times
> > before in other areas of the kernel.  Wherever the list tended to be
> > short, a simple list wins.  However; we can try it, after we have some
> > metrics and stress test cases identified we can measure its effectivenes
> > against.
> =

> How many different values are there to handle?
>

for the current pm_qos users its tiny.  I've never heard of more than a
few < 10.  However; for the new "interactive" class to provide suspend
blocker functionality, I expect the number to be up to 20.

but realistically I bet we never get more than 10ish.

One constraint constraint request per module from isr to user mode.
Once in user mode there would be only a few (assuming Android user
space) I think just from the power HAL, input HAL, and the RIL.

Still a pretty small number I don't think we need to worry about scaling
as much as we need to worry about performance.

--mgross =
