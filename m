From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Thu, 5 Oct 2017 12:25:27 -0700
Message-ID: <CAKvHMgRx9U+GQ82GrSZYTAA6s1RH+HpEtkYZYf+O3VzqLDoD_g@mail.gmail.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
 <alpine.DEB.2.20.1710052113090.2626@hadrien> <1507230959.4434.39.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507230959.4434.39.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Joe,

On Thu, Oct 5, 2017 at 12:15 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2017-10-05 at 21:13 +0200, Julia Lawall wrote:
>>
>> On Fri, 6 Oct 2017, Masahiro Yamada wrote:
>>
>> > 2017-10-01 21:42 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
>> > > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
>> > > within a single structure.  It is currently specific to the file
>> > > drivers/power/supply/bq27xxx_battery.c.
>> > >
>> > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>> > >
>> > > ---
>> >
>> > Applied to linux-kbuild/misc.
>>
>> Thanks for picking it up.
>
> If it is specific to one file, why not just run it
> and post the resultant patch?  Why have it in tree?

The driver which this script analyzes supports more than a dozen
different chips, which require different parameters. This script
checks for duplicate parameter arrays.
