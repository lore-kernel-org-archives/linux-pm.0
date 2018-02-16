From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: cpuidle: Delete an error message for a failed memory
 allocation in arm_idle_init_cpu()
Date: Fri, 16 Feb 2018 09:03:57 +0100
Message-ID: <582de86a-d0bd-3f2d-0cbd-cf0a7ca924d8@linaro.org>
References: <7f419639-edfc-adb8-1dd2-d16b0dbfe19d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35167 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753714AbeBPIEB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Feb 2018 03:04:01 -0500
Received: by mail-wm0-f46.google.com with SMTP id x21so1530574wmh.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2018 00:04:00 -0800 (PST)
In-Reply-To: <7f419639-edfc-adb8-1dd2-d16b0dbfe19d@users.sourceforge.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 15/02/2018 16:46, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 16:40:38 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
