From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference to `__udivdi3'
Date: Tue, 03 Oct 2017 13:31:47 +0200
Message-ID: <2859755.8uSvH3hIdc@aspire.rjw.lan>
References: <201710031050.2Iy92vzG%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201710031050.2Iy92vzG%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   09b089a247ea7272df93a2116368bf24b656cd65
> commit: 05545b3fb6eab35290413211617793bc274e136b [12/41] ACPICA: Restructure/cleanup all string-to-integer conversion functions
> config: i386-defconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 05545b3fb6eab35290413211617793bc274e136b
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/acpi/acpica/utstrsuppt.o: In function `acpi_ut_insert_digit':
> >> utstrsuppt.c:(.text+0x33): undefined reference to `__udivdi3'

__udivdi3() doesn't work on 32-bit x86 AFAICS.

Can we avoid using it or at least put it under #ifdef somehow?

Thanks,
Rafael

