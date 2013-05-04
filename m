From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] Thermal: spear: Remove redundant platform_set_drvdata()
Date: Sat, 4 May 2013 11:45:18 +0530
Message-ID: <CAOh2x=mBRfdZCot4V0zA7AUHeHcLCCHbiFOkyC5-x-teaZb+mQ@mail.gmail.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
	<1367575034-18432-6-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:50775 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab3EDGPU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 May 2013 02:15:20 -0400
Received: by mail-ve0-f171.google.com with SMTP id oy12so2080066veb.16
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 23:15:19 -0700 (PDT)
In-Reply-To: <1367575034-18432-6-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>

On Fri, May 3, 2013 at 3:27 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
> ---
>  drivers/thermal/spear_thermal.c |    1 -
>  1 file changed, 1 deletion(-)

For SPEAr,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
