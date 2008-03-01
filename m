From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Sat, 1 Mar 2008 15:11:55 +0100
Message-ID: <20080301151155.55209ebb__19100.8179834627$1204380885$gmane$org@mjolnir.drzeus.cx>
References: <20080225193134.104b386d@mjolnir.drzeus.cx>
	<Pine.LNX.4.44L0.0802251451050.5536-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802251451050.5536-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 25 Feb 2008 15:00:51 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> 
> Maybe a better approach would be to leave the workqueue unfreezable,
> and keep cancel_delayed_work_sync() in mmc_suspend_host().  It would
> then be necessary to add a test to verify, if there is a card attached,
> that the card is indeed suspended.  After all, it's possible that the
> cancel_delayed_work_sync() ended up waiting for a job already running
> on the workqueue to register a new card!  (The same would be true even 
> with flush_scheduled_work.)

How would that be handled? I'd prefer a patch as I'm evidently not up to date with how to fondle the pm stuff properly. :)

> 
> Also, as a bit of defensive programming, it might be a good idea to add
> a "suspended" flag to the mmc_host structure.  If mmc_rescan() sees
> that the flag is set then it should return immediately.  This would
> protect against host drivers that aren't careful to disable detect
> IRQs before calling mmc_suspend_host().

Indeed. I'll add that to my todo.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
