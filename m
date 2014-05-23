From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH RFC v2 0/7] Devfreq support for Exynos5250/5420
Date: Fri, 23 May 2014 14:08:17 +0900
Message-ID: <537ED7C1.5030601@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:13795 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbaEWFIc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 01:08:32 -0400
In-reply-to: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, t.figa@samsung.com, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, kesavan.abhilash@gmail.com

Hi,

On 05/23/2014 02:21 AM, Abhilash Kesavan wrote:
> This patchset adds devfreq support on Exynos5250 and Exynos5420.
> The patches add the missing INT clock support for exynos5250 and
> also add a new 5420 driver. We also have patches which add the
> PPMU node and fix a typo in the exynos5250 driver.
> 
> Changes since RFC v1:
> 	- Exynos5420 support has been added to the existent Exynos5250
> 	  driver itself.
> 	- Rebased on Chanwoo Choi's devfreq consolidation patchset.
> 	- Removed unused clocks from the clock list
> 	- Used the PPMU nodes with different compatible strings to
> 	  differentiate between exynos5250 and exynos5420.
> 
> The patches have been tested on Exynos5250 based Snow board and Exynos5420
> based Peach-Pit boards. They have been prepared on linux-next(20140521) with
> the devfreq for-next branch merged. Also applied is the "devfreq resource
> management" series from Chanwoo Choi[1].
> [1] https://lkml.org/lkml/2014/4/25/826

I sent v2 patchset as following after fixed minor issue:
[PATCHv2 0/5] devfreq: Support resource management functions and code clean
- https://lkml.org/lkml/2014/5/9/74

Best Regards,
Chanwoo Choi
