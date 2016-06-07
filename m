From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] cpu/hotplug: handle unbalanced hotplug
 enable/disable
Date: Tue, 7 Jun 2016 08:34:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606070832440.28031@nanos>
References: <1465279021-3299-1-git-send-email-lianwei.wang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36946 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbcFGGgQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 02:36:16 -0400
In-Reply-To: <1465279021-3299-1-git-send-email-lianwei.wang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: peterz@infradead.org, oleg@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 6 Jun 2016, Lianwei Wang wrote:
> Currently it just print a warning message but did not
> reset cpu_hotplug_disabled when the enable/disable is
> unbalanced. The unbalanced enable/disable will lead
> the cpu hotplug work abnormally.
> 
> Do nothing if an unablanced hotplug enable detected.
> 
> Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>
> ---
>  kernel/cpu.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 3e3f6e49eabb..8011b1e40523 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -245,6 +245,19 @@ void cpu_hotplug_done(void)
>  	cpuhp_lock_release();
>  }
>  
> +static void _cpu_hotplug_disable(void)

What's the purpose of this function?

> +{
> +	cpu_hotplug_disabled++;
> +}
> +
> +static void _cpu_hotplug_enable(void)

Double underscores please

> +{
> +	if (WARN(!cpu_hotplug_disabled, "Unbalanced cpu hotplug enable\n"))
> +		return;

And this want's to be a WARN_ONCE()

Thanks,

	tglx
