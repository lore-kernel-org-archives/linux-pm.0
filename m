From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: v3.16-rc1 regression? unexpected usb_autopm_get_interface error
Date: Mon, 16 Jun 2014 13:21:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1406161316160.1292-100000@iolanthe.rowland.org>
References: <8738f426ma.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54301 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755715AbaFPRV4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 13:21:56 -0400
In-Reply-To: <8738f426ma.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Mon, 16 Jun 2014, Bj=C3=B8rn Mork wrote:

> >> I'm pretty sure this resulted from one of Dan Williams's changes t=
o USB=20
> >> port runtime PM.  A whole bunch of them were added in 3.15-rc1.
> >
> > You are *so* much better at guessing than me:
> >
> > 9262c19d14c433a6a1ba25c3ff897cb89e412309 is the first bad commit
>=20
> And for completeness, I just tried the following partial revert on to=
p
> of v3.16-rc1 and can confirm that it works fine for me:

I'm not up-to-date on the most recent few releases, so I'll let Dan
take care of this.  In general, it looks like the problem stems from
the fact that when a device is disabled for runtime PM, a
pm_runtime_get_sync() or pm_runtime_resume() call won't succeed, even
if the device is currently at full power.  Maybe we should change this=20
in the PM core.

Dan, the warning message in hub_suspend() should mention that the child=
=20
device isn't suspended yet.  Currently it looks like it's saying that=20
the port isn't suspended, which gives the wrong impression.

Alan Stern

