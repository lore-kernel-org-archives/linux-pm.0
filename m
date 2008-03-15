From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Sat, 15 Mar 2008 01:41:43 +0100
Message-ID: <20080315014143.32d0d5e9__44184.0989901268$1205541979$gmane$org@mjolnir.drzeus.cx>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
	<200803121511.17389.lenb@kernel.org>
	<20080313173437.5f00f70e@mjolnir.drzeus.cx>
	<20080314204041.6e376568@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEB34783@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEEB34783@orsmsx423.amr.corp.intel.com>
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

On Fri, 14 Mar 2008 14:15:46 -0700
"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

> 
> Why go only one C-state down. Why not directly drop to max_hwcstate? We
> don't need to loop through that way.
> 

Good point. But we can't just jump there and be done with it. That state might not be available (then again, we could require the user to put in a valid max_hwcstate, but that isn't as user friendly).

> There are few other concerns which make me feel that the patch will be
> not as simple as this.
> 1) BIOS may already be exporting the lower C-states as separate states.
> In which case we just have to ignore this deep C-state and return. I
> mean, on your system if BIOS exports C1, C3 and C6 hardware C-states and
> you give max_hwcstate as C3, then we don't want to have C1, C3 and C3 in
> our list.
> 

Indeed. But the current system doesn't easily allows us to handle that. Any ideas?

> 2) On same lines the other information in ACPI like (low power of 100
> and higher latency for C6 on your system) corresponds to hardware C6
> state. If we change the hardware C-state here to C3, then continue to
> use latency info from ACPI for hw C6, that may lead to inefficient state
> selection in the governor. Also, ther are assumptions related DMA,
> lapic, TSC etc in upper level ACPI based on "ACPI C-state" and changing
> underlying hardware C-state to C1 for example will change some of those
> behavior.
> 

It is still way better going to C3 less than possible than not at all (i.e. the previous workaround of processor.max_cstate). As far as I can tell from the documentation, every C-state includes all of the negative side effects of the ones preceding it. So it should just be a matter of sub-optimal selection by the governor. And I don't see how we can fix that without a big table for each processor and possibly chipset.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
