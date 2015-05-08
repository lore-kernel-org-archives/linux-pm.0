From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC 1/5] ACPI / containers : add support for ACPI0010 processor container
Date: Fri, 08 May 2015 22:33:08 +0200
Message-ID: <4776276.Jd7Q2QdcgM@vostro.rjw.lan>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com> <2334052.J3vzukF2MM@vostro.rjw.lan> <554CD711.3090903@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58555 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932079AbbEHUID convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 16:08:03 -0400
In-Reply-To: <554CD711.3090903@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ahs3@redhat.com" <ahs3@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On Friday, May 08, 2015 04:32:33 PM Sudeep Holla wrote:
>=20
> On 08/05/15 15:06, Rafael J. Wysocki wrote:
> > On Friday, May 08, 2015 04:50:10 PM Hanjun Guo wrote:
> >> Hi Sudeep,
> >>
> >> On 2015=E5=B9=B405=E6=9C=8806=E6=97=A5 22:31, Sudeep Holla wrote:
> >>> ACPI 6.0 adds support for optional processor container device whi=
ch may
> >>> contain child objects that are either processor devices or other =
processor
> >>> containers. This allows representing hierarchical processor topol=
ogies.
> >>>
> >>> It is declared using the _HID of ACPI0010. It may also have _CID =
of
> >>> PNP0A05, which represents a generic container device.
> >>
> >> Container device helps support hotplug of nodes, CPUs, and memory,
> >> does this container device ACPI0010 used for the same purpose?
> >
> > That's correct and the patch isn't.
> >
>=20
> Thanks Rafael for the clarification.
>=20
> Just curious if the firmware adds _CID of PNP0A05 to support OS that
> don't parse processor containers, will the current code not create
> containers using _CID ?

Yes, it will, but you can prevent that from happening by adding a new
scan handler just for ACPI0010 (that may just return 1 from its ->attac=
h
callback and do nothing else).


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
