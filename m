From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Mon, 13 May 2019 14:24:41 +0000
Message-ID: <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: keith.busch@intel.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
List-Id: linux-pm@vger.kernel.org

> > Cc: Mario Limonciello <Mario.Limonciello@dell.com>
> > Cc: Kai Heng Feng <kai.heng.feng@canonical.com>
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> > Disclaimer: I've tested only on emulation faking support for the featur=
e.
>=20
> Thanks for sharing.  I'll arrange some testing with this with storage par=
tners early
> next week.
>=20

I've received the result that from one of my partners this patch doesn't wo=
rk properly
and the platform doesn't go into a lower power state.  (The patch submitted=
 by KH/me
did work on said system to get it into a lower power state for them).

This was not a disk with HMB, but with regard to the HMB I believe it needs=
 to be
removed during s0ix so that there isn't any mistake that SSD thinks it can =
access HMB
memory in s0ix.
