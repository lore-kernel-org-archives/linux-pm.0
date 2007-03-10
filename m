From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Fri, 09 Mar 2007 20:41:14 -0700
Message-ID: <m1k5xp3gv9.fsf@ebiederm.dsl.xmission.com>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu> <45ECFC5F.7000102@garzik.org>
	<45ED0BBF.1050000@intel.com> <20070306090444.GA25409@elte.hu>
	<45ED8A12.5040803@intel.com>
	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>
	<45EEE8CF.1060803@intel.com> <45EEEC2C.5090609@intel.com>
	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>
	<45F1E876.5090102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45F1E876.5090102@intel.com> (Auke Kok's message of "Fri, 09 Mar
	2007 15:06:30 -0800")
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

> Eric W. Biederman wrote:
>
> [CHOP]
>
>> Below is an additional set of warnings that should help debug this.
>> The old code just got lucky that it triggered a warning when this happen=
s.
>
>
> I'm trying this patch together with the other 2 that you sent out a few d=
ays
> ago. I'm seeing some minor issues with this and lots of bogus warnings as=
 far as
> I can see.
>
> If I suspend/resume and unload e1000, then reinsert e1000.ko, I immediate=
ly hit
> the WARN_ON at `msi.c:516: WARN_ON(!hlist_empty(&dev->saved_cap_space));`
>
> I'm not sure that's useful debugging information. even though saved state=
 exists
> the module has been removed, so you might want to purge the state table w=
hen the
> driver gets removed?
>
>
> anyway, back to testing.

Sorry I should have been clear.

With the last two patches I sent out:
pci: Repair pci_save/restore_state so we can restore one save many times.
msi: Safer state caching.

Those WARN_ON's are now totally bogus.  =


In essence the WARN_ON's were testing to ensure pci_save_state and
pci_restore_state were paired.

The assumptions was that pci_restore_state would remove everything
from the list that pci_save_state placed on it.

When I reworked the code and removed the bogus pairing requirement it meant
that if we ever save state and have a pci-e or pci-x capability we will have
a state structure on the list until the kernel reboots. =


In summary:
pci_save_state and pci_restore_state were making a wrong assumption
about the world.  The WARN_ON patch tested to ensure the world matched
those functions.  When I fixed those functions to match the world the
WARN_ON's became completely bogus.

Eric
