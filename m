From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] devfreq: Add COMPILE_TEST for build coverage
Date: Wed, 29 Jun 2016 13:17:54 +0200
Message-ID: <5773AE62.90206@samsung.com>
References: <1467035939-31799-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:37921 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbcF2LSA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2016 07:18:00 -0400
In-reply-to: <1467035939-31799-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On 06/27/2016 03:58 PM, Krzysztof Kozlowski wrote:
> The SoC-specific devfreq and event drivers can be build tested on all
> architectures.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Success of compilation tested on ARM, ARM64, i386, x86_64 and powerpc
> architectures (allyesconfigs).
> ---
>  drivers/devfreq/Kconfig       | 4 ++--
>  drivers/devfreq/event/Kconfig | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Hi all,

The patchset depends "clk: Provide notifier stubs when
!COMMON_CLKclk-notify" [1] which you can get by merging clk-notify
branch of clk tree:

git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-notify

Can you pull while applying?

Best regards,
Krzysztof


[1]
https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/commit/?h=clk-notify&id=e81b87d22a8fed6bac24197972c9c394a2b92b5d

