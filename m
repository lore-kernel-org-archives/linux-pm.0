From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Q] How to tell we're using the KMS (during
	suspend/resume) outside the graphics driver
Date: Wed, 10 Mar 2010 22:15:26 +0100
Message-ID: <201003102215.26232.rjw__48372.0011929565$1268255598$gmane$org@sisk.pl>
References: <201003062236.09801.rjw@sisk.pl>
	<548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
	<20100310205618.GA28628@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100310205618.GA28628@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, Pauli Nieminen <suokkos@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 March 2010, Matthew Garrett wrote:
> As far as the ACPI video driver goes, acpi_get_physical_pci_device() 
> will give you something to work with.

Hmm.  Did you mean acpi_get_physical_device()?

Which acpi_device should I call that for?

> For the console-switching case, I think the most reasonable plan is probably
> to add a flag to the console drivers to indicate whether or not they support
> reprogramming the hardware themselves, and then walk all active console
> drivers. There'd need to be a way for fb drivers to tell fbcon that they can
> handle it.

Yes, that sounds reasonable.

Rafael
