From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Thu, 13 Mar 2008 18:49:38 +0100
Message-ID: <20080313184938.7e27acf8__17981.90941704$1205430738$gmane$org@mjolnir.drzeus.cx>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080310100008.GA9520@elf.ucw.cz>
	<20080310134915.45ae7446@mjolnir.drzeus.cx>
	<200803121511.17389.lenb@kernel.org>
	<20080313173437.5f00f70e@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080313173437.5f00f70e@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Mar 2008 17:34:37 +0100
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> 
> It does not. But my C3 desc looks like this:
> 
> state3/desc:ACPI FFH INTEL MWAIT 0x50
> 
> What's the meaning of the last number?
> 

I've surfed Intel's web site for a bit, and found the MWAIT instruction in the arch docs. Unfortunately, it does not explain the value 0x50. According to the docs, that would be C6, which is not listed in the regular set of states for the Core 2. I did find this however:

http://www.trustedreviews.com/cpu-memory/review/2007/03/30/Intel-Processor-Roadmap-Penryn-Nehalem-and-the-Future/p2

It says that C6 is some ultra low power mode where more or less the entire chip is powered down.

Len, Venkatesh, do you have some insight? And is it harmless to move to more power hungry modes (i.e. C4 or C3).

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
