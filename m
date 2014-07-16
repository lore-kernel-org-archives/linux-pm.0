From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 2/7] clk: exynos5420: Add aliases for clocks used by
 devfreq
Date: Wed, 16 Jul 2014 12:51:18 +0200
Message-ID: <53C65926.60103@samsung.com>
References: <1400779322-4410-3-git-send-email-a.kesavan@samsung.com>
 <1405449252-26226-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:13451 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbaGPKv5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 06:51:57 -0400
In-reply-to: <1405449252-26226-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

Hi Abhilash, Arun, Arjun, Andrew,

On 15.07.2014 20:34, Abhilash Kesavan wrote:
> From: "Arjun.K.V" <arjun.kv@samsung.com>
> 
> Devfreq does not support DT-based lookup of these peripheral clocks,
> so add aliases for them.
> 
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
> Signed-off-by: Arjun.K.V <arjun.kv@samsung.com>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c |   73 ++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 29 deletions(-)
> 

I'm really sorry, but no more aliases for DT-only platforms, NAK.

Best regards,
Tomasz
