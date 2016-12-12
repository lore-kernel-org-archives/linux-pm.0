From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Mon, 12 Dec 2016 10:39:15 -0800
Message-ID: <1481567955.1764.28.camel@perches.com>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
         <20161212085620.GA738@amd> <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <nick.desaulniers@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-12-12 at 09:56 -0800, Nick Desaulniers wrote:
> A quick cleanup that passes scripts/checkpatch.pl -f <file>.

You might use the --strict option for acpi files.

> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
[]
> @@ -103,9 +103,8 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
>  
>         if (!mwait_supported[cstate_type]) {
>                 mwait_supported[cstate_type] = 1;
> -               printk(KERN_DEBUG
> -                       "Monitor-Mwait will be used to enter C-%d "
> -                       "state\n", cx->type);
> +               pr_debug("Monitor-Mwait will be used to enter C-%d state\n",
> +                               cx->type);

It's generally better not to convert
these printk(KERN_DEBUG uses.

There are behavior differences between
	printk(KERN_DEBUG ...);
and
	pr_debug(...);

The first will always be emitted as long
as the console level is appropriate.

The second depends on a #define DEBUG
before it gets emitted or a kernel
with CONFIG_DYNAMIC_DEBUG enabled and
this entry specifically enabled in the
control file.
