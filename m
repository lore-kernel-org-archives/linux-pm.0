From: Frans Pop <elendil@planet.nl>
Subject: Re: [2.6.30] e1000e: pci_enable_pcie_error_reporting
	failed 0xfffffffb
Date: Thu, 21 May 2009 22:00:13 +0200
Message-ID: <200905212200.14375.elendil__25535.1118547425$1242936098$gmane$org@planet.nl>
References: <200905141312.35945.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905141312.35945.elendil@planet.nl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Netdev <netdev@vger.kernel.org>
Cc: e1000-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, linux-kernel@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Frans Pop wrote:
> With 2.6.30-rc[45] I'm always seeing this error while resuming from STR
> on my HP 2510p notebook:
>
>   e1000e 0000:00:19.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
> ! e1000e 0000:00:19.0: pci_enable_pcie_error_reporting failed 0xfffffffb
>   e1000e 0000:00:19.0: setting latency timer to 64 
>   e1000e 0000:00:19.0: wake-up capability disabled by ACPI
>   e1000e 0000:00:19.0: PME# disabled
>   e1000e 0000:00:19.0: wake-up capability disabled by ACPI
>   e1000e 0000:00:19.0: PME# disabled
>   e1000e 0000:00:19.0: irq 26 for MSI/MSI-X
>
> The error only shows up during resume, not during normal boot.
>
> With 2.6.29 the error is not present. Is this something that should be
> looked into? Networking still comes up normally.

I'm still seeing this with 2.6.30-rc6. Should I just ignore it or is it an
indication of a problem/regression?

Cheers,
FJP
