From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 01 Apr 2016 08:05:20 -0700
Message-ID: <1459523120.5912.20.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	 <8393335.Q1cjiaGecN@vostro.rjw.lan>
	 <CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	 <2727017.UmaUvtBLeX@vostro.rjw.lan>
	 <CADDKRnAYPXip0EG0Y7ADuyt9L=FL-Nd1giHBVvPexs4kGkRj4g@mail.gmail.com>
	 <1459446905.4569.76.camel@linux.intel.com>
	 <CADDKRnCy9frh3CZcz+4WhiFJHk1GmMbPB847iUKW2wOex7hGSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40138 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbcDAPI2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 11:08:28 -0400
In-Reply-To: <CADDKRnCy9frh3CZcz+4WhiFJHk1GmMbPB847iUKW2wOex7hGSw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Fri, 2016-04-01 at 11:42 +0200, J=C3=B6rg Otte wrote:
> 2016-03-31 19:55 GMT+02:00 Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>:
> > On Thu, 2016-03-31 at 19:27 +0200, J=C3=B6rg Otte wrote:
> > > 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > > > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
> > > > > 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.n
> > > > > et>:
> > > > > > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrot=
e:
[cut]

> I compile a minimum kernel for my notebook. The hardware is fix and
> will never change. So I don't need thousends of modules to compile.
> Kbuild supports this with target "localmodconfig".
> In the rare cases where I get new usb-hardware I add a new driver
> and compile a new kernel which takes only a minute.
>=20
With this minimum config, I am not able to properly run my laptop to
reproduce.
May be something odd in this config is triggering this issue, we are
not going to idle on some CPUs.

Thanks,
Srinivas

> Thanks, J=C3=B6rg
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
