From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH V2 6/9] PCI: tegra: free resources on probe failure
Date: Wed, 29 Nov 2017 11:02:36 -0600
Message-ID: <20171129170236.GD6469@bhelgaas-glaptop.roam.corp.google.com>
References: <1511638333-22951-1-git-send-email-mmaddireddy@nvidia.com>
 <1511638333-22951-7-git-send-email-mmaddireddy@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753210AbdK2RCj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Nov 2017 12:02:39 -0500
Content-Disposition: inline
In-Reply-To: <1511638333-22951-7-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org, frowand.list@gmail.com, bhelgaas@google.com, rjw@rjwysocki.net, tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org

Please capitalize the first word of the changelog summary so it
matches the rest of your series (and the rest of drivers/pci history).

On Sun, Nov 26, 2017 at 01:02:10AM +0530, Manikanta Maddireddy wrote:
> tegra_pcie_probe() can fail in multiple instances, this patch takes care
> of freeing the resources which are allocated before probe fail.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
