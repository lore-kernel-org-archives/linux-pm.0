From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Fri, 09 Mar 2007 15:06:30 -0800
Message-ID: <45F1E876.5090102@intel.com>
References: <20070227103021.GA2250@kernel.dk>
	<20070227103407.GA17819@elte.hu>	<20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk>	<20070301093450.GA8508@elte.hu>
	<20070302100704.GB2293@elf.ucw.cz>	<20070305084257.GA4464@mellanox.co.il>	<20070305101120.GA23032@elte.hu>
	<45ECFC5F.7000102@garzik.org>	<45ED0BBF.1050000@intel.com>
	<20070306090444.GA25409@elte.hu>	<45ED8A12.5040803@intel.com>	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>	<45EEE8CF.1060803@intel.com>
	<45EEEC2C.5090609@intel.com>
	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1649cdfas.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
List-Id: linux-pm@vger.kernel.org

Eric W. Biederman wrote:

[CHOP]

> Below is an additional set of warnings that should help debug this.
> The old code just got lucky that it triggered a warning when this happens.


I'm trying this patch together with the other 2 that you sent out a few day=
s =

ago. I'm seeing some minor issues with this and lots of bogus warnings as f=
ar as =

I can see.

If I suspend/resume and unload e1000, then reinsert e1000.ko, I immediately=
 hit =

the WARN_ON at `msi.c:516: WARN_ON(!hlist_empty(&dev->saved_cap_space));`

I'm not sure that's useful debugging information. even though saved state e=
xists =

the module has been removed, so you might want to purge the state table whe=
n the =

driver gets removed?


anyway, back to testing.

Auke

> =

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 01869b1..5113913 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -613,6 +613,7 @@ int pci_enable_msi(struct pci_dev* dev)
>  		return -EINVAL;
>  =

>  	WARN_ON(!!dev->msi_enabled);
> +	WARN_ON(!hlist_empty(&dev->saved_cap_space));
>  =

>  	/* Check whether driver already requested for MSI-X irqs */
>  	if (dev->msix_enabled) {
> @@ -638,6 +639,8 @@ void pci_disable_msi(struct pci_dev* dev)
>  	if (!dev->msi_enabled)
>  		return;
>  =

> +	WARN_ON(!hlist_empty(&dev->saved_cap_space));
> +
>  	msi_set_enable(dev, 0);
>  	pci_intx(dev, 1);		/* enable intx */
>  	dev->msi_enabled =3D 0;
> @@ -739,6 +742,7 @@ int pci_enable_msix(struct pci_dev* dev, struct msix_=
entry *entries, int nvec)
>  		}
>  	}
>  	WARN_ON(!!dev->msix_enabled);
> +	WARN_ON(!hlist_empty(&dev->saved_cap_space));
>  =

>  	/* Check whether driver already requested for MSI irq */
>     	if (dev->msi_enabled) {
> @@ -763,6 +767,8 @@ void pci_disable_msix(struct pci_dev* dev)
>  	if (!dev->msix_enabled)
>  		return;
>  =

> +	WARN_ON(!hlist_empty(&dev->saved_cap_space));
> +
>  	msix_set_enable(dev, 0);
>  	pci_intx(dev, 1);		/* enable intx */
>  	dev->msix_enabled =3D 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bd44a48..4418839 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -677,6 +677,7 @@ pci_restore_state(struct pci_dev *dev)
>  	}
>  	pci_restore_pcix_state(dev);
>  	pci_restore_msi_state(dev);
> +	WARN_ON(!hlist_empty(&dev->saved_cap_space));
>  =

>  	return 0;
>  }
