From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] thermal: spear: remove unnecessary OOM messages
Date: Wed, 7 May 2014 11:36:22 +0530
Message-ID: <CAKohpo=j7g-vJeb7=RGqBkze3i7ZdbKPL+G8HQ8muuE+uJQxJQ@mail.gmail.com>
References: <01a401cf69ba$0f1b88d0$2d529a70$%han@samsung.com>
	<01ad01cf69ba$5af198d0$10d4ca70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38093 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbaEGGGW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 May 2014 02:06:22 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so616492obc.26
        for <linux-pm@vger.kernel.org>; Tue, 06 May 2014 23:06:22 -0700 (PDT)
In-Reply-To: <01ad01cf69ba$5af198d0$10d4ca70$%han@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 7 May 2014 11:35, Jingoo Han <jg1.han@samsung.com> wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/thermal/spear_thermal.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
