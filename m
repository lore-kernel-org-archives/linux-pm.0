From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 18:11:22 -0700
Message-ID: <AANLkTimM7O_k8KVSfMgsB8b_EKQEz0vpYu6pxjedsTcJ__1295.86930056593$1275095535$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<20100528104415.1403541a@schatten.dmk.lab>
	<AANLkTikXtk-f41-z8gXfXLNLqgGVa0z4d-qgIvwljbR-@mail.gmail.com>
	<201005290024.22915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005290024.22915.rjw@sisk.pl>
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

2010/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Friday 28 May 2010, Arve Hj=F8nnev=E5g wrote:
>> On Fri, May 28, 2010 at 1:44 AM, Florian Mickler <florian@mickler.org> w=
rote:
>> > On Thu, 27 May 2010 20:05:39 +0200 (CEST)
>> > Thomas Gleixner <tglx@linutronix.de> wrote:
> ...
>> > To integrate this with the current way of doing things, i gathered it
>> > needs to be implemented as an idle-state that does the suspend()-call?
>> >
>>
>> I think it is better no not confuse this with idle. Since initiating
>> suspend will cause the system to become not-idle, I don't think is is
>> beneficial to initiate suspend from idle.
>
> It is, if the following two conditions hold simultaneously:
>
> (a) Doing full system suspend is ultimately going to bring you more energy
> =A0 =A0savings than the (presumably lowest) idle state you're currently i=
n.
>
> (b) You anticipate that the system will stay idle for a considerably long=
 time
> =A0 =A0such that it's worth suspending.
>

I still don't think this matters. If you are waiting for in interrupt
that cannot wake you up from suspend, then idle is not an indicator
that it is safe to enter suspend. I also don't think you can avoid any
user-space suspend blockers by delaying suspend until the system goes
idle since any page fault could cause it to go idle. Therefore I don't
see a benefit in delaying suspend until idle when the last suspend
blocker is released (it would only mask possible race conditions).

-- =

Arve Hj=F8nnev=E5g
