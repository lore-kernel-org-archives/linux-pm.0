From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: Resume regression on MBA2,1 triggered by
 2167e2399dc5e69c62db56d933e9c8cbe107620a
Date: Thu, 12 Dec 2013 13:38:07 +0100
Message-ID: <20131212133807.1c68707b@neptune.home>
References: <20131211010852.09ddf512@neptune.home>
	<20131211012529.GA6354@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20131211012529.GA6354@kroah.com>
Sender: cpufreq-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Greg,

On Tue, 10 December 2013 Greg Kroah-Hartman <gregkh@linuxfoundation.org=
> wrote:
> On Wed, Dec 11, 2013 at 01:08:52AM +0100, Bruno Pr=C3=A9mont wrote:
> > I have bisected failing resume from S3 on my MBA2,1 to be caused by
> > the following patch (introduced between 3.13-rc2 and 3.13-rc3 - rc2
> > resuming as expected, rc3 failing to resume).
> >=20
> > Unfortunately I have no trace for the failing resume though CPU see=
ms
> > to not be busy as fan does not start blowing (even when waiting mor=
e
> > than 10 minutes for the resume to eventually proceed which it does =
not).
> >=20
> > Kernel config and dmesg are attached (gzip compressed).
> >=20
> >   commit 2167e2399dc5e69c62db56d933e9c8cbe107620a
> >   Author: Bj=C3=B8rn Mork <bjorn@mork.no>
> >   Date:   Tue Dec 3 12:14:32 2013 +0100
> >   Subject: cpufreq: fix garbage kobjects on errors during suspend/r=
esume
>=20
> This has already been reverted in Linus's tree, see commit
> d4faadd5d5b368a7051fef374ee933ec3606713b for the details.
>=20
> Does Linus's tree still have the same problem for you?

The revert in Linus's tree does fix the resume problem,
(tested commit: 9538e10086bd1301fe, merge of linux-watchdog).

thanks,
Bruno

> thanks,
>=20
> greg k-h
