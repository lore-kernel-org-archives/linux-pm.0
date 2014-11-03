From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v8 15/18] x86, irq, ACPI: Implement interface to support
 ACPI based IOAPIC hot-addition
Date: Mon, 03 Nov 2014 17:51:04 +0800
Message-ID: <54575008.50307@linux.intel.com>
References: <1414908273-7552-1-git-send-email-jiang.liu@linux.intel.com> <1414908273-7552-16-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1411031039470.5308@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1411031039470.5308@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Grant Likely <grant.likely@linaro.org>, Prarit Bhargava <prarit@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2014/11/3 17:41, Thomas Gleixner wrote:
> On Sun, 2 Nov 2014, Jiang Liu wrote:
>> +	down_write(&acpi_ioapic_rwsem);
> 
> That wants to be acpi_ioapic_lock. Same issue in the following
> patches. You fixed it up in the last patch.
> 
> Please don't resend. I folded the hunks back to the proper places
> already.
Thanks, Thomas.

There's no changes for the second patch set "[Patch Part1 v3 00/20]
Prepare for enabling  hierarchy irqdomain on x86" at
https://lkml.org/lkml/2014/10/27/122.

It should apply cleanly onto this patch set, so I won't resend it.

I have also solved all issues related to interrupt remapping and
is testing new implementation for third and fourth patch sets.
Will send them out once passing all tests.

Regards!
Gerry

> 
> Thanks,
> 
> 	tglx
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
