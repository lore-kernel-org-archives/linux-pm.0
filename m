From: "myungjoo.ham" <myungjoo.ham@samsung.com>
Subject: RE: [PATCH v4 4/4] PM: Devfreq: Add Exynos5-bus devfreq driver for
 Exynos5250
Date: Mon, 04 Feb 2013 15:41:04 +0900
Message-ID: <006201ce02a2$9ae72480$d0b56d80$@samsung.com>
References: <1357733199-17206-4-git-send-email-a.kesavan@samsung.com>
 <1358515490-7565-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voakyRiC6nvNv63nK3H3T168MjP-JevbCuksoKbpT=HQqJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19145 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3BDGlH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 01:41:07 -0500
In-reply-to: <CAM4voakyRiC6nvNv63nK3H3T168MjP-JevbCuksoKbpT=HQqJw@mail.gmail.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Abhilash Kesavan' <kesavan.abhilash@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: kyungmin.park@samsung.com, rjw@sisk.pl, jhbird.choi@samsung.com

> 
> 
> -----Original Message-----
> From: Abhilash Kesavan [mailto:kesavan.abhilash@gmail.com] 
> Sent: Monday, February 04, 2013 12:48 AM
> To: myungjoo.ham@samsung.com; linux-kernel@vger.kernel.org;
linux-pm@vger.kernel.org; kgene.kim@samsung.com
> Cc: kyungmin.park@samsung.com; rjw@sisk.pl; jhbird.choi@samsung.com
> Subject: Re: [PATCH v4 4/4] PM: Devfreq: Add Exynos5-bus devfreq driver
for Exynos5250
> 
> Hi Myungjoo,
> 
> Any comments on this patch ?
> 
> Abhilash
> 


Sorry for being late.

One concern is that I cannot apply Patch 1/4 directly as the .dts file isn't
available to me.
Do you intend to apply that patch to another tree and apply the other three
to devfreq tree?

Another is the location of exynos_ppmu.h.
Who is going to refer exynos_ppmu.h?
If Exynos devfreq drivers are the only files to refer, wouldn't it be better
located at drivers/devfreq/exynos/ ?

Or do you intend to let someone else (drivers located not in
drivers/devfreq) access exynos-ppmu?
(If so, who's going to be? and that means we are going to have
include/linux/devfreq/, I don't think it'd be appropriate to populate
include/linux with device driver specific headers)



And, there are errors (we do not have __devinit/__devexit anymore):

  CC      drivers/devfreq/exynos/exynos5_bus.o
drivers/devfreq/exynos/exynos5_bus.c:315:18: error: expected =, ,, ;, asm or
__attribute__ before int
drivers/devfreq/exynos/exynos5_bus.c:430:18: error: expected =, ,, ;, asm or
__attribute__ before int
drivers/devfreq/exynos/exynos5_bus.c:462:11: error:
exynos5_busfreq_int_probe undeclared here (not in a function)
drivers/devfreq/exynos/exynos5_bus.c:463:2: error: implicit declaration of
function __devexit_p [-Werror=implicit-function-declaration]
drivers/devfreq/exynos/exynos5_bus.c:463:24: error:
exynos5_busfreq_int_remove undeclared here (not in a function)
drivers/devfreq/exynos/exynos5_bus.c:235:35: warning:
exynos5_devfreq_int_profile defined but not used [-Wunused-variable]
drivers/devfreq/exynos/exynos5_bus.c:243:12: warning:
exynos5250_init_int_tables defined but not used [-Wunused-function]
drivers/devfreq/exynos/exynos5_bus.c:259:12: warning:
exynos5_busfreq_int_pm_notifier_event defined but not used
[-Wunused-function]
cc1: some warnings being treated as errors



Cheers,
MyungJoo.


> On Fri, Jan 18, 2013 at 6:54 PM, Abhilash Kesavan <a.kesavan@samsung.com>
wrote:
> > Exynos5-bus device devfreq driver monitors PPMU counters and adjusts 
> > operating frequencies and voltages with OPP. ASV should be used to 
> > provide appropriate voltages as per the speed group of the SoC rather 
> > than using a constant 1.025V.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Cc: Jonghwan Choi <jhbird.choi@samsung.com>
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > Changes since RFC v1:
> > * Moved the Exynos5 PPMU driver to machine specific directory
> > * Migrated to the PM QOS framework
> > Changes since v2:
> > * Moved the PPMU driver to drivers/devfreq/exynos
> > * Fixed whitespace, commenting, empty lines in PPMU driver Changes 
> > since v3:
> > * Removed the custom devfreq monitor and PPMU polling function
> > * Moved exynos5 PPMU access functions to the devfreq driver
> >
> >  drivers/devfreq/Kconfig              |   10 +
> >  drivers/devfreq/Makefile             |    1 +
> >  drivers/devfreq/exynos/Makefile      |    1 +
> >  drivers/devfreq/exynos/exynos5_bus.c |  502
++++++++++++++++++++++++++++++++++
> >  drivers/devfreq/exynos/exynos_ppmu.c |   55 ++++
> >  include/linux/exynos_ppmu.h          |   79 ++++++
> >  6 files changed, 648 insertions(+), 0 deletions(-)  create mode 
> > 100644 drivers/devfreq/exynos/exynos5_bus.c
> >  create mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
> >  create mode 100644 include/linux/exynos_ppmu.h
> >

