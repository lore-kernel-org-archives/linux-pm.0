From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V3 0/4] thermal/drivers/hisi: Add hi3660 thermal driver
 support
Date: Mon, 23 Oct 2017 09:21:59 -0700
Message-ID: <20171023162157.GA2280@localhost.localdomain>
References: <1508662475-6763-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:54720 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdJWQWC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2017 12:22:02 -0400
Content-Disposition: inline
In-Reply-To: <1508662475-6763-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sun, Oct 22, 2017 at 10:54:31AM +0200, Daniel Lezcano wrote:
> This series adds the support for the hikey960 thermal driver. The tsensor
> is almost the same than the hi6220 but with a memory shared updated by a
> Cortex-M4.
> 
> In order to handle both, the hi6220 and the hi3660, the current code should
> be prefixed with the platform name as we will add functions with the same
> purpose but slightly different. In addition, the core driver code is
> maintained untouched by using a set of ops filled at boot time.
> 
> Changelog:
> 
>  - V3 :
> 	- Fixed sparse warning about void const * mismatch assignment

Thanks for fixing this, the series is now applied.

Please have a look on my -linus branch and let me know if I missed any
patches from you guys. Feel free to [RESEND] if I missed anything.
