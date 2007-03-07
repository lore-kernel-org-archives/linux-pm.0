From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Wed, 07 Mar 2007 12:28:11 -0700
Message-ID: <m1649cdfas.fsf@ebiederm.dsl.xmission.com>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu> <45ECFC5F.7000102@garzik.org>
	<45ED0BBF.1050000@intel.com> <20070306090444.GA25409@elte.hu>
	<45ED8A12.5040803@intel.com>
	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>
	<45EEE8CF.1060803@intel.com> <45EEEC2C.5090609@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45EEEC2C.5090609@intel.com> (Auke Kok's message of "Wed, 07 Mar
	2007 08:45:32 -0800")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Kok, Auke" <auke-jan.h.kok@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org

"Kok, Auke" <auke-jan.h.kok@intel.com> writes:

> Kok, Auke wrote:
>> Eric W. Biederman wrote:

>>> This leaves with some basic questions.
>>> - Does it make sense for suspend/resume methods to request/free irqs?
>>> - Does it make sense for suspend/resume methods to allocate/free msi ir=
qs?
>>> - Do we want pci_save/restore_cap to save/restore msi state?
>>>
>>> The path of least resistance is to just free the extra state and we
>>> are good.  I'm just not quite certain that is sane and it has been a
>>> long day.
>>
>> we used to have a lengthy e1000_pci_save|restore_state in our code, whic=
h is
>> now gone, so I'm all for that. A separate pci_save_pxie|msi(x)_state for=
 every
>> driver seems completely unnecessary. I can't think of a use case where
>> saving+restoring everything hurts. That's what you want I presume.

I just want to understand why we have issues and to see if how we have
organized the suspend/resume path for dealing with msi irqs makes sense.

That is I haven't looked much at the suspend/resume path so I don't know it
well and I am afraid that your problem might be a symptom of a deeper
problem.

>> We currently free all irq's and msi before going into suspend in e1000, =
and I
>> think that is probably a good thing, somehow I can think of bad things
>> happening if we dont, but I admit that I haven't tried it without
>> alloc/free. We do this in e100 as well and it works.

Currently the irq code supports operation without the
free_irq/request_irq.  Since the numbers given are pure linux
abstractions things should it is really a matter of just
saving/restoring the appropriate state.

>> Another motivation would be to leave this up to the driver: if the driver
>> chooses to free/alloc interrupts because it makes sense, you probably wo=
uld
>> want to keep that choice available. Devices that don't need this can ski=
p the
>> alloc/free, but leave the choice open for others.
>
> ah, looking at the code in e1000 we do:
>
> _suspend:
> 	pci_save_state();
> 	free_irq()
>
> _resume:
> 	pci_restore_state();
> 	alloc_irq();
>
> I suppose that's not good either, and the major cause of the warning in t=
he
> first place.

Yep. =


> Maybe I can rollback your latest patches and try to fix that mess by post=
poning
> the pci_save_state until after we free'd the irq's.

Below is an additional set of warnings that should help debug this.
The old code just got lucky that it triggered a warning when this happens.

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 01869b1..5113913 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -613,6 +613,7 @@ int pci_enable_msi(struct pci_dev* dev)
 		return -EINVAL;
 =

 	WARN_ON(!!dev->msi_enabled);
+	WARN_ON(!hlist_empty(&dev->saved_cap_space));
 =

 	/* Check whether driver already requested for MSI-X irqs */
 	if (dev->msix_enabled) {
@@ -638,6 +639,8 @@ void pci_disable_msi(struct pci_dev* dev)
 	if (!dev->msi_enabled)
 		return;
 =

+	WARN_ON(!hlist_empty(&dev->saved_cap_space));
+
 	msi_set_enable(dev, 0);
 	pci_intx(dev, 1);		/* enable intx */
 	dev->msi_enabled =3D 0;
@@ -739,6 +742,7 @@ int pci_enable_msix(struct pci_dev* dev, struct msix_en=
try *entries, int nvec)
 		}
 	}
 	WARN_ON(!!dev->msix_enabled);
+	WARN_ON(!hlist_empty(&dev->saved_cap_space));
 =

 	/* Check whether driver already requested for MSI irq */
    	if (dev->msi_enabled) {
@@ -763,6 +767,8 @@ void pci_disable_msix(struct pci_dev* dev)
 	if (!dev->msix_enabled)
 		return;
 =

+	WARN_ON(!hlist_empty(&dev->saved_cap_space));
+
 	msix_set_enable(dev, 0);
 	pci_intx(dev, 1);		/* enable intx */
 	dev->msix_enabled =3D 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bd44a48..4418839 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -677,6 +677,7 @@ pci_restore_state(struct pci_dev *dev)
 	}
 	pci_restore_pcix_state(dev);
 	pci_restore_msi_state(dev);
+	WARN_ON(!hlist_empty(&dev->saved_cap_space));
 =

 	return 0;
 }
