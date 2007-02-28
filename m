From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] pata_sil680 suspend/resume
Date: Wed, 28 Feb 2007 22:19:16 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0702282201250.8832@poirot.grange>
References: <20061122172841.0b90f042@localhost.localdomain>
	<Pine.LNX.4.60.0702262150460.5079@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0702262150460.5079@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-pm@lists.osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Feb 2007, Guennadi Liakhovetski wrote:

> With a post 2.6.20 kernel from powerpc.git I cannot suspend at all:
> =

> pata_sil680 0000:00:0c.0: suspend
> ata1: suspend failed, device 0 still active
> pci_device_suspend(): ata_pci_device_suspend+0x0/0x74() returns -16
> suspend_device(): pci_device_suspend+0x0/0xac() returns -16
> Could not suspend device 0000:00:0c.0: error -16

AFAICS, "still active" is printed from ata_host_suspend() if a device =

(disk) on the host to be suspended doesn't have ATA_DFLAG_SUSPENDED flag =

set. This flag is only set in ata_eh_suspend(), which is only called from =

ata_eh_recover(), like this:

generic_error_handler()
ata_bmdma_drive_eh()
ata_do_eh()
ata_eh_recover()
ata_eh_suspend()
dev->flags |=3D ATA_DFLAG_SUSPENDED;

but I don't understand why the error handler should be envoked? Should the =

"disk" be suspended before the host and is it when the eh should set the =

flag? If my guess is right - why doesn't the disk get suspended on my =

machine? Shall I suspend it explicitely from userspace? I do "hdparm -Y", =

and it does stop spinning", but I still get the error.

Thanks
Guennadi
---
Guennadi Liakhovetski
