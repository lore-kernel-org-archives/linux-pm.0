From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] ACPI fixes for v4.12-rc4
Date: Mon, 05 Jun 2017 15:24:31 +0200
Message-ID: <1549902.pI1fHhgOmJ@aspire.rjw.lan>
References: <CAJZ5v0jKBAgw3U=QOuGNwhqEMb0nfSUUNUotV9oyMr5NznF-Fg@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CEC5086@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEC5086@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, June 05, 2017 02:02:42 AM Zheng, Lv wrote:
> Hi,
> 
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J.
> > Wysocki
> > Subject: [GIT PULL] ACPI fixes for v4.12-rc4
> > 
> > Hi Linus,
> > 
> > Please pull from the tag
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-4.12-rc4
> > 
> > with top-most commit 60319130254084b337e02439d3b4ec301b6328bb
> > 
> >  Merge branches 'acpi-button', 'acpica' and 'acpi-sysfs'
> > 
> > on top of commit 5ed02dbb497422bf225783f46e6eadd237d23d6b
> > 
> >  Linux 4.12-rc3
> > 
> > to receive ACPI fixes for v4.12-rc4.
> > 
> > These revert one more problematic commit related to the ACPI-based
> > handling of laptop lids and make some unuseful error messages coming
> > from ACPICA go away.
> > 
> > Specifics:
> > 
> >  - Revert one more commit related to the ACPI-based handling of
> >    laptop lids that changed the default behavior on laptops that
> >    booted with closed lids and introduced a regression there
> >    (Benjamin Tissoires).
> > 
> >  - Add a missing acpi_put_table() to the code implementing the
> >    /sys/firmware/acpi/tables interface to prevent a counter in
> >    the ACPICA core from overflowing (Dan Williams).
> > 
> >  - Drop error messages printed by ACPICA on acpi_get_table()
> >    reference counting mismatches as they need not indicate real
> >    errors at this point (Lv Zheng).
> > 
> > Thanks!
> > 
> > 
> > ---------------
> > 
> > Benjamin Tissoires (1):
> >       Revert "ACPI / button: Change default behavior to lid_init_state=open"
> > 
> > Dan Williams (1):
> >       ACPI / sysfs: fix acpi_get_table() leak / acpi-sysfs denial of service
> 
> This commit can trigger regression as mentioned by this discussion:
> https://patchwork.kernel.org/patch/9717073/
> So if this commit is accepted by the upstream, the above commit should also be in upstream in order not to regress.
> Do you need to me refine it and re-send it to the community?

Yes, please.

> It's a bit slow in ACPICA upstream as ACPICA upstream is frozen for spec 6.2 support.

That's already out, though.

Thanks,
Rafael
