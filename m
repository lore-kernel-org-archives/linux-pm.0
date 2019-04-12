From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] power_supply: platform/chrome: wilco_ec: Add
 charging config driver
Date: Fri, 12 Apr 2019 23:52:43 +0800
Message-ID: <201904122335.RtGa2sij%lkp@intel.com>
References: <20190412002055.92529-2-ncrews@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412002055.92529-2-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, enric.balletbo@collabora.com, bleung@chromium.org, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dlaurie@chromium.org, lamzin@google.com, bartfab@google.com, derat@google.com, groeck@google.com, dtor@google.com, sjg@chromium.org, jchwong@chromium.org, Nick Crews <ncrews@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi Nick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc4 next-20190412]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nick-Crews/power_supply-Add-more-charge-types-and-CHARGE_CONTROL_-properties/20190412-211253


coccinelle warnings: (new ones prefixed by >>)

>> drivers/platform/chrome/wilco_ec/charge_config.c:173:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
