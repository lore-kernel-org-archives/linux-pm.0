From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 06:24:49 -0700
Message-ID: <20100603132449.GA15595__5351.97231588445$1275571561$gmane$org@gvim.org>
References: <20100531232617.GF31155@gvim.org>
	<20100601090737.4bc243d9@schatten.dmk.lab>
	<20100601140519.GC1281@gvim.org>
	<AANLkTikF-B23_UWG1O3tlBl4m8NStAJllGhhevNhYZT6@mail.gmail.com>
	<20100602133910.GA9106@gvim.org>
	<AANLkTilSU79cnBODXFokzIPB1hRcZBxbwTgTQ59MeKcK@mail.gmail.com>
	<20100603031842.GB11311@gvim.org>
	<AANLkTiks7sQBbDnN6QrtGVqSXLob1qCs7VA12LZAWnfM@mail.gmail.com>
	<20100603054018.GE11311@gvim.org>
	<AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
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

On Thu, Jun 03, 2010 at 12:10:03AM -0700, Arve Hj=F8nnev=E5g wrote:
> On Wed, Jun 2, 2010 at 10:40 PM, mark gross <640e9920@gmail.com> wrote:
> > On Wed, Jun 02, 2010 at 09:54:15PM -0700, Brian Swetland wrote:
> >> On Wed, Jun 2, 2010 at 8:18 PM, mark gross <640e9920@gmail.com> wrote:
> >> > On Wed, Jun 02, 2010 at 02:58:30PM -0700, Arve Hj=F8nnev=E5g wrote:
> >> >>
> >> >> The list is not short. You have all the inactive and active
> >> >> constraints on the same list. If you change it to a two level list
> >> >> though, the list of unique values (which is the list you have to wa=
lk)
> >> >> may be short enough for a tree to be overkill.
> >> >
> >> > what have you seen in practice from the wake-lock stats?
> >> >
> >> > I'm having a hard time seeing where you could get more than just a
> >> > handfull. =A0However; one could go to a dual list (like the schedule=
r) and
> >> > move inactive nodes from an active to inactive list, or we could sim=
ply
> >> > remove them from the list uppon inactivity. =A0which would would well
> >> > after I change the api to have the client allocate the memory for the
> >> > nodes... =A0BUT, if your moving things in and out of a list a lot, I=
'm not
> >> > sure the break even point where changing the structure helps.
> >> >
> >> > We'll need to try it.
> >> >
> >> > I think we will almost never see more than 10 list elements.
> >> >
> >> > --mgross
> >> >
> >> >
> >>
> >> I see about 80 (based on the batteryinfo dump) on my Nexus One
> >> (QSD8250, Android Froyo):
> >
> > shucks.
> >
> > well I think for a pm_qos class that has boolean dynamic range we can
> > get away with not walking the list on every request update. =A0we can u=
se
> > a counter, and the list will be for mostly for stats.
> >
> =

> Did you give any thought to my suggestion to only use one entry per
> unique value on the first level list and then use secondary lists of
> identical values. That way if you only have two constraints values the

I thought you where talking about a active + inactive queue.  Sorry, I
didn't get what you where talking about.

> list you have to walk when updating a request will never have more
> than two entries regardless of how many total request you have.
> =

> A request update then becomes something like this:
>   if on primary list {
>     unlink from primary list
>     if secondary list is not empty
>       get next secondary entry and add in same spot on primary list
>   }
>   unlink from secondary list
>   find new spot on primary list
>   if already there
>     add to secondary list
>   else
>     add to primary list
>

I'm still no getting how this will allow me to reduce any aggregated
constratint re-computation to a list walk of at most 2 nodes.  But, from
a more specific point of view are you saying:
change the request struct to be something like:
struct dual_list_constriaint {
	struct list primary;
	struct list secondar;
	s32 value;
	...
} =


then uppon constraint foo update:

if foo->primary not empty:
	remove foor from primary list
	if gsecondary is not empty:
		ordered insert of foo into secondary list =

		? ordered on constraint value?
		? Arn't the constraints boolean?
remove foo from secondary list
ordered search for insert point of foo into primary list
if foo in primary:
	insert foo into secondary list
else
	insert foo into primary list

ok I'm not getting it.
is this a fancy com-sci algorithm I should know about?

--mgross
