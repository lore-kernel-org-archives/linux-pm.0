From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 18:01:39 +0000
Message-ID: <df020e90e8b54244b37910a2a7965671@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513145708.GA25897@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: kbusch@kernel.org, keith.busch@intel.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, May 13, 2019 9:57 AM
> To: Limonciello, Mario
> Cc: kbusch@kernel.org; keith.busch@intel.com; hch@lst.de; sagi@grimberg.m=
e;
> linux-nvme@lists.infradead.org; rafael@kernel.org; linux-kernel@vger.kern=
el.org;
> linux-pm@vger.kernel.org; kai.heng.feng@canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, May 13, 2019 at 02:54:49PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > The Intel DMA controller suspend callbacks in drivers/dma/idma64.c look=
 to me
> to
> > turn off the controller.
>=20
> How is that relevant?  That thing is neither a NVMe controller, nor
> even an PCIe device..

When using HMB the SSD will be writing to some memory mapped region.  Writi=
ng to
that region would use DMA to access host memory, no?
If the DMA controller is not functional writing to that region won't work p=
roperly as=20
it can't access that memory.

>=20
> > And NVME spec made it sound to me that while in a low power state it sh=
ouldn't
> > be available if the memory isn't available.
> >
> > NVME spec in 8.9:
> >
> > "Host software should request that the controller release the
> > assigned ranges prior to a shutdown event, a Runtime D3 event, or any o=
ther
> event
> > that requires host software to reclaim the assigned ranges."
>=20
> The last part of the quoted text is the key - if the assigned range
> is reclaimed, that is the memory is going to be used for something else,
> we need to release the ranges.  But we do not release the ranges,
> as we want to keep the memory in use so that we can quickly use it
> again.
