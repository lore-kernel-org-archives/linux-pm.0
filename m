From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 04/11] ARM: shmobile: armadillo800eva legacy: Add
 missing A4S pm domain devices
Date: Mon, 27 Oct 2014 12:59:15 +0900
Message-ID: <20141027035915.GE31487@verge.net.au>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
 <1414063141-8856-5-git-send-email-geert+renesas@glider.be>
 <20141027035657.GC31487@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55927 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbaJ0D7T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Oct 2014 23:59:19 -0400
Content-Disposition: inline
In-Reply-To: <20141027035657.GC31487@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Oct 27, 2014 at 12:56:57PM +0900, Simon Horman wrote:
> On Thu, Oct 23, 2014 at 01:18:54PM +0200, Geert Uytterhoeven wrote:
> > Commit 8459293c27bcd13a ("ARM: shmobile: r8a7740: add A4S pm domain
> > support") added the A4S power domain, but forgot to hook up the GbEther
> > hardware block.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks, I have queued this up.

Sorry, my mistake, I have not queued this up as
I would like to get all the soc changes in place before
adding the board changes.

> > ---
> > v3:
> >   - No changes,
> > v2:
> >   - No changes.
> > ---
> >  arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> > index 64a68450c28a072c..735036038951868d 100644
> > --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> > +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> > @@ -1234,6 +1234,7 @@ static void __init eva_init(void)
> >  	static struct pm_domain_device domain_devices[] __initdata = {
> >  		{ "A4LC", &lcdc0_device },
> >  		{ "A4LC", &hdmi_lcdc_device },
> > +		{ "A4S",  &sh_eth_device },
> >  		{ "A3SP", &pwm_device },
> >  		{ "A3SP", &sdhi0_device },
> >  		{ "A3SP", &sh_mmcif_device },
> > -- 
> > 1.9.1
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
