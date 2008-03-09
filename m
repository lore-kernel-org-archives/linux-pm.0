From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Sun, 9 Mar 2008 15:16:59 +0100
Message-ID: <20080309151659.63d54f38__39002.8448812247$1205072537$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>
	<20080305070201.0d16cd40@mjolnir.drzeus.cx>
	<20080305094023.6486ebdf@mjolnir.drzeus.cx>
	<20080306092730.4412d085@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080306092730.4412d085@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
Cc: Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org

I'm beginning to think this is a lost cause. I've tried several variants, all without satisfactory results.

In case anyone else has any more ideas, I'll detail what I've found influences the noise:

1. C state

This is the big one. There is no noise as long as C3 is avoided (processor.max_cstate).

2. uhci_hcd driver

USB is somehow involved in this problem. Unloading the uhci_hcd driver almost entirely kills the noise on a 1000 HZ NO_HZ kernel. On a 100 HZ, no NO_HZ kernel, the effect is very small, but still there.

3. Low speed USB devices

Related, the noise goes away if I insert a USB mouse (low speed). A high-speed device does not effect the noise, neither does the two built-in low speed devices (a fingerprint reader and a bluetooth host).

4. Battery and AC

The noise increases with the battery present and also when the AC supply is removed.

5. Second core

Disabling the second core makes the noise go away. This might be a subset of 1., as I've been told that a stopped core enters C1.


Changing HZ and NO_HZ has no noticeable effect on the problem (except the odd behaviour in 2.). This is further supported by the fact that Windows also has the problem (which should behave close to 100 HZ without NO_HZ).


So for now, the only viable workaround is processor.max_cstate....

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
