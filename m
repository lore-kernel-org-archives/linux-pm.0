From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] console: Add console=spcr option
Date: Thu, 30 Aug 2018 16:26:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1808301542560.1210@nanos.tec.linutronix.de>
References: <20180829155618.32359-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829155618.32359-1-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Aug 2018, Prarit Bhargava wrote:
> +
> +void __init arch_console_setup(void)
> +{
> +	int ret;
> +
> +	ret = acpi_parse_spcr(false, true);
> +	if (ret)
> +		pr_err(PREFIX "ERROR: SPCR console is not enabled (%d)\n", ret);
> +}

Why does this require yet another arch/weak function?

>  /*
>   * Set up a console.  Called via do_early_param() in init/main.c
>   * for each "console=" parameter in the boot command line.
> @@ -2107,6 +2112,11 @@ static int __init console_setup(char *str)
>  	char *s, *options, *brl_options = NULL;
>  	int idx;
>  
> +	if (!strcmp(str, "spcr")) {
> +		arch_console_setup();
> +		return 1;

And this gets added to everything and the world whether it's
needed/supported or not.

Why can't we simply register the SPCR console as we do with any other
console when it is detected?

If we can't for some real good reason then there is no need to invoke
acpi_parse_spcr() twice. We simply can store the fact that it got selected
and use that information in acpi_boot_init().

Thanks,

	tglx
