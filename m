From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: [PATCH 2/2] pci: Repair pci_save/restore_state so we
 can restore one save many times.
Date: Mon, 12 Mar 2007 15:46:44 -0700
Message-ID: <45F5D854.5020100@intel.com>
References: <20070227103021.GA2250@kernel.dk>	<20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk>	<20070301093450.GA8508@elte.hu>
	<20070302100704.GB2293@elf.ucw.cz>	<20070305084257.GA4464@mellanox.co.il>	<20070305101120.GA23032@elte.hu>
	<45ECFC5F.7000102@garzik.org>	<45ED0BBF.1050000@intel.com>
	<20070306090444.GA25409@elte.hu>	<45ED8A12.5040803@intel.com>	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>	<45EEE8CF.1060803@intel.com>
	<45EEEC2C.5090609@intel.com>	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>	<20070307185317.5601d452.akpm@linux-foundation.org>	<m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>	<45EFDD8C.3070702@garzik.org>	<m1abyn7iin.fsf@ebiederm.dsl.xmission.com>	<m1tzwv5wz9.fsf_-_@ebiederm.dsl.xmission.com>	<m1ps7j5wnq.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lki75wlm.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1lki75wlm.fsf_-_@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, michael@ellerman.id.au, linux-pci@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Eric W. Biederman wrote:
> Because we do not reserve space for the pci-x and pci-e state in struct
> pci dev we need to dynamically allocate it.  However because we need
> to support restore being called multiple times after a single save
> it is never safe to free the buffers we have allocated to hold the
> state.
> =

> So this patch modifies the save routines to first check to see
> if we have already allocated a state buffer before allocating
> a new one.  Then the restore routines are modified to not free
> the state after restoring it.  Simple and it fixes some subtle
> error path handling bugs, that are hard to test for.
> =

> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


I tested this patch and the other 2 in this series:

[PATCH 0/2] Repair pci_restore_state when used with device resets
[PATCH 1/2] msi: Safer state caching.

against e1000 with suspend/resume functionality. Apart from a minor symmetr=
y =

violation in e1000 for which I will send a patch later, these patches appea=
r to =

work fine on my ich8 with 5 msi capable e1000 ports.

Feel free to add my Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

Cheers,

Auke



> ---
>  drivers/pci/pci.c   |   12 ++++++------
>  include/linux/pci.h |    5 -----
>  2 files changed, 6 insertions(+), 11 deletions(-)
> =

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6fb78df..b292c9a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -551,7 +551,9 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	if (pos <=3D 0)
>  		return 0;
>  =

> -	save_state =3D kzalloc(sizeof(*save_state) + sizeof(u16) * 4, GFP_KERNE=
L);
> +	save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		save_state =3D kzalloc(sizeof(*save_state) + sizeof(u16) * 4, GFP_KERN=
EL);
>  	if (!save_state) {
>  		dev_err(&dev->dev, "Out of memory in pci_save_pcie_state\n");
>  		return -ENOMEM;
> @@ -582,8 +584,6 @@ static void pci_restore_pcie_state(struct pci_dev *de=
v)
>  	pci_write_config_word(dev, pos + PCI_EXP_LNKCTL, cap[i++]);
>  	pci_write_config_word(dev, pos + PCI_EXP_SLTCTL, cap[i++]);
>  	pci_write_config_word(dev, pos + PCI_EXP_RTCTL, cap[i++]);
> -	pci_remove_saved_cap(save_state);
> -	kfree(save_state);
>  }
>  =

>  =

> @@ -597,7 +597,9 @@ static int pci_save_pcix_state(struct pci_dev *dev)
>  	if (pos <=3D 0)
>  		return 0;
>  =

> -	save_state =3D kzalloc(sizeof(*save_state) + sizeof(u16), GFP_KERNEL);
> +	save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		save_state =3D kzalloc(sizeof(*save_state) + sizeof(u16), GFP_KERNEL);
>  	if (!save_state) {
>  		dev_err(&dev->dev, "Out of memory in pci_save_pcie_state\n");
>  		return -ENOMEM;
> @@ -622,8 +624,6 @@ static void pci_restore_pcix_state(struct pci_dev *de=
v)
>  	cap =3D (u16 *)&save_state->data[0];
>  =

>  	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
> -	pci_remove_saved_cap(save_state);
> -	kfree(save_state);
>  }
>  =

>  =

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 78417e4..481ea06 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -209,11 +209,6 @@ static inline void pci_add_saved_cap(struct pci_dev =
*pci_dev,
>  	hlist_add_head(&new_cap->next, &pci_dev->saved_cap_space);
>  }
>  =

> -static inline void pci_remove_saved_cap(struct pci_cap_saved_state *cap)
> -{
> -	hlist_del(&cap->next);
> -}
> -
>  /*
>   *  For PCI devices, the region numbers are assigned this way:
>   *
