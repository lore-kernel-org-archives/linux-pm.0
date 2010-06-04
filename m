From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 21:07:07 -0700
Message-ID: <AANLkTimiIyT2TxV5BhhtXwKNKUN9Pa5Bl8YtcoJpHNsw__7641.69647959552$1275624498$gmane$org@mail.gmail.com>
References: <AANLkTikxws5kmFhnBO1MLzE65ETka3Jy0R5ayAKTS1Lc@mail.gmail.com>
	<AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X@mail.gmail.com>
	<1275575794.5914.74.camel@mulgrave.site>
	<201006032305.58082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006032305.58082.rjw@sisk.pl>
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

On Thu, Jun 3, 2010 at 2:05 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 03 June 2010, James Bottomley wrote:
>> On Thu, 2010-06-03 at 00:10 -0700, Arve Hj=F8nnev=E5g wrote:
>> > On Wed, Jun 2, 2010 at 10:40 PM, mark gross <640e9920@gmail.com> wrote:
>> > > On Wed, Jun 02, 2010 at 09:54:15PM -0700, Brian Swetland wrote:
>> > >> On Wed, Jun 2, 2010 at 8:18 PM, mark gross <640e9920@gmail.com> wro=
te:
>> > >> > On Wed, Jun 02, 2010 at 02:58:30PM -0700, Arve Hj=F8nnev=E5g wrot=
e:
>> > >> >>
>> > >> >> The list is not short. You have all the inactive and active
>> > >> >> constraints on the same list. If you change it to a two level li=
st
>> > >> >> though, the list of unique values (which is the list you have to=
 walk)
>> > >> >> may be short enough for a tree to be overkill.
>> > >> >
>> > >> > what have you seen in practice from the wake-lock stats?
>> > >> >
>> > >> > I'm having a hard time seeing where you could get more than just a
>> > >> > handfull. =A0However; one could go to a dual list (like the sched=
uler) and
>> > >> > move inactive nodes from an active to inactive list, or we could =
simply
>> > >> > remove them from the list uppon inactivity. =A0which would would =
well
>> > >> > after I change the api to have the client allocate the memory for=
 the
>> > >> > nodes... =A0BUT, if your moving things in and out of a list a lot=
, I'm not
>> > >> > sure the break even point where changing the structure helps.
>> > >> >
>> > >> > We'll need to try it.
>> > >> >
>> > >> > I think we will almost never see more than 10 list elements.
>> > >> >
>> > >> > --mgross
>> > >> >
>> > >> >
>> > >>
>> > >> I see about 80 (based on the batteryinfo dump) on my Nexus One
>> > >> (QSD8250, Android Froyo):
>> > >
>> > > shucks.
>> > >
>> > > well I think for a pm_qos class that has boolean dynamic range we can
>> > > get away with not walking the list on every request update. =A0we ca=
n use
>> > > a counter, and the list will be for mostly for stats.
>> > >
>> >
>> > Did you give any thought to my suggestion to only use one entry per
>> > unique value on the first level list and then use secondary lists of
>> > identical values. That way if you only have two constraints values the
>> > list you have to walk when updating a request will never have more
>> > than two entries regardless of how many total request you have.
>> >
>> > A request update then becomes something like this:
>> > =A0 if on primary list {
>> > =A0 =A0 unlink from primary list
>> > =A0 =A0 if secondary list is not empty
>> > =A0 =A0 =A0 get next secondary entry and add in same spot on primary l=
ist
>> > =A0 }
>> > =A0 unlink from secondary list
>> > =A0 find new spot on primary list
>> > =A0 if already there
>> > =A0 =A0 add to secondary list
>> > =A0 else
>> > =A0 =A0 add to primary list
>>
>> This is just reinventing hash bucketed lists. =A0To get the benefits, all
>> we do is implement an N state constraint as backed by an N bucketed hash
>> list, which the kernel already has all the internal mechanics for.
>
> Agreed.
>

No, a hash is used for quick lookup of a specific value, not to find
an extreme value. It is however extremely similar to plists. The only
difference is that plists link all the secondary lists together. If we
want to have constraints that autoexpire, then keeping the secondary
lists separate allows the same optimization as I did for
wakelock/suspend_blocker timeouts where no timer is active if an
(equal or stricter) non-expiring constraint is active.

-- =

Arve Hj=F8nnev=E5g
