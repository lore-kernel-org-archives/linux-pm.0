From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] Thermal: spear: Remove redundant use of of_match_ptr
Date: Thu, 16 May 2013 16:12:35 +0530
Message-ID: <CAKohpo=J-NVjRRSZ+C5LAwcgJixpd=RVYgo_LfM=GQYK=FEDBg@mail.gmail.com>
References: <1368700091-6084-1-git-send-email-sachin.kamat@linaro.org>
	<1368700091-6084-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63768 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763Ab3EPKmg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 06:42:36 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so3524239oag.33
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 03:42:35 -0700 (PDT)
In-Reply-To: <1368700091-6084-4-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org, Vincenzo Frascino <vincenzo.frascino@st.com>

On 16 May 2013 15:58, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'spear_thermal_id_table' is always compiled in and the driver
> is dependent on OF. Hence use of of_match_ptr is unnecessary.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/spear_thermal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
