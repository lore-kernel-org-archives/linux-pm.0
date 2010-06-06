From: mark gross <640e9920@gmail.com>
Subject: Re: PM_QOS re-design for hot path use of limited dynamic
 range requests was- Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sun, 6 Jun 2010 14:43:38 -0700
Message-ID: <20100606214338.GE8610__35366.8942502283$1275860664$gmane$org@gvim.org>
References: <AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<1275661390.4455.31.camel@mulgrave.site>
	<20100605040638.GB20419@gvim.org> <201006052107.32318.rjw@sisk.pl>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006052107.32318.rjw@sisk.pl>
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
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 05, 2010 at 09:07:32PM +0200, Rafael J. Wysocki wrote:
> On Saturday 05 June 2010, mark gross wrote:
> > On Fri, Jun 04, 2010 at 09:23:10AM -0500, James Bottomley wrote:
> > > On Thu, 2010-06-03 at 21:07 -0700, Arve Hj=F8nnev=E5g wrote:
> > > > On Thu, Jun 3, 2010 at 2:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
> > > > > On Thursday 03 June 2010, James Bottomley wrote:
> > > > >> On Thu, 2010-06-03 at 00:10 -0700, Arve Hj=F8nnev=E5g wrote:
> > > > >> > On Wed, Jun 2, 2010 at 10:40 PM, mark gross <640e9920@gmail.co=
m> wrote:
> > > > >> > > On Wed, Jun 02, 2010 at 09:54:15PM -0700, Brian Swetland wro=
te:
> > > > >> > >> On Wed, Jun 2, 2010 at 8:18 PM, mark gross <640e9920@gmail.=
com> wrote:
> > > > >> > >> > On Wed, Jun 02, 2010 at 02:58:30PM -0700, Arve Hj=F8nnev=
=E5g wrote:
> > > > >> > >> >>
> > > > >> > >> >> The list is not short. You have all the inactive and act=
ive
> > > > >> > >> >> constraints on the same list. If you change it to a two =
level list
> > > > >> > >> >> though, the list of unique values (which is the list you=
 have to walk)
> > > > >> > >> >> may be short enough for a tree to be overkill.
> > > > >> > >> >
> > > > >> > >> > what have you seen in practice from the wake-lock stats?
> > > > >> > >> >
> > > > >> > >> > I'm having a hard time seeing where you could get more th=
an just a
> > > > >> > >> > handfull.  However; one could go to a dual list (like the=
 scheduler) and
> > > > >> > >> > move inactive nodes from an active to inactive list, or w=
e could simply
> > > > >> > >> > remove them from the list uppon inactivity.  which would =
would well
> > > > >> > >> > after I change the api to have the client allocate the me=
mory for the
> > > > >> > >> > nodes...  BUT, if your moving things in and out of a list=
 a lot, I'm not
> > > > >> > >> > sure the break even point where changing the structure he=
lps.
> > > > >> > >> >
> > > > >> > >> > We'll need to try it.
> > > > >> > >> >
> > > > >> > >> > I think we will almost never see more than 10 list elemen=
ts.
> > > > >> > >> >
> > > > >> > >> > --mgross
> > > > >> > >> >
> > > > >> > >> >
> > > > >> > >>
> > > > >> > >> I see about 80 (based on the batteryinfo dump) on my Nexus =
One
> > > > >> > >> (QSD8250, Android Froyo):
> > > > >> > >
> > > > >> > > shucks.
> > > > >> > >
> > > > >> > > well I think for a pm_qos class that has boolean dynamic ran=
ge we can
> > > > >> > > get away with not walking the list on every request update. =
 we can use
> > > > >> > > a counter, and the list will be for mostly for stats.
> > > > >> > >
> > > > >> >
> > > > >> > Did you give any thought to my suggestion to only use one entr=
y per
> > > > >> > unique value on the first level list and then use secondary li=
sts of
> > > > >> > identical values. That way if you only have two constraints va=
lues the
> > > > >> > list you have to walk when updating a request will never have =
more
> > > > >> > than two entries regardless of how many total request you have.
> > > > >> >
> > > > >> > A request update then becomes something like this:
> > > > >> >   if on primary list {
> > > > >> >     unlink from primary list
> > > > >> >     if secondary list is not empty
> > > > >> >       get next secondary entry and add in same spot on primary=
 list
> > > > >> >   }
> > > > >> >   unlink from secondary list
> > > > >> >   find new spot on primary list
> > > > >> >   if already there
> > > > >> >     add to secondary list
> > > > >> >   else
> > > > >> >     add to primary list
> > > > >>
> > > > >> This is just reinventing hash bucketed lists.  To get the benefi=
ts, all
> > > > >> we do is implement an N state constraint as backed by an N bucke=
ted hash
> > > > >> list, which the kernel already has all the internal mechanics fo=
r.
> > > > >
> > > > > Agreed.
> > > > >
> > > > =

> > > > No, a hash is used for quick lookup of a specific value, not to find
> > > > an extreme value.
> > > =

> > > If you only have N possible values an N bucket hash list is rather
> > > efficient (provided N is small).  But I would agree that knowing what=
 N
> > > is represents an API change, and since plists can do this without
> > > changing the API, they're better.
> > > =

> > > >  It is however extremely similar to plists. The only
> > > > difference is that plists link all the secondary lists together.
> > > =

> > > Right, so they would solve the *current* problem exactly.
> > > =

> > > >  If we
> > > > want to have constraints that autoexpire, then keeping the secondary
> > > > lists separate allows the same optimization as I did for
> > > > wakelock/suspend_blocker timeouts where no timer is active if an
> > > > (equal or stricter) non-expiring constraint is active.
> > > =

> > > But this is a future discussion and not part of the patch.  The way o=
pen
> > > source works is that we sort out the best implementation for the curr=
ent
> > > conditions.  If the implementation has to change because of future
> > > stuff, then we change it when the future stuff comes along.  Changing
> > > implementations is easy (they don't have any externally visible impac=
t).
> > > Changing the in-kernel API is slightly harder, but easily doable.  It=
's
> > > only changing the user visible ABI that we worry about and try not to
> > > do.
> > >
> > =

> > True.
> > =

> > The following is what I think I'll work on this weekend.  (hopefully
> > have some sort of patch that at least compiles...)
> > =

> > =

> > Changes to pm_qos to enable "wakelock" or "suspend blocker" support:
> > =

> > Requirements:
> > 1) atomic context support.
> > 2) make updating request fast enough for hot path users.
> > 3) Add a request class for "interactive_suspend", this particular
> > request has a dynamic range of 1 (its 0 or 1).  If zero then ok to auto
> > suspend, if 1 then only user driven suspend.  Whenever the aggregate
> > request changes value the registered notifiers are called.
> > =

> > =

> > Implementation:
> > * change api to have caller allocated the qos request structures. (solve
> > the kalloc issue)
> > * add plist use for constraint classes with hash-able dynamic ranges
> =

> Please have a look at the patch James posted earlier today on linux-pm,
> you were CCed.
>

I like James' post.  I'm sorry I missed it before I sent this note, but
I'm really glad he's posted it.  Now I can do some testing.

--mgross

 =
