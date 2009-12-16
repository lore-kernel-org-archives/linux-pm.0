From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/12] PCI / PM: Propagate wake-up enable
	for PCIe devices too
Date: Wed, 16 Dec 2009 20:28:21 +0100
Message-ID: <200912162028.21775.rjw__30202.5229823359$1260991702$gmane$org@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl> <200911291635.54352.rjw@sisk.pl>
	<20091216111939.1a756377@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091216111939.1a756377@jbarnes-piketon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 16 December 2009, Jesse Barnes wrote:
> On Sun, 29 Nov 2009 16:35:54 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Having read the PM part of the PCIe 2.0 specification more carefully
> > I think that it was a mistake to restrict the wake-up enable
> > propagation to non-PCIe devices, because if we do not request
> > control of the root ports' PME registers via OSC, PCIe PME is
> > supposed to be handled by the platform, just like the non-PCIe PME.
> > Even if we do that, the wake-up propagation is done to allow the
> > devices to wake up the system from sleep states which involves the
> > platform anyway, so it won't hurt.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/pci/pci-acpi.c |   10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Applied after fixing up conflicts related to dev->is_pcie.

Thanks!
