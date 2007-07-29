From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6 patch] drivers/base/power/: make 2 functions
	static
Date: Sun, 29 Jul 2007 18:37:36 +0200
Message-ID: <200707291837.37244.rjw__28762.194448109$1185726569$gmane$org@sisk.pl>
References: <20070729145650.GH16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070729145650.GH16817@stusta.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 29 July 2007 16:56, Adrian Bunk wrote:
> suspend_device() and resume_device() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
 
>  drivers/base/power/power.h   |    6 ------
>  drivers/base/power/resume.c  |    2 +-
>  drivers/base/power/suspend.c |    2 +-
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> --- linux-2.6.23-rc1-mm1/drivers/base/power/power.h.old	2007-07-26 05:14:12.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/drivers/base/power/power.h	2007-07-26 05:15:49.000000000 +0200
> @@ -55,12 +55,6 @@
>  
>  extern void dpm_resume(void);
>  extern void dpm_power_up(void);
> -extern int resume_device(struct device *);
> -
> -/*
> - * suspend.c
> - */
> -extern int suspend_device(struct device *, pm_message_t);
>  
>  #else /* CONFIG_PM */
>  
> --- linux-2.6.23-rc1-mm1/drivers/base/power/resume.c.old	2007-07-26 05:14:28.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/drivers/base/power/resume.c	2007-07-26 05:14:39.000000000 +0200
> @@ -20,7 +20,7 @@
>   *
>   */
>  
> -int resume_device(struct device * dev)
> +static int resume_device(struct device * dev)
>  {
>  	int error = 0;
>  
> --- linux-2.6.23-rc1-mm1/drivers/base/power/suspend.c.old	2007-07-26 05:16:00.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/drivers/base/power/suspend.c	2007-07-26 05:16:17.000000000 +0200
> @@ -54,7 +54,7 @@
>   *	@state:	Power state device is entering.
>   */
>  
> -int suspend_device(struct device * dev, pm_message_t state)
> +static int suspend_device(struct device * dev, pm_message_t state)
>  {
>  	int error = 0;
>  
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
