From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [SIL2review] [PATCH] power: reset: zx-reboot: put device node in
 zx_reboot_probe()
Date: Sun, 3 Jun 2018 09:03:08 +0000
Message-ID: <20180603090308.GA1287@osadl.at>
References: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527978125-29850-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Sebastian Reichel <sre@kernel.org>, ldv-project@linuxtesting.org, sil2review@lists.osadl.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 03, 2018 at 01:22:05AM +0300, Alexey Khoroshilov wrote:
> zx_reboot_probe() increments refcnt of zx296702-pcu device node by
> of_find_compatible_node() and leaves it undecremented on both
> successful and error paths.
>

Just wonder - if it warns on the failed case it probably should also
note if it failed in of_find_compatible_node() or not to allow
diagnosing the problem (the compatible_node score was 0) ? 

> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>

> ---
>  drivers/power/reset/zx-reboot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
> index c03e96e6a041..186901c96c01 100644
> --- a/drivers/power/reset/zx-reboot.c
> +++ b/drivers/power/reset/zx-reboot.c
> @@ -51,6 +51,7 @@ static int zx_reboot_probe(struct platform_device *pdev)
>  
>  	np = of_find_compatible_node(NULL, NULL, "zte,zx296702-pcu");
>  	pcu_base = of_iomap(np, 0);
> +	of_node_put(np);
>  	if (!pcu_base) {
>  		iounmap(base);
>  		WARN(1, "failed to map pcu_base address");
> -- 
> 2.7.4
> 
> _______________________________________________
> SIL2review mailing list
> SIL2review@lists.osadl.org
> https://lists.osadl.org/mailman/listinfo/sil2review
