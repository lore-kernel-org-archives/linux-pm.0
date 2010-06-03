From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 15:55:52 +0200
Message-ID: <20100603155552.24c38afc__14252.5887386457$1275573411$gmane$org@schatten.dmk.lab>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Arve =?ISO-8859-15?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Thomas@smtp1.linux-foundation.org, Ingo@smtp1.linux-foundation.org, 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, PM <linux-pm@lists.linux-foundation.org>, Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jun 2010 00:10:03 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:

> On Wed, Jun 2, 2010 at 10:40 PM, mark gross <640e9920@gmail.com> wrote:

> > well I think for a pm_qos class that has boolean dynamic range we can
> > get away with not walking the list on every request update. =A0we can u=
se
> > a counter, and the list will be for mostly for stats.
> >
> =

> Did you give any thought to my suggestion to only use one entry per
> unique value on the first level list and then use secondary lists of
> identical values. That way if you only have two constraints values the
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
> =


Yes. I think that would be good. If we keep the primary list sorted,
then this becomes a nice priority queue implementation which does =

GetMax in constant time and Insert and Delete in logarithmic
complexity to the number of different values.

Cheers,
Flo
