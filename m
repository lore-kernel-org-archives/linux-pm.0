From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Thu, 13 Mar 2008 18:44:12 +0100
Message-ID: <20080313184412.34d09870__44989.750281866$1205430679$gmane$org@mjolnir.drzeus.cx>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
	<200803121511.17389.lenb@kernel.org>
	<20080313173437.5f00f70e@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEB33CDD@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEEB33CDD@orsmsx423.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Mar 2008 09:47:30 -0700
"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

> 
> Can you try using /dev/cpu_dma_latency from an user space application.
> Refer Documentation/pm_qos_interface.txt for usage. With this interface
> you can change menu governor behavior from userspace, by dynamically
> allowing it to use C3 or not. I am thinking that something like allowing
> C3 for few seconds and blocking it for few seconds may help.
> 

I don't quite follow. Is the theory that you get a window of a few seconds where the system stops making a noise, even as it toggles C3?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
