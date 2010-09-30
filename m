From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] intel_idle: PCI quirk to prevent Lenovo Ideapad s10-3
	boot hang
Date: Thu, 30 Sep 2010 23:29:46 +0100
Message-ID: <20100930222946.GB23084@srcf.ucam.org>
References: <alpine.LFD.2.00.1009242122390.8641@localhost.localdomain> <20100927135735.GA856@srcf.ucam.org> <alpine.LFD.2.00.1009301810380.7033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1009301810380.7033@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux Power Management List <linux-pm@lists.osdl.org>, linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 30, 2010 at 06:14:35PM -0400, Len Brown wrote:

> we check (and clear) that bit only if the acpi tables
> tell us to do so.

Do the tables tell us to do so on this platform?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
