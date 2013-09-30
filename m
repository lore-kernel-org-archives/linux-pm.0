From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] x86/acpi: fix incorrect placement of __initdata tag
Date: Mon, 30 Sep 2013 17:27:46 +0200
Message-ID: <10479344.AmK4cG4GID@amdc1032>
References: <Pine.LNX.4.44L0.1309301023040.1352-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19966 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347Ab3I3P17 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 11:27:59 -0400
In-reply-to: <Pine.LNX.4.44L0.1309301023040.1352-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

On Monday, September 30, 2013 10:24:41 AM Alan Stern wrote:
> On Mon, 30 Sep 2013, Bartlomiej Zolnierkiewicz wrote:
> 
> > __initdata tag should be placed between the variable name and equal
> > sign for the variable to be placed in the intended .init.data section.
> 
> The line you are changing does not have an equals sign.  Therefore, 
> according to your own patch description, the patch is incorrect.  :-)

Uh, indeed, copypasta is bad. :)

Thanks for noticing, I'll post v2 shortly.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/x86/kernel/acpi/boot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 1f7c074..6c0b43b 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -695,7 +695,7 @@ static int __init acpi_parse_sbf(struct acpi_table_header *table)
> >  #ifdef CONFIG_HPET_TIMER
> >  #include <asm/hpet.h>
> >  
> > -static struct __initdata resource *hpet_res;
> > +static struct resource *hpet_res __initdata;
> >  
> >  static int __init acpi_parse_hpet(struct acpi_table_header *table)
> >  {
> 
> Alan Stern

