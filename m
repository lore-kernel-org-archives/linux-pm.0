From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] scripts: coccinelle: api: detect identical chip data
 arrays
Date: Wed, 8 Nov 2017 21:04:17 +0800 (CST)
Message-ID: <alpine.DEB.2.20.1711082104070.2708@hadrien>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr> <1507490321-24900-3-git-send-email-Julia.Lawall@lip6.fr> <CAK7LNAQKOK5fbkq9AcSzmHc+qJLxAwB0Hy5eYy389uMnvah7uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAQKOK5fbkq9AcSzmHc+qJLxAwB0Hy5eYy389uMnvah7uA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org



On Tue, 7 Nov 2017, Masahiro Yamada wrote:

> 2017-10-09 4:18 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> > within a single structure.  It is currently specific to the file
> > drivers/power/supply/bq27xxx_battery.c.  Nevertheless, having the script in
> > the kernel will allow others to check their code if the data structures
> > change in the future.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
>
> Applied to linux-kbuild/misc.

Thanks!

julia
