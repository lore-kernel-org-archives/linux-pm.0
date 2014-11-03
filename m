From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v8 15/18] x86, irq, ACPI: Implement interface to support
 ACPI based IOAPIC hot-addition
Date: Mon, 3 Nov 2014 10:41:09 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1411031039470.5308@nanos>
References: <1414908273-7552-1-git-send-email-jiang.liu@linux.intel.com> <1414908273-7552-16-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50586 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaKCJlz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 04:41:55 -0500
In-Reply-To: <1414908273-7552-16-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Grant Likely <grant.likely@linaro.org>, Prarit Bhargava <prarit@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org

On Sun, 2 Nov 2014, Jiang Liu wrote:
> +	down_write(&acpi_ioapic_rwsem);

That wants to be acpi_ioapic_lock. Same issue in the following
patches. You fixed it up in the last patch.

Please don't resend. I folded the hunks back to the proper places
already.

Thanks,

	tglx


