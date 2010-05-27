From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Thu, 27 May 2010 16:50:36 -0700
Message-ID: <AANLkTinTk6iCgfcY1QaZkCCapYjzbEYgGbSR4Ki75z0R__30463.603747967$1275004417$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<201005272315.28475.rjw@sisk.pl>
	<alpine.LFD.2.00.1005272334040.3478@localhost.localdomain>
	<201005280143.01889.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005280143.01889.rjw@sisk.pl>
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
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 4:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday 27 May 2010, Thomas Gleixner wrote:
>> On Thu, 27 May 2010, Rafael J. Wysocki wrote:
>>
>> > On Thursday 27 May 2010, Thomas Gleixner wrote:
>> > > On Thu, 27 May 2010, Alan Stern wrote:
>> > >
>> > > > On Thu, 27 May 2010, Felipe Balbi wrote:
>> > > >
>> > > > > On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wrote:
>> > > > > >If people don't mind, here is a greatly simplified summary of t=
he
>> > > > > >comments and objections I have seen so far on this thread:
>> > > > > >
>> > > > > > =A0 =A0 The in-kernel suspend blocker implementation is okay, =
even
>> > > > > > =A0 =A0 beneficial.
>> > > > >
>> > > > > I disagree here. I believe expressing that as QoS is much better=
. Let
>> > > > > the kernel decide which power state is better as long as I can s=
ay I
>> > > > > need 100us IRQ latency or 100ms wakeup latency.
>> > > >
>> > > > Does this mean you believe "echo mem >/sys/power/state" is bad and
>> > > > should be removed? =A0Or "echo disk >/sys/power/state"? =A0They pa=
y no
>> > >
>> > > mem should be replaced by an idle suspend to ram mechanism
>> >
>> > Well, what about when I want the machine to suspend _regardless_ of wh=
ether
>> > or not it's idle at the moment? =A0That actually happens quite often t=
o me. :-)
>>
>> Fair enough. Let's agree on a non ambigous terminology then:
>>
>> =A0 =A0 =A0forced:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0suspend which you enforce via user interaction, w=
hich
>> =A0 =A0 =A0 =A0 =A0 =A0also implies that you risk losing wakeups dependi=
ng on
>> =A0 =A0 =A0 =A0 =A0 =A0the hardware properties
>
> OK
>
>> =A0 =A0 =A0opportunistic:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0suspend driven from the idle context, which guara=
ntees to
>> =A0 =A0 =A0 =A0 =A0 =A0not lose wakeups. Provided only when the hardware=
 does
>> =A0 =A0 =A0 =A0 =A0 =A0provide the necessary capabilities.
>
> I can accept that definition, but this is not what "opportunistic" means =
in the

Is there a difference between this new definition of opportunistic and
idle? I assume suspend here means low a low power sleep state since it
is impossible to initiate and abort Linux suspend from idle since
initiating suspend will cause the system to become not idle.

> Arve's changelogs. =A0What it means there is that he wants the system to =
suspend
> even when it is not technically idle (like in the updatedb example I gave=
 in a
> previous message). =A0Suspend blockers are supposed to be a mechanism by =
which
> the kernel and user space together may determine when to suspend (and it's
> somewhat orthogonal to idle).
>



-- =

Arve Hj=F8nnev=E5g
