From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 01/13] PCI/portdrv: Merge pcieport_if.h into portdrv.h
Date: Mon, 12 Mar 2018 00:59:53 -0700
Message-ID: <20180312075953.GA10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062199471.77693.15585860566110984931.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152062199471.77693.15585860566110984931.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 09, 2018 at 12:59:54PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pcieport_if.h contained the interfaces to register port service driver,
> e.g., pcie_port_service_register().  portdrv.h contained internal data
> structures of the port driver.
> 
> I don't think it's worth keeping those files separate, since both headers
> and their users are all inside the PCI core.
> 
> Merge pcieport_if.h directly in drivers/pci/pcie/portdrv.h and update the
> users to include that instead.

Looks good to me.  I always found the old struture rather confusing..

Reviewed-by: Christoph Hellwig <hch@lst.de>
