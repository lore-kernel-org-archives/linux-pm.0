From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: make _of_get_opp_desc_node a static function
Date: Thu, 20 Oct 2016 12:29:04 +0530
Message-ID: <20161020065904.GL11766@vireshk-i7>
References: <1476945893-26998-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34355 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753195AbcJTG7I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 02:59:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id r16so30818111pfg.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 23:59:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1476945893-26998-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 20-10-16, 15:44, Masahiro Yamada wrote:
> Since commit f47b72a15a96 ("PM / OPP: Move CONFIG_OF dependent code
> in a separate file"), this function is defined and called only in
> drivers/base/power/opp/of.c .
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/base/power/opp/of.c  | 2 +-
>  drivers/base/power/opp/opp.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
