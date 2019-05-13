From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 15:05:42 +0000
Message-ID: <d69ff7154191492eaa8f55535a7effa5@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
 <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
 <20190513145522.GA15421@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513145522.GA15421@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbusch@kernel.org
Cc: hch@lst.de, keith.busch@intel.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Monday, May 13, 2019 9:55 AM
> To: Limonciello, Mario
> Cc: hch@lst.de; keith.busch@intel.com; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; rafael@kernel.org; linux-kernel@vger.kernel.org=
; linux-
> pm@vger.kernel.org; kai.heng.feng@canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, May 13, 2019 at 02:43:43PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > Well, it sounds like your partners device does not work properly in t=
his
> > > case.  There is nothing in the NVMe spec that says queues should be
> > > torn down for deep power states, and that whole idea seems rather
> > > counter productive to low-latency suspend/resume cycles.
> >
> > Well I've got a thought, quoting the NVME spec:
> > "After a successful completion of a Set Features command for this featu=
re, the
> controller shall be in the
> > Power State specified. If enabled, autonomous power state transitions c=
ontinue
> to occur from the new state."
> >
> > If APST is enabled on this disk, what is to stop an autonomous  reverse
> > transition from queue activity on the way down?
>=20
> Regardless of whether APST is enabled or not, the controller may
> autonomously transition out of a host requested low power state in
> response to host activity. Exiting a low power state should mean some
> other task is actively using the device, and if that's the case, why are
> you trying to enter a low power state in the first place? Alternatively,
> if host activity really is idle, then why is the device autonomously
> leaving the requested state?

This system power state - suspend to idle is going to freeze threads.
But we're talking a multi threaded kernel.  Can't there be a timing problem=
 going
on then too?  With a disk flush being active in one task and the other task=
 trying
to put the disk into the deepest power state.  If you don't freeze the queu=
es how
can you guarantee that didn't happen?
