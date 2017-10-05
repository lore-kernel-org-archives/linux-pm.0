From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH] coccinelle: api: detect duplicate chip data arrays
Date: Thu, 5 Oct 2017 12:46:42 -0700
Message-ID: <CAKvHMgSniUfBjLXdBA8n_konTZm8D5kJf7M+DAZUXmEQzD0iUA@mail.gmail.com>
References: <1506861768-5734-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAK7LNAQK7w3FBxJUhX3Vn48XsUT7jQzGDC7kzCx2r-yWm0CdEw@mail.gmail.com>
 <alpine.DEB.2.20.1710052113090.2626@hadrien> <1507230959.4434.39.camel@perches.com>
 <alpine.DEB.2.20.1710052116480.2626@hadrien> <1507231856.4434.41.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:46169 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdJETqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2017 15:46:44 -0400
In-Reply-To: <1507231856.4434.41.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>

Hi Joe,

On Thu, Oct 5, 2017 at 12:30 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2017-10-05 at 21:19 +0200, Julia Lawall wrote:
>> On Thu, 5 Oct 2017, Joe Perches wrote:
>> > On Thu, 2017-10-05 at 21:13 +0200, Julia Lawall wrote:
>> > > On Fri, 6 Oct 2017, Masahiro Yamada wrote:
>> > > > 2017-10-01 21:42 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
>> > > > > This semantic patch detects duplicate arrays declared using BQ27XXX_DATA
>> > > > > within a single structure.  It is currently specific to the file
>> > > > > drivers/power/supply/bq27xxx_battery.c.
>> > > > > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>> > > > Applied to linux-kbuild/misc.
>> > > Thanks for picking it up.
>> > If it is specific to one file, why not just run it
>> > and post the resultant patch?  Why have it in tree?
>> I guess that they anticipate that the data may change in the future?
>
> Aren't you the script author Julia?  Who is the "they"?
>
> I think having a script for a single file unnecessary.

Sebastian Reichel, the power-supply maintainer, requested this script.
I previously implemented this as a run-time check within ifdef DEBUG,
but that was rejected.
