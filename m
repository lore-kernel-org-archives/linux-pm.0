From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 17:17:27 +0200
Message-ID: <20100603171727.7d835a1d__3800.28249132938$1275578314$gmane$org@schatten.dmk.lab>
References: <AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<201005312338.55109.rjw@sisk.pl> <20100531232617.GF31155@gvim.org>
	<20100601090737.4bc243d9@schatten.dmk.lab>
	<20100601140519.GC1281@gvim.org>
	<AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6@mail.gmail.com>
	<20100602133910.GA9106@gvim.org>
	<AANLkTilSU79cnBODXFokzIPB1hRcZBxbwTgTQ59MeKcK@mail.gmail.com>
	<20100603031842.GB11311@gvim.org>
	<AANLkTiks7sQBbDnN6QrtGVqSXLob1qCs7VA12LZAWnfM@mail.gmail.com>
	<20100603054018.GE11311@gvim.org>
	<AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
	<1275575794.5914.74.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275575794.5914.74.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 03 Jun 2010 09:36:34 -0500
James Bottomley <James.Bottomley@suse.de> wrote:

> On Thu, 2010-06-03 at 00:10 -0700, Arve Hj=F8nnev=E5g wrote:
> > On Wed, Jun 2, 2010 at 10:40 PM, mark gross <640e9920@gmail.com> wrote:
> > > On Wed, Jun 02, 2010 at 09:54:15PM -0700, Brian Swetland wrote:
> > >> On Wed, Jun 2, 2010 at 8:18 PM, mark gross <640e9920@gmail.com> wrot=
e:
> > >> > On Wed, Jun 02, 2010 at 02:58:30PM -0700, Arve Hj=F8nnev=E5g wrote:
> > >> >>
> > >> >> The list is not short. You have all the inactive and active
> > >> >> constraints on the same list. If you change it to a two level list
> > >> >> though, the list of unique values (which is the list you have to =
walk)
> > >> >> may be short enough for a tree to be overkill.
> > >> >
> > >> > what have you seen in practice from the wake-lock stats?
> > >> >
> > >> > I'm having a hard time seeing where you could get more than just a
> > >> > handfull.  However; one could go to a dual list (like the schedule=
r) and
> > >> > move inactive nodes from an active to inactive list, or we could s=
imply
> > >> > remove them from the list uppon inactivity.  which would would well
> > >> > after I change the api to have the client allocate the memory for =
the
> > >> > nodes...  BUT, if your moving things in and out of a list a lot, I=
'm not
> > >> > sure the break even point where changing the structure helps.
> > >> >
> > >> > We'll need to try it.
> > >> >
> > >> > I think we will almost never see more than 10 list elements.
> > >> >
> > >> > --mgross
> > >> >
> > >> >
> > >>
> > >> I see about 80 (based on the batteryinfo dump) on my Nexus One
> > >> (QSD8250, Android Froyo):
> > >
> > > shucks.
> > >
> > > well I think for a pm_qos class that has boolean dynamic range we can
> > > get away with not walking the list on every request update.  we can u=
se
> > > a counter, and the list will be for mostly for stats.
> > >
> > =

> > Did you give any thought to my suggestion to only use one entry per
> > unique value on the first level list and then use secondary lists of
> > identical values. That way if you only have two constraints values the
> > list you have to walk when updating a request will never have more
> > than two entries regardless of how many total request you have.
> > =

> > A request update then becomes something like this:
> >   if on primary list {
> >     unlink from primary list
> >     if secondary list is not empty
> >       get next secondary entry and add in same spot on primary list
> >   }
> >   unlink from secondary list
> >   find new spot on primary list
> >   if already there
> >     add to secondary list
> >   else
> >     add to primary list
> =

> This is just reinventing hash bucketed lists.  To get the benefits, all
> we do is implement an N state constraint as backed by an N bucketed hash
> list, which the kernel already has all the internal mechanics for.
> =

> James
>

http://www.itl.nist.gov/div897/sqg/dads/HTML/priorityque.html

So no reinvention. Just using a common scheme. =


Cheers,
Flo
