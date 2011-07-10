From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 8/8] ARM / shmobile: Support for I/O PM
	domains for SH7372 (v5)
Date: Sun, 10 Jul 2011 13:45:35 +0200
Message-ID: <201107101345.36135.laurent.pinchart__47328.6498258405$1310306893$gmane$org@ideasonboard.com>
References: <201106112223.04972.rjw@sisk.pl> <201106142316.02812.rjw@sisk.pl>
	<BANLkTi=u_eyGZt9e0CuVpyz9B08HarEyVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=u_eyGZt9e0CuVpyz9B08HarEyVw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Magnus,

On Wednesday 15 June 2011 16:17:15 Magnus Damm wrote:
> On Wed, Jun 15, 2011 at 6:16 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, June 14, 2011, Magnus Damm wrote:
> >> On Sun, Jun 12, 2011 at 5:40 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >> > 
> >> > Use the generic power domains support introduced by the previous
> >> > patch to implement support for power domains on SH7372.
> >> > 
> >> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >> > ---
> >> 
> >> Thanks for your work on this. I just tried this on my Mackerel board,
> >> but I can't seem to get the pd_power_up() and pd_power_down()
> >> callbacks to be executed. It is probably a misconfiguration from my
> >> side.
> > 
> > They trigger for me e.g. after doing
> > 
> > # echo 3 > /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> > 
> > Attached is the .config I've been using.
> 
> Thanks, I can trigger using sysfs and your kernel configuration.
> 
> However, I assumed it also would work when the sceen saver kicked in.
> I recall it being fbcon that controls the screen save, perhaps
> something else. So just wait a bit and see if you also can reproduce
> it. The console gets black but the power is still on...

That's because, by default, the VT layer will use FB_BLANK_NORMAL mode when 
blanking the console. Switching that to FB_BLANK_VSYNC_SUSPEND, 
FB_BLANK_HSYNC_SUSPEND or FB_BLANK_POWERDOWN with TIOCLINUX(TIOC_SETVESABLANK) 
results in the device being runtime-suspended when the console is blanked.

> Also forcing to go back to powered-on state (see below) doesn't work that
> well: # echo 0 >
> /sys/devices/platform/sh_mobile_lcdc_fb.0/graphics/fb0/blank
> 
> It looks like we loose the panning information somehow. Most likely a LCDC
> driver bug. Unless the driver callbacks are not being invoked as expected.
>
> Also, there is garbage in on the screen if FB_SH_MOBILE_MERAM is
> enabled. The MERAM hardware is a 1.5 MiB memory block that can be used
> as a LCD cache. It sits in the same hardware power domain as the
> LCDCs. I don't think the MERAM software supports power down
> unfortunately. Disabling MERAM support removes the garbage on the
> screen.

-- 
Regards,

Laurent Pinchart
