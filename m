From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 11 Mar 2008 16:20:26 +0100
Message-ID: <20080311162026.012744cd__45098.3726339929$1205249227$gmane$org@mjolnir.drzeus.cx>
References: <20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>
	<20080305070201.0d16cd40@mjolnir.drzeus.cx>
	<20080305094023.6486ebdf@mjolnir.drzeus.cx>
	<20080306092730.4412d085@mjolnir.drzeus.cx>
	<20080309151659.63d54f38@mjolnir.drzeus.cx>
	<20080311085145.5fcf3186@mjolnir.drzeus.cx>
	<20080311104822.GC18917@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080311104822.GC18917@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, linux-pm@lists.linux-foundation.org, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 11 Mar 2008 11:48:22 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> > I have now found a very hacky workaround that is slightly better than
> > disabling C3 altogether; making C3 exclusive to one core at a time. It
> > seems to kill the noise and the system now spends 50% in C3, instead of
> > 0%.
> 
> I suspect it won't do much of C3 if only one core is idle this way.
> Most likely you just disabled C3 this way in a way invisible to software.
> 

What a letdown... I'll pull out the old watt meter again and see if I can confirm that.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
