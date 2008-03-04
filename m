From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Tue, 4 Mar 2008 07:03:57 +0100
Message-ID: <20080304070357.61ee825b__34735.0050848492$1204610855$gmane$org@mjolnir.drzeus.cx>
References: <200802241500.41969.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0802240941440.29504-100000@netrider.rowland.org>
	<20080225184102.0a2e2bb5@mjolnir.drzeus.cx>
	<200803031359.38263.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803031359.38263.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Mar 2008 13:59:37 -0800
David Brownell <david-b@pacbell.net> wrote:

> 
> Card insert/remove events can be system wake events though.  Which
> makes that restriction impractical.
> 
> I think hosts need to be able to call mmc_detect_change() as soon as
> they see a stable signal.  The MMC core can hold off handling that
> for a while, if it needs to wait until the code walking the device
> tree gets around to resuming that host.  It's a lot more natural to
> hold off such stuff one time there than in N host drivers; especially
> since the MMC core already has such hold-off code.
> 

That actually sorts itself out as the MMC core reprobes on wakeup, but I see your point. Right now things will work peachy if the controllers just make sure to disable their card detection logic before telling the core to suspend.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
