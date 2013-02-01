From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4] davinci: cpuidle - some cleanups
Date: Fri, 01 Feb 2013 13:49:50 -0500
Message-ID: <510C0E4E.3010008@kernel.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:58964 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab3BASt6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 13:49:58 -0500
Received: by mail-vb0-f42.google.com with SMTP id ff1so2657828vbb.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Feb 2013 10:49:58 -0800 (PST)
In-Reply-To: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: nsekhar@ti.com, khilman@ti.com, patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, linux-pm@vger.kernel.org

On 02/01/2013 08:48 AM, Daniel Lezcano wrote:
> This patchset does some cleanup. It could have been folded in a single
> patch but the review would have been less clean than splitting it into
> small and trivial patches.
> 
> The main purpose of this patch is to remove the usage of the driver_data
> field from the state_usage structure. Len Brown is doing this cleanup in
> the intel_idle.c file. With this patchset, the processor_idle.c file will
> be the last user of this field.

Daniel,
Thanks for this cleanup.
Hopefully we can hear from somebody with davinci HW who can test it?

Looks like it is now up to me to address processor_idle.c and
finish the job of expunging driver_data.

thanks,
-Len Brown

Intel Open Source Technology Center


> 
> Also, the patchset simplify the code and makes it a bit more clear to read.
> 
> I don't have this hardware, the code is not tested.
> 
> Daniel Lezcano (4):
>   davinci: cpuidle - use global variable for ddr2 flag
>   davinci: cpuidle - move code to prevent forward declaration
>   davinci: cpuidle - remove the ops
>   davinci: cpuidle - remove useless initialization
> 
>  arch/arm/mach-davinci/cpuidle.c |   84 ++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 59 deletions(-)
> 

