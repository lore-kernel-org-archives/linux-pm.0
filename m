From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [GIT PULL] Thermal Management updates for 3.20-rc1 #2
Date: Fri, 20 Feb 2015 12:04:16 +0100
Message-ID: <20150220120416.733809a4@amdc2363>
References: <1424396210.2885.25.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61462 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbbBTLEZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Feb 2015 06:04:25 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NK200IGDHFBYC40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 20 Feb 2015 20:04:23 +0900 (KST)
In-reply-to: <1424396210.2885.25.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Zhang, Eduardo

Sorry to interrupt, but I've got very urgent request.

> Hi, Linus,
> 
> Please pull from
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> fixes
> 
> to receive Thermal SoC Management updates for v3.20 with top-most
> 
> 6c247393cfdd6695717f80ff31f9fd9af8c2c525:
> 
>   thermal: exynos: Add TMU support for Exynos7 SoC (2015-01-31
> 15:20:45 -0400)
> 
> on top of commit b97f880c8342fd6e49a02c9ef7507a678722b2b3:
> 
>   Merge branch 'for-3.19-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata (2015-01-21
> 07:54:16 +1200)
> 
> Specifics:
> 
> - Exynos thermal driver refactoring. Several cleanups, code
> optimization, unused symbols removal, and unused feature removal in
> Exynos thermal driver. Thanks Lukasz for this effort.
> - Exynos thermal driver support to OF thermal. After the code
> refactoring, the driver earned the support to OF thermal. Chip thermal
> data were moved from driver code to DTS, reducing the code footprint.
> Thanks Lukasz for this.
> - After receiving the OF thermal support, the exynos thermal driver
> now must allow modular build. Thanks Arnd for detecting, reporting and
> fixing this.
> - Exynos thermal driver support to Exynos 7 SoC. Thanks Abhilash for
> this.
> - Accurate temperature reporting on Rockchip thermal driver, thanks to
> Caesar.
> - Fix on how OF thermal enables its zones, thanks Lukasz for fixing.
> - Fixes in OF thermal examples under Documentation/. Thanks Srinivas
> for fixing.
> 

Zang, Eduardo, could you help me with getting this patch:

[PATCH] thermal: exynos: fix: Check if data->tmu_read callback is
present before read

merged to v3.20-rc1/v4.0-rc1 tree ASAP? It has been on the ML for two
weeks now and is ACK'ed and Tested by Abhilash, who initially
discovered this problem.

Without it all Exynos SoCs will break at boot time. 


Thanks in advance.


> Thanks,
> rui



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
