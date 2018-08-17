From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] console: Add console=auto option
Date: Fri, 17 Aug 2018 10:19:47 +0200
Message-ID: <20180817081947.m425gok2ugt7tglp@pathway.suse.cz>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180816173902.18971-1-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2018-08-16 13:39:01, Prarit Bhargava wrote:
> ACPI may contain an SPCR table that defines a default system console.
> On ARM if the table is present then the SPCR console is enabled by default.
> On x86 the SPCR console is used if 'earlycon' (no parameters) is
> specified as a kernel parameter and is used only as the early console.
> To use the SPCR data as a console a user must boot with 'earlycon',
> grep logs & specify a console= kernel parameter, and then reboot again.
> 
> Add 'console=auto' that enables a firmware or hardware console, and on
> x86 enable the SPCR console if 'console=auto' is specified.

I basically like the idea. Just one or two nits below.


> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a32f2a126791..dd057224f33b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -635,6 +635,7 @@
>  
>  		hvc<n>	Use the hypervisor console device <n>. This is for
>  			both Xen and PowerPC hypervisors.
> +		auto	[X86] Enable ACPI SPCR console

The "auto" option sounds reasonable. But earlycon does exactly this
when used without no extra options. I prefer to stay consistent
with the existing earlycon behavior.


>  		If the device connected to the port is not a TTY but a braille
>  		device, prepend "brl," before the device type, for instance
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 3b20607d581b..fb2616ba3b21 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  	e820__range_add(addr, size, E820_TYPE_ACPI);
>  	e820__update_table_print();
>  }
> +
> +void __init arch_console_setup(void)
> +{
> +	acpi_parse_spcr(false, true);

Just for record. I was curious that this might be called twice
(also from acpi_boot_init(). But it looks safe after all.

The trick is in the two bool parameters. One call allows to
register/enable earlycon and ignores normal console. This other
call does exactly the opposite. I do not see any unwanted side
effects.

Best Regards,
Petr
