From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [ORLinux] [PATCH 13/16] openrisc idle: delete pm_idle
Date: Sun, 10 Feb 2013 18:31:11 +0100
Message-ID: <5117D95F.2030904@southpole.se>
References: <1360475903-30007-1-git-send-email-lenb@kernel.org> <06f69fdb400f9850337c1f23a1dabca0a2c39cbb.1360475150.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.southpole.se ([37.247.8.11]:48953 "EHLO mail.southpole.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662Ab3BJRa4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 10 Feb 2013 12:30:56 -0500
In-Reply-To: <06f69fdb400f9850337c1f23a1dabca0a2c39cbb.1360475150.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux@lists.openrisc.net

On 02/10/13 06:58, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
>
> pm_idle() on openrisc was dead code.
>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux@lists.openrisc.net
> ---
>   arch/openrisc/kernel/idle.c | 5 -----
>   1 file changed, 5 deletions(-)

Thanks, Len.  Will apply.
/Jonas

> diff --git a/arch/openrisc/kernel/idle.c b/arch/openrisc/kernel/idle.c
> index 7d618fe..5e8a3b6 100644
> --- a/arch/openrisc/kernel/idle.c
> +++ b/arch/openrisc/kernel/idle.c
> @@ -39,11 +39,6 @@
>   
>   void (*powersave) (void) = NULL;
>   
> -static inline void pm_idle(void)
> -{
> -	barrier();
> -}
> -
>   void cpu_idle(void)
>   {
>   	set_thread_flag(TIF_POLLING_NRFLAG);

