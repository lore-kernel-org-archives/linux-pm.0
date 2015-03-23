From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: prevent disk from spinning up at system resume
Date: Mon, 23 Mar 2015 09:57:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503230956210.1336-100000@iolanthe.rowland.org>
References: <87iodsht89.fsf@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49966 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752144AbbCWN5Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 09:57:16 -0400
In-Reply-To: <87iodsht89.fsf@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Cc: linux-pm@vger.kernel.org

On Mon, 23 Mar 2015, Peter M=C3=BCnster wrote:

> Hi,
>=20
> My SATA disk (sdb) spins up at every system resume. How could I avoid
> that please?
>=20
> Some details:
>=20
> - sdb not mounted
> - echo 0 >/sys/block/sdb/device/scsi_disk/2:0:0:0/manage_start_stop
> - hdparm -C /dev/sdb :   "drive state is:  standby"
> - s2ram
> - after wake up:         "drive state is:  active/idle"
> - kernel message at wakeup: "sd 2:0:0:0: [sdb] Synchronizing SCSI cac=
he"
> - when doing "echo scsi remove-single-device 2 0 0 0 >/proc/scsi/scsi=
"
>   before s2ram, sdb keeps sleeping after resume

It looks like you already have your answer.

> I need the disk only about once per week. I use s2ram several times p=
er
> day, and I prefer that sdb keeps sleeping.
>=20
> TIA for any hints,

Alan Stern

