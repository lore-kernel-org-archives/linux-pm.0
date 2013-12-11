From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Resume regression on MBA2,1 triggered by
 2167e2399dc5e69c62db56d933e9c8cbe107620a
Date: Tue, 10 Dec 2013 17:25:29 -0800
Message-ID: <20131211012529.GA6354@kroah.com>
References: <20131211010852.09ddf512@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131211010852.09ddf512@neptune.home>
Sender: cpufreq-owner@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 11, 2013 at 01:08:52AM +0100, Bruno Pr=E9mont wrote:
> Hi Bj=F8rn, Rafael,
>=20
> I have bisected failing resume from S3 on my MBA2,1 to be caused by
> the following patch (introduced between 3.13-rc2 and 3.13-rc3 - rc2
> resuming as expected, rc3 failing to resume).
>=20
> Unfortunately I have no trace for the failing resume though CPU seems
> to not be busy as fan does not start blowing (even when waiting more
> than 10 minutes for the resume to eventually proceed which it does no=
t).
>=20
> Kernel config and dmesg are attached (gzip compressed).
>=20
>   commit 2167e2399dc5e69c62db56d933e9c8cbe107620a
>   Author: Bj=F8rn Mork <bjorn@mork.no>
>   Date:   Tue Dec 3 12:14:32 2013 +0100
>   Subject: cpufreq: fix garbage kobjects on errors during suspend/res=
ume

This has already been reverted in Linus's tree, see commit
d4faadd5d5b368a7051fef374ee933ec3606713b for the details.

Does Linus's tree still have the same problem for you?

thanks,

greg k-h
