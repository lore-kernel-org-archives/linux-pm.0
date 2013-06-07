From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] Power management and ACPI fixes for v3.10-rc5
Date: Sat, 08 Jun 2013 01:19:23 +0200
Message-ID: <5684767.k0MV6s4nnb@vostro.rjw.lan>
References: <3863425.93Oeg2bhJF@vostro.rjw.lan> <CA+8MBb+NAHvTCc-NMz4+HqkDc=VUWJ8gDz7ji=HtFiDbcpWo4Q@mail.gmail.com> <CA+8MBbJC9hKCjcZVK1tvpjr9DAwY_wAPmarqCWa7X-cq7Bph0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+8MBbJC9hKCjcZVK1tvpjr9DAwY_wAPmarqCWa7X-cq7Bph0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 07, 2013 04:02:11 PM Tony Luck wrote:
> On Fri, Jun 7, 2013 at 3:23 PM, Tony Luck <tony.luck@gmail.com> wrote:
> > So please don't pull.
> 
> Bother. I see I was a few hours late finding this, and commit 9f29ab11ddb
> is already in Linus' tree.
> 
> That's what happens when I get busy and skip a couple of days testing
> linux-next :-(
> 
> So my problem comes from
> arch/ia64/hp/common/sba_iommu.c
> 
> where the code in sba_init() says:
> 
>         acpi_bus_register_driver(&acpi_sba_ioc_driver);
>         if (!ioc_list) {
> 
> but because of this change we never managed to call ioc_init()
> so ioc_list doesn't get set up, and we die.
> Before this commit, the call chain looked like this:
> 
>  [<a0000001011c3710>] ioc_init+0x40/0xd00
>  [<a0000001011c4560>] acpi_sba_ioc_add+0x190/0x1c0
>  [<a0000001005b3b40>] acpi_device_probe+0xa0/0x280
>  [<a000000100850060>] really_probe+0xe0/0x520
>  [<a0000001008504d0>] driver_probe_device+0x30/0x60
>  [<a000000100850610>] __driver_attach+0x110/0x160
>  [<a00000010084c550>] bus_for_each_dev+0x110/0x180
>  [<a00000010084fcc0>] driver_attach+0x40/0x60
>  [<a00000010084da90>] bus_add_driver+0x230/0x580
>  [<a000000100851090>] driver_register+0xf0/0x400
>  [<a0000001005b8670>] acpi_bus_register_driver+0x50/0x80
>  [<a0000001011c45c0>] sba_init+0x30/0x2d0
> 
> Is my problem that this driver has (or attaches) a "scan handler"
> where it shouldn't ... and I just need to stop it doing that?

Looking into that.

Thanks,
Rafael
