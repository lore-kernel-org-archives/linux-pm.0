From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v7 04/11] ARM: mvebu: Remove the unused argument of
 set_cpu_coherent()
Date: Fri, 25 Apr 2014 20:13:46 -0400
Message-ID: <20140426001346.GH28159@titan.lakedaemon.net>
References: <1397488214-20685-1-git-send-email-gregory.clement@free-electrons.com>
 <1397488214-20685-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbaDZAOG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 20:14:06 -0400
Content-Disposition: inline
In-Reply-To: <1397488214-20685-5-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-kernel@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Mon, Apr 14, 2014 at 05:10:07PM +0200, Gregory CLEMENT wrote:
> set_cpu_coherent() took the SMP group ID as parameter. But this
> parameter was never used, and the CPU always uses the SMP group 0. So
> we can remove this parameter.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c | 4 ++--
>  arch/arm/mach-mvebu/coherency.h | 2 +-
>  arch/arm/mach-mvebu/platsmp.c   | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Thomas' work

https://lkml.kernel.org/r/1397483228-25625-2-git-send-email-thomas.petazzoni@free-electrons.com

introduced an extra call to set_cpu_coherent() that wasn't caught by
this patch.

I've amended it as attached below.

thx,

Jason.

> diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
> index 51010dbbf7e4..ad61251f7faf 100644
> --- a/arch/arm/mach-mvebu/coherency.c
> +++ b/arch/arm/mach-mvebu/coherency.c
> @@ -46,7 +46,7 @@ static struct of_device_id of_coherency_table[] = {
>  /* Function defined in coherency_ll.S */
>  int ll_set_cpu_coherent(void);
>  
> -int set_cpu_coherent(int smp_group_id)
> +int set_cpu_coherent(void)
>  {
>  	if (!coherency_base) {
>  		pr_warn("Can't make current CPU cache coherent.\n");
> @@ -140,7 +140,7 @@ int __init coherency_init(void)
>  		sync_cache_w(&coherency_phys_base);
>  		coherency_base = of_iomap(np, 0);
>  		coherency_cpu_base = of_iomap(np, 1);
> -		set_cpu_coherent(0);
> +		set_cpu_coherent();
>  		of_node_put(np);
>  	}
>  
> diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
> index c7e5df368d98..dff16612dd93 100644
> --- a/arch/arm/mach-mvebu/coherency.h
> +++ b/arch/arm/mach-mvebu/coherency.h
> @@ -15,8 +15,8 @@
>  #define __MACH_370_XP_COHERENCY_H
>  
>  extern unsigned long coherency_phys_base;
> +int set_cpu_coherent(void);
>  
> -int set_cpu_coherent(int smp_group_id);
>  int coherency_init(void);
>  
>  #endif	/* __MACH_370_XP_COHERENCY_H */
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index a99d71a747f0..f2f1830063c8 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -102,7 +102,7 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
>  
>  	set_secondary_cpus_clock();
>  	flush_cache_all();
> -	set_cpu_coherent(0);
> +	set_cpu_coherent();
>  
>  	/*
>  	 * In order to boot the secondary CPUs we need to ensure
> -- 
> 1.8.1.2

------------->8-----------------------------

commit cfa292006fb7016fad58659d01e84a3aba488db2
Author: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date:   Mon Apr 14 17:10:07 2014 +0200

    ARM: mvebu: Remove the unused argument of set_cpu_coherent()
    
    set_cpu_coherent() took the SMP group ID as parameter. But this
    parameter was never used, and the CPU always uses the SMP group 0. So
    we can remove this parameter.
    
    Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
    Link: https://lkml.kernel.org/r/1397488214-20685-5-git-send-email-gregory.clement@free-electrons.com
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 2f7eb0e10164..0297cca32635 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -63,7 +63,7 @@ static struct of_device_id of_coherency_table[] = {
 /* Function defined in coherency_ll.S */
 int ll_set_cpu_coherent(void);
 
-int set_cpu_coherent(int smp_group_id)
+int set_cpu_coherent(void)
 {
 	if (!coherency_base) {
 		pr_warn("Can't make current CPU cache coherent.\n");
@@ -302,7 +302,7 @@ static void __init armada_370_coherency_init(struct device_node *np)
 	sync_cache_w(&coherency_phys_base);
 	coherency_base = of_iomap(np, 0);
 	coherency_cpu_base = of_iomap(np, 1);
-	set_cpu_coherent(0);
+	set_cpu_coherent();
 }
 
 static void __init armada_375_380_coherency_init(struct device_node *np)
@@ -330,7 +330,7 @@ static int coherency_type(void)
 		sync_cache_w(&coherency_phys_base);
 		coherency_base = of_iomap(np, 0);
 		coherency_cpu_base = of_iomap(np, 1);
-		set_cpu_coherent(0);
+		set_cpu_coherent();
 		of_node_put(np);
 	}
 
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index ab594a75fef3..54cb7607b526 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -15,8 +15,8 @@
 #define __MACH_370_XP_COHERENCY_H
 
 extern unsigned long coherency_phys_base;
+int set_cpu_coherent(void);
 
-int set_cpu_coherent(int smp_group_id);
 int coherency_init(void);
 int coherency_available(void);
 
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 75436c0023a8..88b976b31719 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -103,7 +103,7 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 
 	set_secondary_cpus_clock();
 	flush_cache_all();
-	set_cpu_coherent(0);
+	set_cpu_coherent();
 
 	/*
 	 * In order to boot the secondary CPUs we need to ensure
