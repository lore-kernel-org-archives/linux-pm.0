From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/07] pm: remove late/early platform driver
	pm	callbacks V2
Date: Wed, 24 Jun 2009 20:56:02 +0200
Message-ID: <20090624185602.GA7683__1189.97842441804$1245870051$gmane$org@elf.ucw.cz>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
	<200906242048.40956.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906242048.40956.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: gregkh@suse.de, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Wed 2009-06-24 20:48:39, Rafael J. Wysocki wrote:
> On Wednesday 24 June 2009, Magnus Damm wrote:
> > pm: remove late/early platform driver pm callbacks V2
> > 
> > [PATCH 01/07] arm: rework omap suspend_late()/resume_early()
> > [PATCH 02/07] dma: rework dw_dmac suspend_late()/resume_early()
> > [PATCH 03/07] dma: rework txx9dmac suspend_late()/resume_early()
> > [PATCH 04/07] i2c: rework i2c-pxa suspend_late()/resume_early()
> > [PATCH 05/07] i2c: rework i2c-s3c2410 suspend_late()/resume() V2
> > [PATCH 06/07] usb: rework musb suspend()/resume_early()
> > [PATCH 07/07] pm: remove platform device suspend_late()/resume_early() V2
> > 
> > These patches simply remove ->suspend_late() and ->resume_early()
> > from struct platform_driver. Drivers are converted to dev_pm_ops
> > with CONFIG_SUSPEND in mind. Untested.
> > 
> > All patches except [02/07] are known to compile.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> 
> If no one objects, I'd like to take this series into the suspend-2.6 tree as
> 2.6.32 material.  Greg?
> 
> Pavel, is your ACK for the entire series?

Well, I don't really understand stuff like dw_dmac.c, but it looks
basically okay to me. I guess ACK might be okay.

> >  arch/arm/plat-omap/debug-leds.c  |   11 +++++++----
> >  arch/arm/plat-omap/gpio.c        |   14 ++++++++++----
> >  drivers/base/platform.c          |   36 ------------------------------------
> >  drivers/dma/dw_dmac.c            |   15 ++++++++++-----
> >  drivers/dma/txx9dmac.c           |   15 ++++++++++-----
> >  drivers/i2c/busses/i2c-pxa.c     |   25 +++++++++++++++++--------
> >  drivers/i2c/busses/i2c-s3c2410.c |   25 ++++++++++++++++---------
> >  drivers/usb/musb/musb_core.c     |   18 ++++++++++++------
> >  include/linux/platform_device.h  |    2 --
> >  9 files changed, 82 insertions(+), 79 deletions(-)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
