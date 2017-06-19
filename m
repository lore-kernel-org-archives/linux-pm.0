From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and X86 due for the v4.13
 merge window
Date: Mon, 19 Jun 2017 15:48:49 +0100
Message-ID: <20170619144849.ltx2qny5v66od3ml@dell>
References: <CAHp75VcQfSkn7NAWSC2Vq=8RCC0M1p9zvVFjJFLyEo17GDvHsA@mail.gmail.com>
 <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1496687716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: gnurou@gmail.com, heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com
List-Id: linux-pm@vger.kernel.org

Enjoy!

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-x86-v4.13

for you to fetch changes up to 94d68594a7b4fd2eec457f22110de644e1c4ee57:

  platform/x86: intel_bxtwc_tmu: Remove first level IRQ unmask (2017-06-19 15:45:30 +0100)

----------------------------------------------------------------
Immutable branch between MFD and X86 due for the v4.13 merge window

----------------------------------------------------------------
Kuppuswamy Sathyanarayanan (6):
      mfd: intel_soc_pmic_bxtwc: Fix TMU interrupt index
      mfd: intel_soc_pmic_bxtwc: Remove thermal second level IRQs
      mfd: intel_soc_pmic_bxtwc: Remove second level IRQ for gpio device
      mfd: intel_soc_pmic_bxtwc: Utilize devm_* functions in driver probe
      mfd: intel_soc_pmic_bxtwc: Use chained IRQs for second level IRQ chips
      platform/x86: intel_bxtwc_tmu: Remove first level IRQ unmask

 drivers/gpio/gpio-wcove.c                |  14 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c       | 232 +++++++++++++++++++++----------
 drivers/platform/x86/intel_bxtwc_tmu.c   |   4 -
 drivers/thermal/intel_bxt_pmic_thermal.c |   2 +-
 drivers/usb/typec/typec_wcove.c          |   2 +-
 include/linux/mfd/intel_soc_pmic.h       |   5 +-
 6 files changed, 175 insertions(+), 84 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
