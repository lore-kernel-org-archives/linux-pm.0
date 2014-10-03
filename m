From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 05/16] arm64: support poweroff through poweroff
 handler call chain
Date: Fri, 3 Oct 2014 11:30:56 +0100
Message-ID: <20141003103056.GB14110@localhost>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-6-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412100056-15517-6-git-send-email-linux@roeck-us.net>
Sender: linux-parisc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Will Deacon <Will.Deacon@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 30, 2014 at 07:00:45PM +0100, Guenter Roeck wrote:
> The kernel core now supports a poweroff handler call chain
> to remove power from the system. Call it if pm_power_off
> is set to NULL.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 398ab05..cc0c63e 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -157,6 +157,8 @@ void machine_power_off(void)
>  	smp_send_stop();
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		do_kernel_poweroff();

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

As others already stated, I think we should eventually remove
pm_power_off entirely.

Catalin
