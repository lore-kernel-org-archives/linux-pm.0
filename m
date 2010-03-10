From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Q] How to tell we're using the KMS (during
	suspend/resume)	outside the graphics driver
Date: Wed, 10 Mar 2010 21:17:04 +0000
Message-ID: <20100310211704.GA29201__25269.9250741445$1268255891$gmane$org@srcf.ucam.org>
References: <201003062236.09801.rjw@sisk.pl>
	<548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
	<20100310205618.GA28628@srcf.ucam.org>
	<201003102215.26232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003102215.26232.rjw@sisk.pl>
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
Cc: Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, Pauli Nieminen <suokkos@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 10, 2010 at 10:15:26PM +0100, Rafael J. Wysocki wrote:
> On Wednesday 10 March 2010, Matthew Garrett wrote:
> > As far as the ACPI video driver goes, acpi_get_physical_pci_device() 
> > will give you something to work with.
> 
> Hmm.  Did you mean acpi_get_physical_device()?

Ah, no, acpi_get_pci_dev.

> Which acpi_device should I call that for?

The video one. acpi_video_bus_check does something very similar to check 
whether the device actually exists.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
