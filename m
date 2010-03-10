From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [Q] How to tell we're using the KMS (during
	suspend/resume)	outside the graphics driver
Date: Wed, 10 Mar 2010 20:56:18 +0000
Message-ID: <20100310205618.GA28628__32281.4748892144$1268254644$gmane$org@srcf.ucam.org>
References: <201003062236.09801.rjw@sisk.pl> <201003091234.59598.rjw@sisk.pl>
	<alpine.LFD.2.00.1003091613390.30952@casper.infradead.org>
	<201003092208.28175.rjw@sisk.pl>
	<20100310055013.GC19518@linux-sh.org>
	<548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <548cdfc21003100254t5c94aca5u5cf1e9eb29215325@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pauli Nieminen <suokkos@gmail.com>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

As far as the ACPI video driver goes, acpi_get_physical_pci_device() 
will give you something to work with. For the console-switching case, I 
think the most reasonable plan is probably to add a flag to the console 
drivers to indicate whether or not they support reprogramming the 
hardware themselves, and then walk all active console drivers. There'd 
need to be a way for fb drivers to tell fbcon that they can handle it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
