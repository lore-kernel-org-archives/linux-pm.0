From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Thermal] Need confirmation for the pending thermal soc patches
Date: Wed, 07 Sep 2016 08:25:49 +0800
Message-ID: <1473207949.2307.1.camel@intel.com>
References: <1471788540.2188.19.camel@intel.com>
         <20160905131600.GA24253@localhost.localdomain>
         <CAMuHMdVxCyy+ULdnzWTBFuCrP4E77H7JxS25QL_RSeOgtV5bVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9591 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934617AbcIGA0I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Sep 2016 20:26:08 -0400
In-Reply-To: <CAMuHMdVxCyy+ULdnzWTBFuCrP4E77H7JxS25QL_RSeOgtV5bVQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>

On 二, 2016-09-06 at 12:13 +0200, Geert Uytterhoeven wrote:
> Hi Eduardo,
> 
> On Mon, Sep 5, 2016 at 3:16 PM, Eduardo Valentin <edubezval@gmail.com
> > wrote:
> > 
> > On Sun, Aug 21, 2016 at 10:09:00PM +0800, Zhang Rui wrote:
> > > 
> > > As Eduardo is quite busy recently, I will take all the thermal
> > > soc
> > > driver changes this time.
> > Thanks for helping me out. I am slowing coming back to upstream
> > activities. I have refreshed my branches, removing the rework and
> > locking patches works out of the integration branches so we do not
> > have
> > merge conflicts or further delays on outstanding patches.
> > 
> > > 
> > > Currently, I have cherry picked all the patches that Eduardo has
> > > already applied in thermal-soc tree and reviewed all the pending
> > Great! This makes things easier for me.
> > 
> > > 
> > > patches in patchwork. Now, there are four patches queued for next
> > > -rc (
> > > https://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/log
> > > /?h=fo
> > > r-rc),
> > I checked this branch. Can you please cherry-pick the following
> > patch
> > for rc:
> > https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-
> > thermal.git/commit/?h=linus&id=4ba16f1256bd13efa2f3179ff1f4ab16a4ad
> > 3c7f

> That patch is indeed missing.
> 
> While preparing today's renesas-drivers release, I noticed it had
> disappeared
> from thermal-soc/next. Then I found your email...
> 
> Thanks for re-applying it!
> 

Applied and queued for next -rc.

thanks,
rui

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu
> x-m68k.org
> 
> In personal conversations with technical people, I call myself a
> hacker. But
> when I'm talking to journalists I just say "programmer" or something
> like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
