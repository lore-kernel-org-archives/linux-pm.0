From: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>
Subject: RE: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Tue, 14 Jul 2015 11:17:36 +0000
Message-ID: <C1C2579D7BE026428F81F41198ADB1723780EB27@irsmsx110.ger.corp.intel.com>
References: <55A3D7A3.90609@linaro.org>
 <1436861209-4047-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1436861209-4047-2-git-send-email-lukasz.anaczkowski@intel.com>
 <55A4C7B2.7040707@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55A4C7B2.7040707@linux.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> I have some concerns here about "maxcpus" and "nox2apic" kernel parameters. Say "maxcpus=72 nox2apic" is specified, user may get less than 72 CPUs with you patch applied. Original code will try to only all xapic CPUs before trying x2apic CPUs, so "maxcpus" doesn't conflict with "nox2apic".

HI Gerry,

'nox2apic' is causing kernel panics with and w/o my patch.
Here's the stack trace:

#0  panic (fmt=0xffffffff818043c8 "timer doesn't work through Interrupt-remapped IO-APIC") at kernel/panic.c:72
#1  0xffffffff813df48c in panic_if_irq_remap (msg=<optimized out>) at drivers/iommu/irq_remapping.c:152
#2  0xffffffff81b5a705 in check_timer () at arch/x86/kernel/apic/io_apic.c:2124
#3  0xffffffff81b5afa3 in setup_IO_APIC () at arch/x86/kernel/apic/io_apic.c:2278
#4  0xffffffff81b59655 in apic_bsp_setup (upmode=<optimized out>) at arch/x86/kernel/apic/apic.c:2184
#5  0xffffffff81b57370 in native_smp_prepare_cpus (max_cpus=<optimized out>) at arch/x86/kernel/smpboot.c:1201
#6  0xffffffff81b49182 in smp_prepare_cpus (max_cpus=<optimized out>) at ./arch/x86/include/asm/smp.h:99
#7  kernel_init_freeable () at init/main.c:999
#8  0xffffffff8155c64e in kernel_init (unused=<optimized out>) at init/main.c:937
#9  0xffffffff8156f51f in ret_from_fork () at arch/x86/entry/entry_64.S:526
#10 0x0000000000000000 in ?? ()

On HSW i7-4770, I'm getting 8 CPUs booted, regardless of the 'nox2apic' setting w/ my patch.

Cheers,
Lukasz
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

