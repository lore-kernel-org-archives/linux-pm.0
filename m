From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 10 Mar 2008 13:49:15 +0100
Message-ID: <20080310134915.45ae7446__40560.5997344994$1205153622$gmane$org@mjolnir.drzeus.cx>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>
	<20080305070201.0d16cd40@mjolnir.drzeus.cx>
	<20080305094023.6486ebdf@mjolnir.drzeus.cx>
	<20080306092730.4412d085@mjolnir.drzeus.cx>
	<20080309151659.63d54f38@mjolnir.drzeus.cx>
	<20080310100008.GA9520@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080310100008.GA9520@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, linux-pm@lists.linux-foundation.org, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Mar 2008 11:00:08 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> On Sun 2008-03-09 15:16:59, Pierre Ossman wrote:
> > 2. uhci_hcd driver
> > 
> > USB is somehow involved in this problem. Unloading the uhci_hcd driver almost entirely kills the noise on a 1000 HZ NO_HZ kernel. On a 100 HZ, no NO_HZ kernel, the effect is very small, but still there.
> 
> USB keeps processor out of C3 in many cases.
> 

I figured that was the case. But I did not see any difference in powertop.

> > 4. Battery and AC
> > 
> > The noise increases with the battery present and also when the AC supply is removed.
> >
> 
> On battery, some machines swap C3 for "secret" C4, which is slower but
> saves power.

I guess the only way to find out is to disassemble the DSDT. Exposing myself to such concentrations of ACPI is not an appealing project. :/

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
