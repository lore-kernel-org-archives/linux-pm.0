From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: v3.16-rc1 regression? unexpected usb_autopm_get_interface error
Date: Mon, 16 Jun 2014 11:08:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1406161106470.1292-100000@iolanthe.rowland.org>
References: <8738f53vsy.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:54177 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753520AbaFPPIz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 11:08:55 -0400
In-Reply-To: <8738f53vsy.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, Dan Williams <dan.j.williams@intel.com>
Cc: USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Mon, 16 Jun 2014, Bj=C3=B8rn Mork wrote:

> Bj=C3=B8rn Mork <bjorn@mork.no> writes:
>=20
> > So the problem is related to runtime suspend before first use. I
> > strongly suspect=20
> >
> >  aae4518b3124 PM / sleep: Mechanism to avoid resuming runtime-suspe=
nded devices unnecessarily
>=20
> Nope, that was not it. So if blind guessing isn't going to work, then=
 I
> guess there is no way around a bisect :-)

You could simply wait for someone who knows the code to answer the=20
question.  :-)

I'm pretty sure this resulted from one of Dan Williams's changes to USB=
=20
port runtime PM.  A whole bunch of them were added in 3.15-rc1.

Alan Stern

