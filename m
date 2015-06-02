From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 7/8] dmaengine: add a driver for Intel integrated DMA
 64-bit
Date: Tue, 2 Jun 2015 18:19:03 +0530
Message-ID: <20150602124903.GR3140@localhost>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1432570172-86963-8-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150526040651.GP3140@localhost>
 <CAHp75VeCHMmYsgrb5GThCfsG_TekZjRfy+MsveAk01QDaUR8gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33495 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbbFBMru (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 08:47:50 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VeCHMmYsgrb5GThCfsG_TekZjRfy+MsveAk01QDaUR8gQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Tue, May 26, 2015 at 09:49:57AM +0300, Andy Shevchenko wrote:
> On Tue, May 26, 2015 at 7:06 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Mon, May 25, 2015 at 07:09:31PM +0300, Andy Shevchenko wrote:
> >> Intel integrated DMA (iDMA) 64-bit is a specific IP that is used as a part of
> >> LPSS devices such as HSUART or SPI. The iDMA IP is attached for private
> >> usage on each host controller independently.
> >>
> >> While it has similarities with Synopsys DesignWare DMA, the following
> >> distinctions doesn't allow to use the existing driver:
> >> - 64-bit mode with corresponding changes in Hardware Linked List data structure
> >> - many slight differences in the channel registers
> >>
> >> Moreover this driver is based on the DMA virtual channels framework that helps
> >> to make the driver cleaner and easy to understand.
> >>
> > Looking at code and iDMA controllers (if this is the same as I have used), we
> > have register compatibility with DW controller, so why new driver and why not
> > use and enhance dw driver ?
> 
> Take a look closer. There are many, like I mentioned, slight but not
> least changes in the registers, besides *64-bit mode*:
> - ctl_hi represents bytes, not items
> - 2 bytes of burst is supported (dw has no gap there)
> - shuffling bits between ctl_* and cfg_*
> - new bits with different meaning in ctl_* and cfg_*.
Yes these are the changes which I was thinking and these would impact only
calculating different values for a descriptor, so based on device probed you
cna load a specfic operation for calculating, rest of the driver code is
agnostic

> 
> Preliminary we did a patchset for dw_dmac, but above hw changes blows
> up and messes the driver code. I really would prefer to have those two
> separate
I think it should be doable and reading this patch also doesnt convince me
for that

> 
> However, the 32-bit iDMA which is used in Baytrail might be driven by dw_dmac.
Also what part here is specfic to *64* bit ?

-- 
~Vinod

