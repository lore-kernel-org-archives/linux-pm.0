From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 13 Jun 2006 16:46:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606131620.45156.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



On Tue, 13 Jun 2006, David Brownell wrote:
>
> Here's a related patch (well, "hack") I found helpful ... specifically to
> help let _serial_ consoles be more useful.

I just checked.

I think exactly _two_ of the six machines I have around my desk have =

serial ports, and of those two, one is permanently turned off because it's =

old, noisy, and just not interesting.

Maybe I'm more progressive than most, but I personally consider serial =

lines pretty much dead.

> Although I must say I like Nigel's "BDI-2000 per developer" hack better.
> Even though not all boxes can hook up to a JTAG module.  :(

Umm. Even more importantly, I don't think the JTAG interfaces for PC's are =

necessarily even available. There is read-out logic for ARM's and embedded =

PPC, but have you ever seen anything for something non-embedded?

A really useful trick the PPC people use was to put the firewire =

controller into "anybody can read" mode, and use it as a kernel debugger =

when it basically becomes a remote memory DMA engine. I used that to debug =

some kernel hangs, and it was very nice.

However, that won't survive a power event, so it might be useful to debug =

suspend problems, but generally not resume problems.

			Linus
