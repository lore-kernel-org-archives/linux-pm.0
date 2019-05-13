From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 14:43:43 +0000
Message-ID: <b12ff66f8c224e4199ff1b90ed6bc393@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143741.GA25500@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513143741.GA25500@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: keith.busch@intel.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, May 13, 2019 9:38 AM
> To: Limonciello, Mario
> Cc: keith.busch@intel.com; hch@lst.de; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; rafael@kernel.org; linux-kernel@vger.kernel.org=
; linux-
> pm@vger.kernel.org; kai.heng.feng@canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Mon, May 13, 2019 at 02:24:41PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > I've received the result that from one of my partners this patch doesn'=
t
> > work properly and the platform doesn't go into a lower power state.
>=20
> Well, it sounds like your partners device does not work properly in this
> case.  There is nothing in the NVMe spec that says queues should be
> torn down for deep power states, and that whole idea seems rather
> counter productive to low-latency suspend/resume cycles.

Well I've got a thought, quoting the NVME spec:
"After a successful completion of a Set Features command for this feature, =
the controller shall be in the
Power State specified. If enabled, autonomous power state transitions conti=
nue to occur from the new state."

If APST is enabled on this disk, what is to stop an autonomous  reverse
transition from queue activity on the way down?

>=20
> > This was not a disk with HMB, but with regard to the HMB I believe it
> > needs to be removed during s0ix so that there isn't any mistake that SS=
D
> > thinks it can access HMB memory in s0ix.
>=20
> There is no mistake - the device is allowed to use the HMB from the
> point that we give it the memory range until the point where we either
> disable it, or shut the controller down.  If something else requires the
> device not to use the HMB after ->suspend is called we need to disable
> the HMB, and we better have a good reason for that and document it in
> the code.  Note that shutting down queues or having CPU memory barriers
> is not going to help with any of that.

So maybe the CPU memory barriers were probably just working around it in te=
rms of
timing.
