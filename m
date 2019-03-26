From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH -next] x86/apic: Reduce print level of CPU limit announcement
Date: Tue, 26 Mar 2019 13:29:54 +0100
Message-ID: <CAJZ5v0jbb+fEWWHdnZEKNOhUy=ZTsDMxy7Rwahp8O-jpBy-K9w@mail.gmail.com>
References: <20190326120213.28633-1-leon@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326120213.28633-1-leon@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Romanovsky <leon@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>, Leon Romanovsky <leonro@mellanox.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 26, 2019 at 1:02 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Kernel is booted with less possible CPUs (possible_cpus kernel boot
> option) than available CPUs will have prints like this:
>
> [    1.131039] APIC: NR_CPUS/possible_cpus limit of 8 reached. Processor 55/0x1f ignored.
> [    1.132228] ACPI: Unable to map lapic to logical cpu number
>
> Those warnings are printed for every not-enabled CPU and on the systems
> with large number of such CPUs, we see a lot of those prints for default
> print level.
>
> Simple conversion of those prints to be in debug level removes them
> while leaving the option to debug system.

But generally dynamic debug must be enabled in order for pr_debug()
prints to be visible which is kind of cumbersome to do via the command
line.

> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 +-
>  arch/x86/kernel/apic/apic.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 8dcbf6890714..3ef8ab89c02d 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -770,7 +770,7 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>
>         cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
>         if (cpu < 0) {
> -               pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
> +               pr_debug(PREFIX "Unable to map lapic to logical cpu number\n");

And this one is printed sometimes when something really goes wrong
which may be really hard to debug otherwise, so there is value in the
info level here.

Would it be possible to avoid printing it just in some cases?

>                 return cpu;
>         }
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index b7bcdd781651..8c2a487b5216 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
>         if (num_processors >= nr_cpu_ids) {
>                 int thiscpu = max + disabled_cpus;
>
> -               pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> -                          "reached. Processor %d/0x%x ignored.\n",
> -                          max, thiscpu, apicid);
> +               pr_debug(
> +                       "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> +                       max, thiscpu, apicid);

I completely agree with this change, though.

>
>                 disabled_cpus++;
>                 return -EINVAL;
> --
