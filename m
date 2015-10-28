From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 4/4] PM / OPP: Create separate structure for
 regulator/supplies
Date: Wed, 28 Oct 2015 14:07:39 +0530
Message-ID: <20151028083739.GG30039@ubuntu>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
 <f5b244327b168ce419b4bc94404a1aac3ca69f61.1444925400.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33451 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965107AbbJ1Ihn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 04:37:43 -0400
Received: by pabla5 with SMTP id la5so616810pab.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 01:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f5b244327b168ce419b4bc94404a1aac3ca69f61.1444925400.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On 15-10-15, 21:42, Viresh Kumar wrote:
> Support for multiple regulators will be added later, until then move
> all power-supply related information in a separate structure.
> 
> To make allocating/freeing memory for these supply structures easy,
> allocate memory for them along with opp.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c | 57 ++++++++++++++++++++++++++++---------------
>  drivers/base/power/opp/opp.h  | 29 ++++++++++++++++------
>  2 files changed, 58 insertions(+), 28 deletions(-)

Please drop this patch for now, I will get it included in the
multi-regulator series later.

-- 
viresh
