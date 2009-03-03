From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 2 Mar 2009 17:22:46 -0800
Message-ID: <d6200be20903021722y7f085482o66f6dee8c4004acd__29585.0697592416$1236043599$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902282353.39763.rjw@sisk.pl>
	<d6200be20902281606g1c5db332r9970931d7080717f@mail.gmail.com>
	<200903011020.53130.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903011020.53130.rjw@sisk.pl>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 1, 2009 at 1:20 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> >> I do provide an option to turn off the wakelock stats, which makes
>> >> >> wake_lock/unlock significantly faster, but we never run with wakel=
ock
>> >> >> stats off. Also, it pushes timeout handling to the drivers. I know=
 may
>> >> >> of you don't like timeout support, but ignoring the problem is not=
 a
>> >> >> solution. If each driver that needs timeouts uses its own timer, t=
hen
>> >> >> you will often wakeup from idle just to unlock a wakelock that will
>> >> >> not trigger suspend. This wakeup is a thousand times as costly on =
the
>> >> >> msm platform as a wakelock/unlock pair (with wakelock stats enable=
d).
>> >> >
>> >> > Well, at least a couple of people told you that the timeouts are ha=
rdly
>> >> > acceptable and they told you why. =A0Please stop repeating the same=
 arguments you
>> >> > have given already for a couple of times. =A0They're not convincing.
>> >>
>> >> And you keep ignoring them.
>> >
>> > Not ignoring, but considering them as insufficient. =A0And since they'=
ve already
>> > been considered as insufficient, there's no point repeating them over =
and over
>> > again. =A0That doesn't make them any better.
>>
>> The problem is that what you consider insufficient is what allows us
>> to ship a product.
>
> This doesn't matter a whit, because the mainline kernel is not just your
> product.

Unless you are saying that changes in the mainline kernel does not
need be usable in practice, then it does matter. If we remove the
feature that allows us to interact with existing code, it will take
much longer before it is usable by anyone.

> By the same rule you could say that every working vendor driver is worth
> merging into the mainline kernel, which clearly is not the case.

Some people seem to think they are.

>
>> >> > I do realize that you consider your current solution as the best th=
ing since
>> >> > the sliced bread, but please accept the fact that the other people =
think
>> >> > differently.
>> >>
>> >> I certainly do not think my current solution is the best, it is very
>> >> invasive. I do however think your proposed solution is worse. The only
>> >> proposed alternative that we could actually ship a product on today is
>> >> to not use suspend at all.
>> >
>> > Well, I'm sure your code is useful for the Android platform, but the q=
uestion
>> > is whether we want this code in the mainline kernel. =A0For now, the a=
nswer is
>> > "no, we don't". =A0Moreover, since you're the one who wants the code t=
o be
>> > merged, it's your burden to make it acceptable for us. =A0However you'=
re going
>> > to do it is up to you, but certainly trying to force your current code=
 on us
>> > is not going to work.
>>
>> I don't think I am the only one who want this code in the mainline
>> kernel. Many people want to use the android platform, and support in
>> the mainline kernel would be beneficial to some of them. I made many
>> requested changes to my code that provides no benefit to us, but I
>> have not made any changes that breaks our own use.
>
> OK, please resubmit the patches, then.

I submitted them three weeks ago. I'll submit a new set after I rename
the api (presumably to suspend_block(er)) but I would like more
agreement on the timeout issue first.

-- =

Arve Hj=F8nnev=E5g
