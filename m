From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: Runtime PM discussion notes
Date: Sat, 25 Jun 2011 14:33:35 +0900
Message-ID: <BANLkTimopuwk91vP6uS3fR8Lc5tf9VF9gw__26398.0793803514$1308980081$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201106232234.21930.rjw@sisk.pl>
	<alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
	<BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2011/6/25 Arve Hj=F8nnev=E5g <arve@android.com>:
> On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
> ...
>>
>> As I understand it, in the original Android implementation, the hardware
>> that they were using didn't have fine-grained power management. =A0So
>> system-wide suspend made more sense in that context. =A0But that shouldn=
't
>> be confused with the modern rationale for wakelocks:
>>
>> https://lists.linux-foundation.org/pipermail/linux-pm/2010-May/025668.ht=
ml
>>
>> "On the hardware that shipped we enter the same power state from idle
>> and suspend, so the only power savings we get from suspend that we
>> don't get in idle is from not respecting the scheduler and timers."
>>
>
> This is no longer the case. Both the Nexus-S and Xoom enter lower
> power states from suspend than idle.

Interesting, thanks for pointing that out. So this lower-power-state
in system suspend, is that a hardware limitation, or just a reflection
on effort spent on the CPUIdle portion of the current software
implementation? I suspect it's the latter.

I've recently been working towards implementing software support for
deeper sleep modes on sh7372 in the mainline kernel. With my
experimental patch the system suspend case may be able to sleep deeper
that current CPUIdle, but that's only because I have not yet tied in
enough dependency tracking to make proper decisions from CPUIdle
context.

Getting sleep modes working transparently with CPUIdle is currently a
bit more difficult than simply using system suspend IMO, so I would
not be surprised if some vendors simply skip implementing some deeper
sleep modes in CPUIdle due to the added complexity.

>From the hardware perspective nothing is stopping us to use CPUIdle
with the lowest sleep states. This is true for all SH-Mobile SoCs
including sh7372. Also, we don't rely on firmware for control of the
PM states - if anyone is restricted by a firmware interface then
obviously it's going to be difficult to do more fine grained power
management.

Cheers,

/ magnus
