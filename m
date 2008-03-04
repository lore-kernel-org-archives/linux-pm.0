From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 18:19:24 +0100
Message-ID: <20080304181924.70aaf8c1__45395.8829785281$1204651475$gmane$org@mjolnir.drzeus.cx>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
	<Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080304071423.0e6b71c1@mjolnir.drzeus.cx>
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

On Tue, 4 Mar 2008 07:14:23 +0100
Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> 
> Many devices today are of a less than stellar quality, and singing
> capacitors are a common problem. A high-pitch noise is created, caused
> by power fluctuations as the processor enters and leaves deep sleep at
> a high frequency.
> 
> Instead of just disabling the deep sleep (which wastes power), this
> patch allows you to reduces the number of times it is entered so that
> the frequency can be kept inaudible.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> --

Hold off on this. It turns out it still has major problems. The menu algorithm now and then gets really bad at predicting sleep times, completely killing this avoidance scheme.

(On that subject, does anyone except Adam understand that algorithm? Some comments wouldn't hurt...)

So for now, I'm back to thinking that measuring the interval between deep sleeps is the better approach. I could use some ideas for a good clock source though. I haven't dug much deeper than jiffies when it comes to kernel timekeeping.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
