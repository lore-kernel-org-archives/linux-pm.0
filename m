From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v8] acpi, apei, arm64: APEI initial support for aarch64.
Date: Thu, 31 Mar 2016 01:55:00 +0800
Message-ID: <CADyBb7spZBi-w5wFnVjioMVo4EEjWGcVdWgtbsF+wkCA0qi=gQ@mail.gmail.com>
References: <1459237458-12352-1-git-send-email-fu.wei@linaro.org>
	<201603301450.pihQHWST%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201603301450.pihQHWST%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Tomasz Nowicki <tn@semihalf.com>, Rafael Wysocki <rjw@rjwysocki.net>, len.brown@intel.com, pavel@ucw.cz, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, hpa@zytor.com, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, x86@kernel.org, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, G Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Richard Ruigrok <rruigrok@codeaurora.org>, "Abdulhamid, Harb" <harba@qti.qualcomm.com>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Jon Masters <jcm@redhat.com>, Mark Salter <ms>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz

On 30 March 2016 at 14:50, kbuild test robot <lkp@intel.com> wrote:
> Hi Tomasz,
>
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on v4.6-rc1 next-20160330]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-apei-arm64-APEI-initial-support-for-aarch64/20160329-154730
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
> config: arm64-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All warnings (new ones prefixed by >>):
>
> warning: (ACPI_APEI) selects EFI which has unmet direct dependencies (OF && !CPU_BIG_ENDIAN)

I think it's caused by  CPU_BIG_ENDIAN, because  ARM64 selects OF.

Any suggestion ?


>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
