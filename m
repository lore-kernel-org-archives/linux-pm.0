From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ PATCH] Add suspend/resume for HPET was: Re: [3/6]
 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 09:35:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703290930540.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<200703290641.20236.maximlevitsky@gmail.com>
	<Pine.LNX.4.64.0703282203550.6730@woody.linux-foundation.org>
	<200703290747.28929.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703290747.28929.maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim <maximlevitsky@gmail.com>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Thu, 29 Mar 2007, Maxim wrote:

> On Thursday 29 March 2007 07:08:58 Linus Torvalds wrote:
> > =

> > (Or, better yet, shouldn't we set "boot_hpet_disable" when we decide no=
t =

> > to use the HPET, and set hpet_virt_address to NULL?)
> =

> This is done here
> =

> out_nohpet:
> 	iounmap(hpet_virt_address);
> 	hpet_virt_address =3D NULL;

No, that only clears hpet_virt_address, and thus makes all subsequent =

"hpet_readl()" and "hpet_writel()" calls oops.

But it doesn't actually *tell* anybody that the HPET is disabled, so if =

you later on do

	if (is_hpet_capable()) {
		time =3D hpet_readl(..);
		..

you will just Oops!

So as far as I can see, even with your latest patch, if hpet_enable() =

fails (and triggers the "goto out_nohpet" cases), you'll just oops =

immediately when you try to suspend/resume the HPET.

THAT was what I meant - when we clear hpet_virt_address, we should also =

tell all potential subsequent users that the HPET is not there!

		Linus
