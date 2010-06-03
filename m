From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 3 Jun 2010 00:10:03 -0700
Message-ID: <AANLkTikvuqtcGS1UdePRxipSk4S5Vmci2uPfFtzZgx6X__28744.5194706836$1275549070$gmane$org@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603054018.GE11311@gvim.org>
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

On Wed, Jun 2, 2010 at 10:40 PM, mark gross <640e9920@gmail.com> wrote:
> On Wed, Jun 02, 2010 at 09:54:15PM -0700, Brian Swetland wrote:
>> On Wed, Jun 2, 2010 at 8:18 PM, mark gross <640e9920@gmail.com> wrote:
>> > On Wed, Jun 02, 2010 at 02:58:30PM -0700, Arve Hj=F8nnev=E5g wrote:
>> >>
>> >> The list is not short. You have all the inactive and active
>> >> constraints on the same list. If you change it to a two level list
>> >> though, the list of unique values (which is the list you have to walk)
>> >> may be short enough for a tree to be overkill.
>> >
>> > what have you seen in practice from the wake-lock stats?
>> >
>> > I'm having a hard time seeing where you could get more than just a
>> > handfull. =A0However; one could go to a dual list (like the scheduler)=
 and
>> > move inactive nodes from an active to inactive list, or we could simply
>> > remove them from the list uppon inactivity. =A0which would would well
>> > after I change the api to have the client allocate the memory for the
>> > nodes... =A0BUT, if your moving things in and out of a list a lot, I'm=
 not
>> > sure the break even point where changing the structure helps.
>> >
>> > We'll need to try it.
>> >
>> > I think we will almost never see more than 10 list elements.
>> >
>> > --mgross
>> >
>> >
>>
>> I see about 80 (based on the batteryinfo dump) on my Nexus One
>> (QSD8250, Android Froyo):
>
> shucks.
>
> well I think for a pm_qos class that has boolean dynamic range we can
> get away with not walking the list on every request update. =A0we can use
> a counter, and the list will be for mostly for stats.
>

Did you give any thought to my suggestion to only use one entry per
unique value on the first level list and then use secondary lists of
identical values. That way if you only have two constraints values the
list you have to walk when updating a request will never have more
than two entries regardless of how many total request you have.

A request update then becomes something like this:
  if on primary list {
    unlink from primary list
    if secondary list is not empty
      get next secondary entry and add in same spot on primary list
  }
  unlink from secondary list
  find new spot on primary list
  if already there
    add to secondary list
  else
    add to primary list

-- =

Arve Hj=F8nnev=E5g
