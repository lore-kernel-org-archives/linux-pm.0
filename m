From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 1 Apr 2016 22:28:07 +0200
Message-ID: <CAJZ5v0hTvCoVaf4PEte6V5kcc0PRv+kPR_uM_ec_8Sc1sKp5Mw@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
	<CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
	<3623107.tlAuqH4F7s@vostro.rjw.lan>
	<CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34841 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbcDAU2K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 16:28:10 -0400
In-Reply-To: <CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Doug Smythies <dsmythies@telus.net>

On Fri, Apr 1, 2016 at 4:06 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wro=
te:
> 2016-04-01 14:40 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> On Friday, April 01, 2016 11:20:42 AM J=C3=B6rg Otte wrote:
>>> 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>>> > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
>>> >> 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>=
:
>>> >> > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
>>> >> >

[cut]

>
> Done. Attached the tracer.
> For me it looks like the previous one of the failing case.
>

Yes, it does, so no improvement.

Well, that will require further investigation, so I have created a
kernel Bugzilla entry for the tracking of this issue:

https://bugzilla.kernel.org/show_bug.cgi?id=3D115771

I would like to communicate through it going forward if that's not a pr=
oblem.

Thanks,
Rafael
