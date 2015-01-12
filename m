From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 06/17] thermal: cpu_cooling: dts: Define device tree
 bindings for Exynos cpu cooling functionality
Date: Mon, 12 Jan 2015 15:09:16 +0100
Message-ID: <20150112150916.43f5b7ff@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-7-git-send-email-l.majewski@samsung.com>
 <20150102181529.GC12130@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58246 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbbALOJc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jan 2015 09:09:32 -0500
In-reply-to: <20150102181529.GC12130@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Eduardo,

> > Presented patch aims to move data necessary for correct CPU cooling
> > device configuration from exynos_tmu_data.c to device tree.  
> 
> I believe the patch title is misleading. Looks like you are changing
> something at cpu cooling, but in fact, you are changing DTS files. I
> would suggest you to use a prefix like 'arm: dts: ....'

Now this patch name is:
thermal: cpu_cooling: dts: ......

All the code in this patch adds bindings for 'thermal-zone' to map
cooling device to proper trip points.
In fact this is solely related to cpu_cooling...

>From the above, I think that the already provided convention is more
suitable and "arm: dts: cpu_cooling: thermal" seems a bit awkward for
me.

If you don't regard my justification as valid, then I will fix this.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
