From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] ACPI / PM: Make messages in acpi_device_set_power() print device names
Date: Mon, 29 Jul 2013 14:17:53 +0200
Message-ID: <1782275.A7JEhQIj8Q@vostro.rjw.lan>
References: <10433383.dueoNg39qi@vostro.rjw.lan> <CAOLK0pyBsD8vR0a2mcSucnD8zFTz8ZB72OPE0R9Z67SxH9VHRw@mail.gmail.com> <1375067513.2075.27.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45930 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643Ab3G2MHo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Jul 2013 08:07:44 -0400
In-Reply-To: <1375067513.2075.27.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Sunday, July 28, 2013 08:11:53 PM Joe Perches wrote:
> On Mon, 2013-07-29 at 11:06 +0800, Lan Tianyu wrote:
> > 2013/7/27 Rafael J. Wysocki <rjw@sisk.pl>:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> []
> > >  drivers/acpi/device_pm.c |   22 ++++++++++------------
> []
> > > @@ -166,20 +166,20 @@ int acpi_device_set_power(struct acpi_de
> []
> > >         if (device->parent && (state < device->parent->power.state)) {
> > > -               printk(KERN_WARNING PREFIX
> > > -                             "Cannot set device to a higher-powered"
> > > -                             " state than parent\n");
> > > +               dev_warn(&device->dev, "Cannot transition to a higher-powered "
> > > +                        "state than parent\n");
> 
> coalesce format please.

I can, but then it'll cross the 80 columns boundary.

Thanks,
Rafael

