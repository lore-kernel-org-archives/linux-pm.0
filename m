From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] thermal soc changes
Date: Wed, 27 Aug 2014 09:27:19 -0400
Message-ID: <20140827132717.GA15875@developer>
References: <1408711592-8917-1-git-send-email-edubezval@gmail.com>
 <1409125313.8085.22.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:49863 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbaH0N10 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 09:27:26 -0400
Content-Disposition: inline
In-Reply-To: <1409125313.8085.22.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hello Rui,

On Wed, Aug 27, 2014 at 03:41:53PM +0800, Zhang Rui wrote:
> On Fri, 2014-08-22 at 08:46 -0400, Eduardo Valentin wrote:
> > Hello Rui,
> > 
> > Please pull these changes. Here we have three new features: IMX driver has
> > now support to i.mx6sx, the of-thermal now if aware of disabled thermal zones
> > in DT, and we shall have tracing support on thermal framework.
> > 
> > The following changes since commit 47d104ba5879790c7c91c3390b0b08399e168efe:
> > 
> >   Merge branches 'exynos-fix', 'for-rc', 'int3403-fix', 'misc', 'rcar-thermal' and 'sti-thermal' of .git into next (2014-07-22 10:13:00 +0800)
> > 
> > are available in the git repository at:
> > 
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git 
> > 
> 
> I suppose you mean
> http://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git next branch. And I've pulled those changes in your next branch.

Yes Rui. I made a mistake. 

Thanks for pulling.


> 
> thanks,

Cheers,

> rui
> > for you to fetch changes up to 3c94f17e72a7bcf689756da100b6051e535c45f4:
> > 
> >   Thermal: imx: add i.mx6sx thermal support (2014-08-09 10:29:30 -0400)
> > 
> > ----------------------------------------------------------------
> > Anson Huang (1):
> >       Thermal: imx: add i.mx6sx thermal support
> > 
> > Laxman Dewangan (1):
> >       thermal: add support to disable thermal zone from DTS
> > 
> > Punit Agrawal (3):
> >       thermal: trace: Trace temperature changes
> >       thermal: trace: Trace when a cooling device's state is updated
> >       thermal: trace: Trace when temperature is above a trip point
> > 
> >  .../devicetree/bindings/thermal/imx-thermal.txt    |  5 +-
> >  drivers/thermal/fair_share.c                       | 12 +++
> >  drivers/thermal/imx_thermal.c                      | 91 ++++++++++++++++++----
> >  drivers/thermal/of-thermal.c                       | 12 +++
> >  drivers/thermal/step_wise.c                        |  5 +-
> >  drivers/thermal/thermal_core.c                     |  7 ++
> >  include/trace/events/thermal.h                     | 83 ++++++++++++++++++++
> >  7 files changed, 200 insertions(+), 15 deletions(-)
> >  create mode 100644 include/trace/events/thermal.h
> > 
> > 
> >  BR,
> > 
> >  Eduardo Valentin
> 
> 
