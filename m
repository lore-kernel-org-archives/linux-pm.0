From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: ACPI and PM material for v3.15-rc1 (current queue)
Date: Fri, 21 Mar 2014 08:39:39 +0800
Message-ID: <532B8A4B.9000808@linaro.org>
References: <2611540.GrpzWjVQ7v@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2611540.GrpzWjVQ7v@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 2014=E5=B9=B403=E6=9C=8821=E6=97=A5 08:23, Rafael J. Wysocki wrote:
> Hi All,
>
> My queue for the first pull request during the upcoming 3.15 merge wi=
ndow
> contains the material below.  Following the rule that everything I se=
nd
> pull requests for should spend at least one day in linux-next, I'm no=
t
> going to add any more new commits to it at this point.
>
> Most likely, there will be more ACPI+PM pull request during the 3.15 =
cycle,
> so if I missed something, it still may be possible to get that into t=
hat
> kernel, but there has to be a good reason for it.
>
> Kind regards,
> Rafael
>
>
> ---------------
>
> Hanjun Guo (2):
>        ACPI / tables: Replace printk with pr_*
>        ACPI: Remove duplicate definitions of PREFIX

It seems that you missed some of my patches:
ACPI: Move BAD_MADT_ENTRY() to linux/acpi.h
ACPI / idle: Make idle_boot_override depend on x86 and ia64
ACPI / trivial: Fix the return value type of acpi_processor_eval_pdc()
ACPI / processor: Replace hard-coded "ACPI0007" with=20
ACPI_PROCESSOR_DEVICE_HID

I think those 4 patches can be merged in 3.15 and you already accepted =
them.

and this patch still need more acks and then you will accept it:
ACPI / processor_core: Rework _PDC related stuff to make it more=20
arch-independent

and this patch was reverted from your tree suggested by Catalin and Sud=
eep,
ACPI / processor: Introduce map_gic_id() to get apic id from MADT or=20
_MAT method

Sorry for the confusion if I missed something.

Thanks
Hanjun
