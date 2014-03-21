From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI and PM material for v3.15-rc1 (current queue)
Date: Fri, 21 Mar 2014 17:40:26 +0100
Message-ID: <4752174.DIeOl6EhdE@vostro.rjw.lan>
References: <2611540.GrpzWjVQ7v@vostro.rjw.lan> <532B8A4B.9000808@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59943 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751594AbaCUQYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 12:24:55 -0400
In-Reply-To: <532B8A4B.9000808@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On Friday, March 21, 2014 08:39:39 AM Hanjun Guo wrote:
> Hi Rafael,

Hi,

> On 2014=E5=B9=B403=E6=9C=8821=E6=97=A5 08:23, Rafael J. Wysocki wrote=
:
> > Hi All,
> >
> > My queue for the first pull request during the upcoming 3.15 merge =
window
> > contains the material below.  Following the rule that everything I =
send
> > pull requests for should spend at least one day in linux-next, I'm =
not
> > going to add any more new commits to it at this point.
> >
> > Most likely, there will be more ACPI+PM pull request during the 3.1=
5 cycle,
> > so if I missed something, it still may be possible to get that into=
 that
> > kernel, but there has to be a good reason for it.
> >
> > Kind regards,
> > Rafael
> >
> >
> > ---------------
> >
> > Hanjun Guo (2):
> >        ACPI / tables: Replace printk with pr_*
> >        ACPI: Remove duplicate definitions of PREFIX
>=20
> It seems that you missed some of my patches:
> ACPI: Move BAD_MADT_ENTRY() to linux/acpi.h
> ACPI / idle: Make idle_boot_override depend on x86 and ia64
> ACPI / trivial: Fix the return value type of acpi_processor_eval_pdc(=
)
> ACPI / processor: Replace hard-coded "ACPI0007" with=20
> ACPI_PROCESSOR_DEVICE_HID
>=20
> I think those 4 patches can be merged in 3.15 and you already accepte=
d them.

Yes, I did not include the acpi-processor branch, sorry about that and =
thanks
for spotting it!

That branch was in linux-next before, though, so I'll push it for 3.15-=
rc1.

> and this patch still need more acks and then you will accept it:
> ACPI / processor_core: Rework _PDC related stuff to make it more=20
> arch-independent
>=20
> and this patch was reverted from your tree suggested by Catalin and S=
udeep,
> ACPI / processor: Introduce map_gic_id() to get apic id from MADT or=20
> _MAT method
>=20
> Sorry for the confusion if I missed something.

I don't think you missed anything, thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
