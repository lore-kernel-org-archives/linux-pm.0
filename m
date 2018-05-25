From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: EC: Dispatch the EC GPE directly on s2idle wake
Date: Fri, 25 May 2018 10:48:11 +0200
Message-ID: <CAJZ5v0j_mLPw2VT6GbAxSDizu4Rr94muweiBs6ZhLuUJe2O7vQ@mail.gmail.com>
References: <3221007.8CUDle5b3u@aspire.rjw.lan> <201805181421.jU5hI6Bo%fengguang.wu@intel.com>
 <CAPDyKFpnrPeG23Q+i6ASCeohGR3vfGQRwQzjwGsKE=c4TyAiQA@mail.gmail.com> <CAJZ5v0jFmVd_SkvgoXmi2Psqg5ALJRDsKzV8PiFysHQt9f0uog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jFmVd_SkvgoXmi2Psqg5ALJRDsKzV8PiFysHQt9f0uog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@01.org, Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>, "Wang, Wendy" <wendy.wang@intel.com>, kbuild test robot <lkp@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 25, 2018 at 10:08 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, May 25, 2018 at 8:49 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Rafael,
>>
>> On 18 May 2018 at 08:10, kbuild test robot <lkp@intel.com> wrote:
>>> Hi Rafael,
>>>
>>> I love your patch! Yet something to improve:
>>>
>>> [auto build test ERROR on pm/linux-next]
>>> [also build test ERROR on v4.17-rc5]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Rafael-J-Wysocki/ACPI-PM-Dispatch-EC-GPE-early-on-s2idle-resume-if-LPS0-_DSM-is-used/20180518-070817
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>>> config: arm64-defconfig (attached as .config)
>>> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         make.cross ARCH=arm64
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/acpi/ec.o: In function `acpi_ec_dispatch_gpe':
>>>>> ec.c:(.text+0x239c): undefined reference to `acpi_dispatch_gpe'
>>>    ec.c:(.text+0x239c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `acpi_dispatch_gpe'
>>>
>>> ---
>>> 0-DAY kernel test infrastructure                Open Source Technology Center
>>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
>> This breaks arm64 builds, would you mind to drop the offending patch
>> from your linux-next branch?
>
> Not really, but I can fix it.

Should be fixed now, sorry for the breakage.
