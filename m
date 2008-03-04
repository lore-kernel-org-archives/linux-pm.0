From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 18:30:32 +0100
Message-ID: <20080304183032.17084e39__22052.4655226201$1204652042$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<20080304172918.GA27332@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304172918.GA27332@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008 18:29:18 +0100
Andi Kleen <andi@firstfloor.org> wrote:

> > So for now, I'm back to thinking that measuring the interval between deep sleeps is the better approach. I could use some ideas for a good clock source though. I haven't dug much deeper than jiffies when it comes to kernel timekeeping.
> 
> jiffies should work, you just need to make sure you measure them at the
> right place. In particular there is some code in dyntick that catches
> up on jiffies after the deep sleep when the normal timer handler didn't run
> and jiffies are only usable again after that code executed.
> 

And how can I tell if this handler has run? Not that it really matters I guess, as I don't think running it from the cpuidle governor is very sane.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
