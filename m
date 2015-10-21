From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: linux-next: Tree for Oct 21 (regmap-spmi.c caused by
 QCOM_SPMI_TEMP_ALARM)
Date: Wed, 21 Oct 2015 15:12:46 -0700
Message-ID: <56280DDE.4090001@codeaurora.org>
References: <20151021171623.2d651735@canb.auug.org.au>
 <5627FB7E.60300@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <5627FB7E.60300@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 10/21/2015 01:54 PM, Randy Dunlap wrote:
> On 10/20/15 23:16, Stephen Rothwell wrote:
>> Hi all,
>>
>> There will be no linux-next releases after tomorrow until Nov 2 (kernel
>> summit).
>>
>> Changes since 20151020:
>>
> on x86_64:
>
> warning: (QCOM_SPMI_TEMP_ALARM) selects REGMAP_SPMI which has unmet direct dependencies (SPMI)
>
> drivers/built-in.o: In function `regmap_spmi_base_read':
> regmap-spmi.c:(.text+0x1bef59): undefined reference to `spmi_register_read'
> drivers/built-in.o: In function `regmap_spmi_base_gather_write':
> regmap-spmi.c:(.text+0x1befd3): undefined reference to `spmi_register_zero_write'
> regmap-spmi.c:(.text+0x1bf007): undefined reference to `spmi_register_write'
> drivers/built-in.o: In function `regmap_spmi_ext_read':
> regmap-spmi.c:(.text+0x1bf106): undefined reference to `spmi_ext_register_read'
> regmap-spmi.c:(.text+0x1bf14d): undefined reference to `spmi_ext_register_readl'
> drivers/built-in.o: In function `regmap_spmi_ext_gather_write':
> regmap-spmi.c:(.text+0x1bf1f6): undefined reference to `spmi_ext_register_write'
> regmap-spmi.c:(.text+0x1bf23d): undefined reference to `spmi_ext_register_writel'
>
>
>
> CONFIG_REGMAP_SPMI=y
> CONFIG_SPMI is not enabled.
> CONFIG_QCOM_SPMI_TEMP_ALARM=y
> CONFIG_COMPILE_TEST=y
>
>
>

Caused by?

commit cb7fb4d342023d03070fcc1ed73fcd43682973d7
Author: Eduardo Valentin <edubezval@gmail.com>
Date:   Wed Sep 9 20:56:26 2015 -0700

    thermal: qcom_spmi: allow compile test
   
    Adding COMPILE_TEST flag to qcom_spmi driver to facilitate
    maintenance.
   
    Cc: Zhang Rui <rui.zhang@intel.com>
    Cc: linux-pm@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Eduardo Valentin <edubezval@gmail.com>

I suppose it could be depends on (OF || COMPILE_TEST), but that's
probably about it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
