From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / PCIe: Ask BIOS for control of all
 native services at once (v4)
Date: Wed, 28 Jul 2010 14:43:58 -0700
Message-ID: <20100728144358.5e2c12ce__3279.97375648028$1280353984$gmane$org@virtuousgeek.org>
References: <201007282323.56351.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007282323.56351.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Kenji@smtp1.linux-foundation.org, linux-pci@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 28 Jul 2010 23:23:56 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCIe port service drivers ask the BIOS, through _OSC, for control of
> the services they handle.  Unfortunately, each of them individually
> asks for control of the PCIe capability structure and if that is
> granted, some BIOSes expect that the other PCIe port services will be
> configured and handled by the kernel as well.  If that is not the
> case (eg. one of the PCIe port service drivers is not loaded), the
> BIOS may be confused and may cause the system as a whole to misbehave
> (eg. on one of such systems enabling the native PCIe PME service
> without loading the native PCIe hot-plug service driver causes a
> storm of ACPI notify requests to appear).
> 
> For this reason rework the PCIe port driver so that (1) it checks
> which native PCIe port services can be enabled, according to the
> BIOS, and (2) it requests control of all these services
> simultaneously.  In particular, this causes pcie_portdrv_probe() to
> fail if the BIOS refuses to grant control of the PCIe capability
> structure, which means that no native PCIe port services can be
> enabled for the PCIe root complex the given port belongs to.
> 
> Make it possible to override this behavior using a new command line
> switch pcie_ports= that can be set to 'auto' (ask the BIOS, the
> default), 'native' (use the PCIe native services regardless of the
> BIOS response to the control request), or 'compat' (do not use the
> PCIe native services at all).
> 
> Accordingly, rework the existing PCIe port service drivers so that
> they don't request control of the services directly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Kenji-san, are you ok with this version?  I would like to get your ack
(and ideally your tested-by) for this one since it affects
functionality you need.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
