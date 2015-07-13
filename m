From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] x86, acpi: Handle xapic/x2apic entries in MADT
Date: Mon, 13 Jul 2015 23:22:11 +0800
Message-ID: <55A3D7A3.90609@linaro.org>
References: <1436795687-18539-1-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436795687-18539-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 07/13/2015 09:54 PM, Lukasz Anaczkowski wrote:
> This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
> previously published at https://lkml.org/lkml/2013/1/21/563.
>
> In case when BIOS is populating MADT wiht both x2apic and local apic
> entries (as per ACPI spec), kernel builds it's processor table
> in the following order: BSP, X2APIC, local APIC, resulting in
> processors on the same core are not separated by core count.

I'm confused here, I can't figure out where is the problem, could you
explain it in detail?

For me, logical CPU IDs allocated by OS will have mappings to physical
CPU IDs, what you are saying seems CPU topology problem to me.

>
> This patch fixes this behavior and resulting assignment is
> correct.
>
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
> ---
>   arch/x86/kernel/acpi/boot.c | 29 +++++++++++++-----
>   drivers/acpi/numa.c         | 28 ++++++++++++-----
>   drivers/acpi/tables.c       | 75 ++++++++++++++++++++++++++++-----------------
>   drivers/irqchip/irq-gic.c   | 15 ++++++---

Anyway, You also miss the SMP boot for ARM64 in ACPI way, which will
cause compile error on ARM64.

Thanks
Hanjun
