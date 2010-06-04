From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 4 Jun 2010 15:09:01 +0200
Message-ID: <20100604150901.50a115e1__20627.3555908867$1275657018$gmane$org@schatten.dmk.lab>
References: <AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
	<1275575794.5914.74.camel@mulgrave.site>
	<201006032305.58082.rjw@sisk.pl>
	<AANLkTimiIyT2TxV5BhhtXwKNKUN9Pa5Bl8YtcoJpHNsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimiIyT2TxV5BhhtXwKNKUN9Pa5Bl8YtcoJpHNsw@mail.gmail.com>
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
Cc: Ingo@smtp1.linux-foundation.org, 640e9920@gmail.com, markgross@thegnar.org, Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Molnar <mingo@elte.hu>, Peter@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jun 2010 21:07:07 -0700
Arve Hj=F8nnev=E5g <arve@android.com> wrote:

> On Thu, Jun 3, 2010 at 2:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday 03 June 2010, James Bottomley wrote:
> >> On Thu, 2010-06-03 at 00:10 -0700, Arve Hj=F8nnev=E5g wrote:
> >> > A request update then becomes something like this:
> >> > =A0 if on primary list {
> >> > =A0 =A0 unlink from primary list
> >> > =A0 =A0 if secondary list is not empty
> >> > =A0 =A0 =A0 get next secondary entry and add in same spot on primary=
 list
> >> > =A0 }
> >> > =A0 unlink from secondary list
> >> > =A0 find new spot on primary list
> >> > =A0 if already there
> >> > =A0 =A0 add to secondary list
> >> > =A0 else
> >> > =A0 =A0 add to primary list
> >>
> >> This is just reinventing hash bucketed lists. =A0To get the benefits, =
all
> >> we do is implement an N state constraint as backed by an N bucketed ha=
sh
> >> list, which the kernel already has all the internal mechanics for.
> >
> > Agreed.
> >
> =

> No, a hash is used for quick lookup of a specific value, not to find
> an extreme value. It is however extremely similar to plists. The only
> difference is that plists link all the secondary lists together. If we
> want to have constraints that autoexpire, then keeping the secondary
> lists separate allows the same optimization as I did for
> wakelock/suspend_blocker timeouts where no timer is active if an
> (equal or stricter) non-expiring constraint is active.

Can you give an example for the optimization or elaborate about the
negative effect of linking the secondary lists together? I don't
understand right now.

Would be hlist from list.h better? (I think that is what James is
referring to?) That is a (single-linked-)list of double-linked-lists. =


Cheers,
Flo
