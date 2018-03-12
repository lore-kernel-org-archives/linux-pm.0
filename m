From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 06/13] PCI/portdrv: Remove pcie_port_bus_type link
 order dependency
Date: Mon, 12 Mar 2018 01:01:47 -0700
Message-ID: <20180312080147.GC10358@infradead.org>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062202196.77693.13201322126291517429.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152062202196.77693.13201322126291517429.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
List-Id: linux-pm@vger.kernel.org

> +	if ((driver->port_type != PCIE_ANY_PORT) &&
> +	    (driver->port_type != pci_pcie_type(pciedev->port)))

No need for the inner braces here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
