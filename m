From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5] power_supply: platform/chrome: wilco_ec: Add charging
 config driver
Date: Sat, 20 Apr 2019 17:37:54 +0800
Message-ID: <201904201756.6pNuTXy5%lkp@intel.com>
References: <20190418233838.149545-1-ncrews@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418233838.149545-1-ncrews@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, bleung@chromium.org, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dlaurie@chromium.org, lamzin@google.com, bartfab@google.com, derat@google.com, dtor@google.com, sjg@chromium.org, jchwong@chromium.org, Nick Crews <ncrews@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi Nick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.1-rc5 next-20190418]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nick-Crews/power_supply-platform-chrome-wilco_ec-Add-charging-config-driver/20190420-041913
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

   drivers/power/supply/wilco-charger.c:46:14: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_STANDARD'
   drivers/power/supply/wilco-charger.c:48:14: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE'
   drivers/power/supply/wilco-charger.c:50:14: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_CUSTOM'
>> drivers/power/supply/wilco-charger.c:46:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:48:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:50:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:66:24: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_STANDARD'
   drivers/power/supply/wilco-charger.c:68:24: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE'
   drivers/power/supply/wilco-charger.c:70:24: sparse: undefined identifier 'POWER_SUPPLY_CHARGE_TYPE_CUSTOM'
   drivers/power/supply/wilco-charger.c:78:9: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD'
   drivers/power/supply/wilco-charger.c:79:9: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD'
   drivers/power/supply/wilco-charger.c:95:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD'
   drivers/power/supply/wilco-charger.c:98:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD'
   drivers/power/supply/wilco-charger.c:95:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:98:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:132:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD'
   drivers/power/supply/wilco-charger.c:138:14: sparse: undefined identifier 'POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD'
   drivers/power/supply/wilco-charger.c:132:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:138:14: sparse: incompatible types for 'case' statement
   drivers/power/supply/wilco-charger.c:46:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:48:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:50:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:95:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:98:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:132:14: sparse: Expected constant expression in case statement
   drivers/power/supply/wilco-charger.c:138:14: sparse: Expected constant expression in case statement

vim +/case +46 drivers/power/supply/wilco-charger.c

    37	
    38	/* Convert from POWER_SUPPLY_PROP_CHARGE_TYPE value to the EC's charge mode */
    39	static enum charge_mode psp_val_to_charge_mode(int psp_val)
    40	{
    41		switch (psp_val) {
    42		case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
    43			return CHARGE_MODE_AC;
    44		case POWER_SUPPLY_CHARGE_TYPE_FAST:
    45			return CHARGE_MODE_EXP;
  > 46		case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
    47			return CHARGE_MODE_STD;
    48		case POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE:
    49			return CHARGE_MODE_AUTO;
    50		case POWER_SUPPLY_CHARGE_TYPE_CUSTOM:
    51			return CHARGE_MODE_CUSTOM;
    52		default:
    53			return CHARGE_MODE_ILLEGAL;
    54		}
    55	}
    56	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
