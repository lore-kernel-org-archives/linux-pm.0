From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][v10] PM / hibernate: Verify the consistent of e820 memory
 map by md5 digest
Date: Mon, 19 Sep 2016 13:46:29 +0200
Message-ID: <CAJZ5v0j0Vj9DSL0PH+quZAnO5Ns3CxxC2qncM4xHmjsNWehM1A@mail.gmail.com>
References: <1473423687-4889-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473423687-4889-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 9, 2016 at 2:21 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> On some platforms, there is occasional panic triggered when trying to
> resume from hibernation, a typical panic looks like:

[cut]

> @@ -211,10 +292,15 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>   */
>  int arch_hibernation_header_restore(void *addr)
>  {
> +       bool e820_mismatch = false;

The extra local variable can be avoided if you structure the code
slightly differently.

>         struct restore_data_record *rdr = addr;
>
>         restore_jump_address = rdr->jump_address;
>         jump_address_phys = rdr->jump_address_phys;
>         restore_cr3 = rdr->cr3;
> -       return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
> +
> +       e820_mismatch = hibernation_e820_mismatch(rdr->e820_digest);

Also calling hibernation_e820_mismatch() before checking rdr->magic
may not be useful at all.

> +
> +       return (rdr->magic == RESTORE_MAGIC) ?
> +               (e820_mismatch ? -ENODEV : 0) : -EINVAL;

So what about:

if (rdr->magic != RESTORE_MAGIC)
        return -EINVAL;

if (hibernation_e820_mismatch(rdr->e820_digest))
        return -ENODEV;

return 0;


>  }
> --

Thanks,
Rafael
