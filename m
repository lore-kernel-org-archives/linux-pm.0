From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 02:17:40 -0700
Message-ID: <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
References: <20190327090905.5588-1-leon@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327090905.5588-1-leon@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Romanovsky <leon@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>
Cc: Leon Romanovsky <leonro@mellanox.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> Kernel is booted with less possible CPUs (possible_cpus kernel boot
> option) than available CPUs will have prints like this:
[]
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
[]
> @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
>  	if (num_processors >= nr_cpu_ids) {
>  		int thiscpu = max + disabled_cpus;
> 
> -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> -			   "reached. Processor %d/0x%x ignored.\n",
> -			   max, thiscpu, apicid);
> +		pr_debug(
> +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> +			max, thiscpu, apicid);

2 lines please

		pr_debug("APIC: etc...",
			 max, thiscpu, ...);

And this would probably be better as

		printk(KERN_DEBUG "APIC: etc...",
		 ...)

to avoid the need to compile with DEBUG or enable
with CONFIG_DYNAMIC_DEBUG
