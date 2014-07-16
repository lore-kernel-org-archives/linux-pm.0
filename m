From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v3 1/7] clk: exynos5250: add aliases for clocks used by
 devfreq
Date: Wed, 16 Jul 2014 12:50:18 +0200
Message-ID: <53C658EA.2050902@samsung.com>
References: <1400779322-4410-2-git-send-email-a.kesavan@samsung.com>
 <1405449222-26186-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:52447 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756875AbaGPKu5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 06:50:57 -0400
In-reply-to: <1405449222-26186-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, kgene.kim@samsung.com
Cc: rjw@sisk.pl, kesavan.abhilash@gmail.com, devicetree@vger.kernel.org

Hi Abhilash, Andrew,

On 15.07.2014 20:33, Abhilash Kesavan wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
> 
> Devfreq does not support DT-based lookup of these peripheral clocks,
> so add aliases for them.

I'm afraid I have to NAK this. This is going backwards. Please fix the
devfreq driver instead.

Best regards,
Tomasz
