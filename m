From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 28 Feb 2009 15:38:00 -0800
Message-ID: <d6200be20902281538g1dd6aec4q1b42b610d3ea15d1__33011.1903408126$1235864523$gmane$org@mail.gmail.com>
References: <200902192215.18365.rjw@sisk.pl> <200902281118.14595.rjw@sisk.pl>
	<d6200be20902281357r2d3a0075q77055c1781f174d7@mail.gmail.com>
	<200902282353.39763.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902282353.39763.rjw@sisk.pl>
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

On Sat, Feb 28, 2009 at 2:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday 28 February 2009, Arve Hj=F8nnev=E5g wrote:
>> Can you summarize what the problems with my current api are? I get the
>> impression that you think the overhead of using a list is too high,
>> and that timeout support should be removed because you think all
>> drivers that use it are broken.
>
> In no particular order:
> 1. One user space process can create an unlimited number of wakelocks. =
=A0This
> =A0 shouldn't be possible. =A0Moreover, it is not even necessary for any =
process
> =A0 to have more than one wakelock held at any time.

This has been addressed. A user space process cannot create more
wakelocks than it has filedescriptors.

> 2. Timeouts are wrong, because they don't really _solve_ any problem. =A0=
They are
> =A0 useful for working around the fact that you can't or you don't want to
> =A0 modify every piece of code that in principle should take a wakelock a=
nd
> =A0 that's it.

Yes, timeouts are sometimes wrong, but they are not always wrong. I
gave two examples where the use of timeouts was not incorrect.

> =A0However, =A0entire concept of having one code path acting on
> =A0 behalf of another one on a hunch that it might be doing something mak=
ing
> =A0 suspend undesirable is conceptually broken IMO.

OK. Do you have an alternative?

I my opinion this is how the entire system works if you do autosuspend
without a mechanism like wakelocks.

> 3. The overhead of using a list is unnecessary and _therefore_ too high (=
not
> =A0 just too high).

It is only unnecessary if you do not want accounting or timeouts. The
overhead of a timer going off when it is not needed (if you push
timeouts to the drivers) is way higher then the overhead putting
wakelocks on a list.

> 4. There seems to be a race between user space wakelocks and the freezer
> =A0 (perhaps I overlooked something, in which case please disregard this =
item).

You are missing something. Wakelocks overlap.

> 5. The name "wakelocks" is confusing, because they aren't locks and they
> =A0 affect suspend, not wake.

I can change the name. Currently suspend_blocker seems to be
acceptable many people, but some don't like this name either.

> 6. Last time I saw the patches they were barely commented and the changel=
ogs
> =A0 didn't describe the code well (if at all).

I have not added many inline comments, but I did add the kerneldoc
comments you requested, and a lot of documentation since the first
patches.

> 7. There's no clear distinction between debug/stats code and the basic
> =A0 functionality.

I don't think this is still true.

-- =

Arve Hj=F8nnev=E5g
