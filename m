From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Q] How to tell we're using the KMS (during
 suspend/resume) outside the graphics driver
Date: Tue, 9 Mar 2010 16:16:24 +0000 (GMT)
Message-ID: <alpine.LFD.2.00.1003091613390.30952__9720.73061061582$1268174247$gmane$org@casper.infradead.org>
References: <201003062236.09801.rjw@sisk.pl>
	<68676e01003090301s5bb40d4hac1224a9658339ac@mail.gmail.com>
	<201003091234.59598.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003091234.59598.rjw@sisk.pl>
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
Cc: Luca Tettamanti <kronos.it@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, dri-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org


> > > Second, in the KMS case, we'd be able to skip the kernel VT switch, because
> > > the KMS driver uses its own framebuffer anyway.
> > >
> > > So, is there any reasonable way to check that from the outside of the graphics
> > > driver?  It should be general enough to cover the cases when there are two
> > > graphics adapters with different drivers in the system and so forth.
> > 
> > Inside the kernel? If you have a struct pci_dev you can get the
> > associated struct drm_device with pci_get_drvdata and then check the
> > KMS feature: drm_core_check_feature(dev, DRIVER_MODESET).
> 
> Yeah, I know that.
> 
> > I'm note sure how to check that a device is graphic card though :|
> 
> Well, that's the "outside of the graphics driver" part of my question. :-)

if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
	....
