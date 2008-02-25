From: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Mon, 25 Feb 2008 19:31:34 +0100
Message-ID: <20080225193134.104b386d__29783.2318618477$1203967799$gmane$org@mjolnir.drzeus.cx>
References: <20080225184102.0a2e2bb5@mjolnir.drzeus.cx>
	<Pine.LNX.4.44L0.0802251255000.5039-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802251255000.5039-100000@iolanthe.rowland.org>
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

On Mon, 25 Feb 2008 12:58:30 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> Thanks for the explanations.
> 
> On Mon, 25 Feb 2008, Pierre Ossman wrote:
> 
> > Trying to keep up with the PM changes is a full time job. For now I've
> > mostly ignored it as I don't even have time for the other stuff.
> > Patches welcome.
> 
> What do you think of the patch attached to comment #40 in the Bugzilla 
> entry?
> 

Looks ok. As long as those two synchronization points are guaranteed,
then I'm happy.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
