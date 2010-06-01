From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 21:57:05 -0700
Message-ID: <AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX__10950.116653885$1275368383$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005312347.24251.rjw@sisk.pl>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

2010/5/31 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday 31 May 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
> ...
>>
>> I think it makes more sense to block suspend while wakeup events are
>> pending than blocking it everywhere timers are used by code that could
>> be called while handling wakeup events or other critical work. Also,
>> even if you did block suspend everywhere timers where used you still
>> have the race where a wakeup interrupt happens right after you decided
>> to suspend. In other words, you still need to block suspend in all the
>> same places as with the current opportunistic suspend code, so what is
>> the benefit of delaying suspend until idle?
>
> Assume for a while that you don't use suspend blockers, OK? =A0I realize =
you
> think that anything else doesn't make sense, but evidently some other peo=
ple
> have that opinion about suspend blockers.
>

It sounded like you were suggesting that initiating suspend from idle
would somehow avoid the race condition with wakeup events. All I'm
saying is that you would need to block suspend in all the same places.
If you don't care about ignoring wakeup events, then sure you can
initiate suspend from idle.

> Now, under that assumption, I think it _generally_ is reasonable to make =
the
> system go into full suspend if everything (ie. CPUs and I/O) has been idle
> for sufficiently long time and there are no QoS requirements that aren't
> compatible with full system suspend.
>

-- =

Arve Hj=F8nnev=E5g
