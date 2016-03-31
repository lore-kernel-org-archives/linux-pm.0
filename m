From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
Date: Thu, 31 Mar 2016 09:52:54 +0200
Message-ID: <CAKv+Gu-_YhFva9RHUtzC68Ck2wTN2BvcXTEfCJbvVh98DFgn_A@mail.gmail.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
	<201603301450.pihQHWST%fengguang.wu@intel.com>
	<CADyBb7spZBi-w5wFnVjioMVo4EEjWGcVdWgtbsF+wkCA0qi=gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35829 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbcCaHwz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 03:52:55 -0400
Received: by mail-io0-f179.google.com with SMTP id g185so106216105ioa.2
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 00:52:54 -0700 (PDT)
In-Reply-To: <CADyBb7spZBi-w5wFnVjioMVo4EEjWGcVdWgtbsF+wkCA0qi=gQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fu Wei <fu.wei@linaro.org>
Cc: kbuild test robot <lkp@intel.com>, Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Richard Ruigrok <rruigrok@codeaurora.org>, pavel@ucw.cz, "hpa@zytor.com" <hpa@zytor.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, "x86@kernel.org" <x86@kernel.org>, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Mark Salter <msalter@redhat.com>, Grant Likely <grant.likely@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, len.brown@intel.com, linux-pm@vger.kernel.org, Marc Zyngier <Marc.Zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz>

On 30 March 2016 at 19:55, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Tomasz
>
> On 30 March 2016 at 14:50, kbuild test robot <lkp@intel.com> wrote:
>> Hi Tomasz,
>>
>> [auto build test WARNING on arm64/for-next/core]
>> [also build test WARNING on v4.6-rc1 next-20160330]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-apei-arm64-APEI-initial-support-for-aarch64/20160329-154730
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
>> config: arm64-allyesconfig (attached as .config)
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All warnings (new ones prefixed by >>):
>>
>> warning: (ACPI_APEI) selects EFI which has unmet direct dependencies (OF && !CPU_BIG_ENDIAN)
>
> I think it's caused by  CPU_BIG_ENDIAN, because  ARM64 selects OF.
>

No, as I pointed out, it is caused by the fact that you 'select' EFI
rather than 'depend on' it.

> Any suggestion ?
>

replace

select EFI if ARM64

with

depends on EFI || !ARM64

but it would be even better to make ACPI_APEI depend on ACPI, since
the above dependency will be implied then, although I am not sure how
that affects other architectures.

-- 
Ard.
