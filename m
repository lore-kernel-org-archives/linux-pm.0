From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Kernel: Power: main.c: Cleaned up a comment block
Date: Tue, 8 Mar 2016 10:44:53 +0100
Message-ID: <20160308094452.GA14693@amd>
References: <1457345355-20102-1-git-send-email-phil@philippeloctaux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33147 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbcCHJo4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 04:44:56 -0500
Content-Disposition: inline
In-Reply-To: <1457345355-20102-1-git-send-email-phil@philippeloctaux.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philippe Loctaux <phil@philippeloctaux.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2016-03-07 11:09:15, Philippe Loctaux wrote:
> Removed a * in the beginning of the block, and removed an unnecessary space.
> 
> Signed-off-by: Philippe Loctaux <phil@philippeloctaux.com>

NAK.

Google kerneldoc, people actually like two spaces after ., and you
should not be changing whitespace unless you update code, anyway.
								Pavel

> ---
>  kernel/power/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 2794697..d7386cb 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -288,11 +288,11 @@ static inline void pm_print_times_init(void) {}
>  
>  struct kobject *power_kobj;
>  
> -/**
> +/*
>   * state - control system sleep states.
>   *
>   * show() returns available sleep state labels, which may be "mem", "standby",
> - * "freeze" and "disk" (hibernation).  See Documentation/power/states.txt for a
> + * "freeze" and "disk" (hibernation). See Documentation/power/states.txt for a
>   * description of what they mean.
>   *
>   * store() accepts one of those strings, translates it into the proper

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
