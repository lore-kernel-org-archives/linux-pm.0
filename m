From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 01 Jun 2010 09:57:31 +0300
Message-ID: <4C04AF5B.1000702__46801.1241792285$1275374118$gmane$org@nokia.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>	<201005302202.39511.rjw@sisk.pl>	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?ext_Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

Hi,

ext Arve Hj=F8nnev=E5g wrote:

> It sounded like you were suggesting that initiating suspend from idle
> would somehow avoid the race condition with wakeup events. All I'm
> saying is that you would need to block suspend in all the same places.
> If you don't care about ignoring wakeup events, then sure you can
> initiate suspend from idle.
>   =


Sorry if i'm asking something that was already said, but the thread is =

quite complex and i am not sure i have been able to grasp all of it.

So, regardless of the SW implementation:

-1) are you focusing on "good" HW or do you want to address all at the =

same time?

-2) would you be ok with addressing "bad" HW as a special case, which =

requires workarounds and shouldn't dictate the overall design?

-3) do you agree with the assumption that new HW is expected to get =

reasonably better and therefore workarounds at point 2) will =

progressively be confined to devices less and less common?

-4) going to the definition of "good" and "bad" (maybe this should have =

come earlier in the list), can we define "good" HW as HW where:
 * suspend state and lowest achievable runtime idle state are basically =

equivalent from both power consumption and latency pov
 * the HW itself is properly able to track wakeup sources while it is in =

its deepest power state (as example OMAP3 has few independent =

wake-capable pads and a "wake ring" where one only gets the information =

that at least one of the pads belonging to such ring has received a wakeup)
 * wakeup sources can be dynamically masked at HW level, so that if a =

peripheral is not interesting, it doesn't wakeup the system (for example =

the camera button when the camera cover is closed)

-5) HW that is not capable of properly generating asynchronous signal is =

most likely the cause for extra timers in kernel and it should be =

considered "bad" - in any other case having recurring in-kernel timers =

should be treated as bugs, if their existence is not tied to some =

meaningful work

thanks, igor
