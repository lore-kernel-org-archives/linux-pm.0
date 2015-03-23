From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: prevent disk from spinning up at system resume
Date: Mon, 23 Mar 2015 11:03:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503231057230.1336-100000@iolanthe.rowland.org>
References: <877fu7hjbv.fsf@roche-blanche.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50072 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752854AbbCWPDc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 11:03:32 -0400
In-Reply-To: <877fu7hjbv.fsf@roche-blanche.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Cc: linux-pm@vger.kernel.org

On Mon, 23 Mar 2015, Peter M=C3=BCnster wrote:

> > The kernel wakes up _every_ device during system resume, even ones =
that
> > were in runtime suspend when the system suspend started.  With only=
 a
> > few exceptions, there is no way around this in the current kernel.
>=20
> Even after  "echo 0 >/sys/block/sdb/device/scsi_disk/2:0:0:0/manage_s=
tart_stop" ?

Yes.  As I understand it, writing 0 to manage_start_stop prevents the
kernel from sending a spin-up or spin-down command to the drive.  But
SATA drives automatically spin up anyway when the port returns to full
power.  Removing the SCSI device entry probably prevents the system
from changing the port's power level.

(Some of the details may be wrong here, because I'm not very familiar=20
with how the ATA subsystem works.)

> If there wasn't the "Synchronizing SCSI cache" at system resume, woul=
d
> the disk spin up nevertheless?

Yes, I think so.  In fact, the cache gets synchronized at system
suspend, not at system resume.  But the message doesn't get written to
the log file until after the system is running again.

Alan Stern

