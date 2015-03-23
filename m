From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: prevent disk from spinning up at system resume
Date: Mon, 23 Mar 2015 10:19:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503231015390.1336-100000@iolanthe.rowland.org>
References: <871tkfiz8q.fsf@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49992 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752182AbbCWOTD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 10:19:03 -0400
In-Reply-To: <871tkfiz8q.fsf@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Cc: linux-pm@vger.kernel.org

On Mon, 23 Mar 2015, Peter M=C3=BCnster wrote:

> On Mon, Mar 23 2015, Alan Stern wrote:
>=20
> >> - when doing "echo scsi remove-single-device 2 0 0 0 >/proc/scsi/s=
csi"
> >>   before s2ram, sdb keeps sleeping after resume
> >
> > It looks like you already have your answer.
>=20
> Sorry, I forgot to mention, that the disk needs to be mounted.

Why does the disk need to be mounted if you aren't using it more than=20
once a week or so?  Why not mount it only while it is in use?

> I just wanted to point out, that the kernel wakes up the disk, and no=
t
> the bios or something else.

The kernel wakes up _every_ device during system resume, even ones that
were in runtime suspend when the system suspend started.  With only a
few exceptions, there is no way around this in the current kernel.

Alan Stern

