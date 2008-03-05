From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Wed, 5 Mar 2008 09:40:23 +0100
Message-ID: <20080305094023.6486ebdf__46607.896188698$1204706795$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>
	<20080305070201.0d16cd40@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080305070201.0d16cd40@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 5 Mar 2008 07:02:01 +0100
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> 
> I tried using predicted_us and last_measured_us, and those didn't work (see the #if 0 code in my last patch). And since cpuidle_get_last_residency() is part of predicted_us, I don't think it is reporting useful values.
> 

I take this back. They might be working just fine. It seems I've been looking at a too small piece of the puzzle. This machine has a dual core processor, and the governors control each core independently. Unfortunately it's the power fluctuations of the entire socket that causes noise, not just each processor.

So I need to build some global algorithm instead of one per core. Ideas are welcome.

>From what I can tell, disabling one core makes the noise go away. So I guess both cores need to go into C3 (or perhaps one C2 and one C3) at the same time to cause the problem. I'm not 100% sure of this as the damn noise comes and goes, but I've been running for an hour or so now with one core disabled and without my anti-noise patch.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
