From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 4/4] PCI: Add runtime PM support for PCIe ports
Date: Thu, 21 Apr 2016 16:12:24 +0300
Message-ID: <20160421131224.GY1725@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-5-git-send-email-mika.westerberg@linux.intel.com>
 <20160412175203.GB13637@wunner.de>
 <20160413083352.GI1714@lahna.fi.intel.com>
 <20160418143823.GA15165@wunner.de>
 <20160419123131.GE1725@lahna.fi.intel.com>
 <20160420192211.GA16093@wunner.de>
 <CAJZ5v0ic6YpYtM4cymLJ4oV2-J4CK4MxFi9-6bWNADD-QY3B6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43157 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbcDUNMa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Apr 2016 09:12:30 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ic6YpYtM4cymLJ4oV2-J4CK4MxFi9-6bWNADD-QY3B6A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qipeng Zha <qipeng.zha@intel.com>, Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>

On Wed, Apr 20, 2016 at 10:23:33PM +0200, Rafael J. Wysocki wrote:
> Breaking any systems that work today is not an option.  if that
> happens, the commit that has done that is a clear candidate for
> reverting.

Understood, thanks.

BTW, do you have any preference regarding the cut-off date?
