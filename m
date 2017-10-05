From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Thu, 05 Oct 2017 12:54:25 -0700
Message-ID: <1507233265.4434.45.camel@perches.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
         <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
         <alpine.DEB.2.20.1710052113090.2626@hadrien>
         <1507230959.4434.39.camel@perches.com>
         <alpine.DEB.2.20.1710052116480.2626@hadrien>
         <1507231856.4434.41.camel@perches.com>
         <CAKvHMgSniUfBjLXdBA8n_konTZm8D5kJf7M+DAZUXmEQzD0iUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKvHMgSniUfBjLXdBA8n_konTZm8D5kJf7M+DAZUXmEQzD0iUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2017-10-05 at 12:46 -0700, Liam Breck wrote:
> Hi Joe,
> 
> On Thu, Oct 5, 2017 at 12:30 PM, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-10-05 at 21:19 +0200, Julia Lawall wrote:
> > > On Thu, 5 Oct 2017, Joe Perches wrote:
> > > > On Thu, 2017-10-05 at 21:13 +0200, Julia Lawall wrote:
> > > > > On Fri, 6 Oct 2017, Masahiro Yamada wrote:
> > > > > > 2017-10-01 21:42 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> > > > > > > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
> > > > > > > within a single structure.  It is currently specific to the file
> > > > > > > drivers/power/supply/bq27xxx_battery.c.
> > > > > > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> > > > > > 
> > > > > > Applied to linux-kbuild/misc.
> > > > > 
> > > > > Thanks for picking it up.
> > > > 
> > > > If it is specific to one file, why not just run it
> > > > and post the resultant patch?  Why have it in tree?
> > > 
> > > I guess that they anticipate that the data may change in the future?
> > 
> > Aren't you the script author Julia?  Who is the "they"?
> > 
> > I think having a script for a single file unnecessary.
> 
> Sebastian Reichel, the power-supply maintainer, requested this script.
> I previously implemented this as a run-time check within ifdef DEBUG,
> but that was rejected.

Hi Liam.

If you are the author of the script, you should also have
a sign-off/from here right?

This also has a copyright of Inria and Julia Lawall
which, if you are the author, doesn't seem appropriate.

cheers, Joe
