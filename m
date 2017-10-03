From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference to `__udivdi3'
Date: Tue, 3 Oct 2017 20:21:13 +0200
Message-ID: <CAJZ5v0inoxc0KXF87CZXoD_nzNwgcTMf=BLbQfM+fGT5ks0v4Q@mail.gmail.com>
References: <201710031050.2Iy92vzG%fengguang.wu@intel.com> <2859755.8uSvH3hIdc@aspire.rjw.lan>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E613050@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E613050@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Zheng, Lv" <lv.zheng@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 3, 2017 at 6:43 PM, Moore, Robert <robert.moore@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Tuesday, October 3, 2017 4:32 AM
>> To: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
>> <lv.zheng@intel.com>
>> Cc: Wu, Fengguang <fengguang.wu@intel.com>; kbuild-all@01.org; linux-
>> acpi@vger.kernel.org; devel@acpica.org; linux-pm@vger.kernel.org
>> Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
>> to `__udivdi3'
>>
>> On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot wrote:
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
>> pm.git bleeding-edge
>> > head:   09b089a247ea7272df93a2116368bf24b656cd65
>> > commit: 05545b3fb6eab35290413211617793bc274e136b [12/41] ACPICA:
>> Restructure/cleanup all string-to-integer conversion functions
>> > config: i386-defconfig (attached as .config)
>> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
>> > reproduce:
>> >         git checkout 05545b3fb6eab35290413211617793bc274e136b
>> >         # save the attached .config to linux build tree
>> >         make ARCH=i386
>> >
>> > All errors (new ones prefixed by >>):
>> >
>> >    drivers/acpi/acpica/utstrsuppt.o: In function
>> `acpi_ut_insert_digit':
>> > >> utstrsuppt.c:(.text+0x33): undefined reference to `__udivdi3'
>>
>> __udivdi3() doesn't work on 32-bit x86 AFAICS.
>>
>> Can we avoid using it or at least put it under #ifdef somehow?
> [Moore, Robert]
>
>
> I take it that __udivdi3 is a 64-bit divide?

Practically, yes (AFAICS).

> We do have a local divide implementation(s) for things like this.
>
> However, I don't see a divide in ut_insert_digit; There is a 64-bit divide in ut_strtoul_add_64, however.
>
> So, there are no issues with 64-bit add, subtract, and multiply?

The only problematic one I know of is __udivdi3().
