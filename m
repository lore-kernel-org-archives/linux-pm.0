From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 02:49:02 -0700
Message-ID: <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
References: <20190327090905.5588-1-leon@kernel.org>
         <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
         <20190327093844.GO22899@mtr-leonro.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327093844.GO22899@mtr-leonro.mtl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Romanovsky <leon@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-03-27 at 11:38 +0200, Leon Romanovsky wrote:
> On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> > On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > option) than available CPUs will have prints like this:
> > []
> > > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > []
> > > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> > >  	if (num_processors >= nr_cpu_ids) {
> > >  		int thiscpu = max + disabled_cpus;
> > > 
> > > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > > -			   "reached. Processor %d/0x%x ignored.\n",
> > > -			   max, thiscpu, apicid);
> > > +		pr_debug(
> > > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > +			max, thiscpu, apicid);
> > 
> > 2 lines please
> > 
> > 		pr_debug("APIC: etc...",
> > 			 max, thiscpu, ...);
> 
> It was two lines before, but I changed for two reasons:
>  * It helped me to grep the source code to find the origin of dmesg warning.
>  * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?

Yes, use

	pr_debug("APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
		 max, thiscpu, apicid);

or better

	printk(KERN_DEBUG "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
	       max, thiscpu, apicid);

> > And this would probably be better as
> > 
> > 		printk(KERN_DEBUG "APIC: etc...",
> > 		 ...)
> > 
> > to avoid the need to compile with DEBUG or enable
> > with CONFIG_DYNAMIC_DEBUG
> 
> You don't need anything like this, just provide dyndbg parameters
> through kernel command line.

That assumes CONFIG_DYNAMIC_DEBUG is always enabled,
and it is not enabled in many .config files.
