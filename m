From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Date: Tue, 7 May 2019 09:07:02 -0500
Message-ID: <20190507140702.GD156478@google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <0c7ed46e4a8cf4cea544a7e62c32428b31cdea4e.camel@infradead.org>
 <20190507124948.GC156478@google.com>
 <e156b09d5e83e127f9d9c5ab588a46218092d19f.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e156b09d5e83e127f9d9c5ab588a46218092d19f.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pci@vger.kernel.org, "Chocron, Jonathan" <jonnyc@amazon.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Lukas Wunner <lukas@wunner.de>, Frederick Lawler <fred@fredlawl.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 07, 2019 at 02:02:34PM +0100, David Woodhouse wrote:
> On Tue, 2019-05-07 at 07:49 -0500, Bjorn Helgaas wrote:
> > No good reason; I just screwed up.  Should be fixed in v5.2 (and marked for
> > stable):
> > 
> > https://lore.kernel.org/linux-pci/20190318160718.10925-1-jean-philippe.brucker@arm.com
> 
> Aha, thanks. And I see 'dwc: Use devm_pci_alloc_host_bridge()' in there
> too, which was the reason we were staring at it in the first place.
> 
> That's actually fixing a leak in the error path, not just simplifying
> it, and might want tagging for stable too if it's realistic that
> devm_of_pci_get_host_bridge_resources() would ever actually fail.

OK, IIUC, you're proposing this, where I added the stable tag to "dwc:
Use devm_pci_alloc_host_bridge()":

  http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=e6fdd3bf5aec

Lorenzo, just FYI, I cherry-picked remotes/lorenzo/pci/dwc to a pci/dwc
branch to add that tag.

Bjorn
