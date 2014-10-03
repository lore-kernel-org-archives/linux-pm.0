From: Mark Salter <msalter@redhat.com>
Subject: Re: [RFC PATCH 07/16] c6x: support poweroff through poweroff
 handler call chain
Date: Fri, 03 Oct 2014 11:17:22 -0400
Message-ID: <1412349442.5410.14.camel@deneb.redhat.com>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
         <1412100056-15517-8-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1412100056-15517-8-git-send-email-linux@roeck-us.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Aurelien Jacquiot <a-jacquiot@ti.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2014-09-30 at 11:00 -0700, Guenter Roeck wrote:
> The kernel core now supports a poweroff handler call chain
> to remove power from the system. Call it if pm_power_off
> is set to NULL.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Acked-by: Mark Salter <msalter@redhat.com>

>  arch/c6x/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
> index 57d2ea8..ddf088e 100644
> --- a/arch/c6x/kernel/process.c
> +++ b/arch/c6x/kernel/process.c
> @@ -75,6 +75,8 @@ void machine_power_off(void)
>  {
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		do_kernel_poweroff();
>  	halt_loop();
>  }
>  
