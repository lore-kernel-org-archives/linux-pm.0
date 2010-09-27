From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3
	boot hang
Date: Mon, 27 Sep 2010 14:57:35 +0100
Message-ID: <20100927135735.GA856@srcf.ucam.org>
References: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 24, 2010 at 09:26:31PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> When the Lenovo Ideapad S10-3 is booted with HT enabled,
> it hits a boot hang in the intel_idle driver.
> 
> This occurs when entering ATM-C4 for the first time,
> unless BM_STS is first cleared.
> 
> acpi_idle doesn't see this because it first checks
> and clears BM_STS, but it would hit the same hang
> if that check were disabled.

If there's hardware that expects BM_STS to be cleared, and if we've 
previously always cleared BM_STS, shouldn't intel_idle be doing the same 
thing?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
