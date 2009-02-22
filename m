From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [RFC][PATCH 1/2] PM: Split up
	sysdev_[suspend|resume] from	device_power_[down|up]
Date: Mon, 23 Feb 2009 00:42:42 +0200
Message-ID: <20090222224242.GD4485__25003.0359755785$1235342712$gmane$org@localhost.pp.htv.fi>
References: <200902221837.49396.rjw@sisk.pl> <200902221838.51548.rjw@sisk.pl>
	<20090222205654.GC4485@localhost.pp.htv.fi>
	<alpine.LFD.2.00.0902221306090.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902221306090.3111@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 22, 2009 at 01:07:28PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 22 Feb 2009, Adrian Bunk wrote:
> > ...
> >   MODPOST 2586 modules
> > ERROR: "sysdev_resume" [arch/x86/kernel/apm.ko] undefined!
> > ERROR: "sysdev_suspend" [arch/x86/kernel/apm.ko] undefined!
> > make[2]: *** [__modpost] Error 1
> 
> Ahh. device_power_[down|up] were EXPORT_SYMBOL_GPL, so now that we've 
> split them, so must sysdev_[suspend|resume] be.
> 
> Does this fix it?


Thanks, works fine.


> 		Linus
> ---
>  drivers/base/sys.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/sys.c b/drivers/base/sys.c
> index c98c31e..ef2055e 100644
> --- a/drivers/base/sys.c
> +++ b/drivers/base/sys.c
> @@ -432,6 +432,7 @@ aux_driver:
>  	}
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(sysdev_suspend);
>  
>  
>  /**
> @@ -463,6 +464,7 @@ int sysdev_resume(void)
>  	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(sysdev_resume);
>  
>  
>  int __init system_bus_init(void)

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
