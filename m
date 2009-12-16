From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC][PATCH 3/12] PCI / PM: Propagate wake-up enable
 for PCIe devices too
Date: Wed, 16 Dec 2009 11:19:39 -0800
Message-ID: <20091216111939.1a756377__3492.5359920182$1260991288$gmane$org@jbarnes-piketon>
References: <200911160047.46299.rjw@sisk.pl> <200911291632.44763.rjw@sisk.pl>
	<200911291635.54352.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911291635.54352.rjw@sisk.pl>
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
Cc: Oliver@smtp1.linux-foundation.org, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len@smtp1.linux-foundation.org, Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn@smtp1.linux-foundation.org, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 29 Nov 2009 16:35:54 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Having read the PM part of the PCIe 2.0 specification more carefully
> I think that it was a mistake to restrict the wake-up enable
> propagation to non-PCIe devices, because if we do not request
> control of the root ports' PME registers via OSC, PCIe PME is
> supposed to be handled by the platform, just like the non-PCIe PME.
> Even if we do that, the wake-up propagation is done to allow the
> devices to wake up the system from sleep states which involves the
> platform anyway, so it won't hurt.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-acpi.c |   10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied after fixing up conflicts related to dev->is_pcie.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
