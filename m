From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference to `__udivdi3'
Date: Tue, 03 Oct 2017 23:17:41 +0200
Message-ID: <1959321.5JVcEPhjSi@aspire.rjw.lan>
References: <201710031050.2Iy92vzG%fengguang.wu@intel.com> <7672294.bGB5UuPiJL@aspire.rjw.lan> <94F2FBAB4432B54E8AACC7DFDE6C92E37E6131F5@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E6131F5@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 3, 2017 11:23:36 PM CEST Moore, Robert wrote:
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > Sent: Tuesday, October 3, 2017 2:07 PM
> > To: Moore, Robert <robert.moore@intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Zheng, Lv
> > <lv.zheng@intel.com>; Wu, Fengguang <fengguang.wu@intel.com>; kbuild-
> > all@01.org; linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> > pm@vger.kernel.org
> > Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
> > to `__udivdi3'
> > 
> > On Tuesday, October 3, 2017 10:50:11 PM CEST Rafael J. Wysocki wrote:
> > > On Tuesday, October 3, 2017 9:41:23 PM CEST Moore, Robert wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf
> > > > > Of Rafael J. Wysocki
> > > > > Sent: Tuesday, October 3, 2017 11:21 AM
> > > > > To: Moore, Robert <robert.moore@intel.com>
> > > > > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Zheng, Lv
> > > > > <lv.zheng@intel.com>; Wu, Fengguang <fengguang.wu@intel.com>;
> > > > > kbuild- all@01.org; linux-acpi@vger.kernel.org; devel@acpica.org;
> > > > > linux- pm@vger.kernel.org
> > > > > Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined
> > > > > reference to `__udivdi3'
> > > > >
> > > > > On Tue, Oct 3, 2017 at 6:43 PM, Moore, Robert
> > > > > <robert.moore@intel.com>
> > > > > wrote:
> > > > > >
> > > > > >
> > > > > >> -----Original Message-----
> > > > > >> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> > > > > >> Sent: Tuesday, October 3, 2017 4:32 AM
> > > > > >> To: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
> > > > > >> <lv.zheng@intel.com>
> > > > > >> Cc: Wu, Fengguang <fengguang.wu@intel.com>; kbuild-all@01.org;
> > > > > >> linux- acpi@vger.kernel.org; devel@acpica.org;
> > > > > >> linux-pm@vger.kernel.org
> > > > > >> Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined
> > > > > >> reference to `__udivdi3'
> > > > > >>
> > > > > >> On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot
> > wrote:
> > > > > >> > tree:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> > > > > >> pm.git bleeding-edge
> > > > > >> > head:   09b089a247ea7272df93a2116368bf24b656cd65
> > > > > >> > commit: 05545b3fb6eab35290413211617793bc274e136b [12/41]
> > ACPICA:
> > > > > >> Restructure/cleanup all string-to-integer conversion functions
> > > > > >> > config: i386-defconfig (attached as .config)
> > > > > >> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> > > > > >> > reproduce:
> > > > > >> >         git checkout 05545b3fb6eab35290413211617793bc274e136b
> > > > > >> >         # save the attached .config to linux build tree
> > > > > >> >         make ARCH=i386
> > > > > >> >
> > > > > >> > All errors (new ones prefixed by >>):
> > > > > >> >
> > > > > >> >    drivers/acpi/acpica/utstrsuppt.o: In function
> > > > > >> `acpi_ut_insert_digit':
> > > > > >> > >> utstrsuppt.c:(.text+0x33): undefined reference to
> > `__udivdi3'
> > > > > >>
> > > > > >> __udivdi3() doesn't work on 32-bit x86 AFAICS.
> > > > > >>
> > > > > >> Can we avoid using it or at least put it under #ifdef somehow?
> > > > > > [Moore, Robert]
> > > > > >
> > > > > >
> > > > > > I take it that __udivdi3 is a 64-bit divide?
> > > > >
> > > > > Practically, yes (AFAICS).
> > > > >
> > > > > > We do have a local divide implementation(s) for things like
> > this.
> > > > > >
> > > > > > However, I don't see a divide in ut_insert_digit; There is a
> > > > > > 64-bit
> > > > > divide in ut_strtoul_add_64, however.
> > > > [Moore, Robert]
> > > >
> > > > Oops, sorry. The divided is in strtoul_multiply_64. We are checking
> > > > for an overflow condition up front.
> > >
> > > But this is a plain division, so it looks like a build system or
> > > compiler issue to me.
> > 
> > Well, OK.  Plain u64 / u64 divisions need to be avoided for stuff to
> > build on 32-bit x86.
> > 
> [Moore, Robert] 
> 
> Even u64/u32.
> 
> Anyway, this is no problem to change since we already have the functionality locally.

OK

Can you please send me a patch against upstream ACPICA to change this?

I'll try do fold it in. :-)

