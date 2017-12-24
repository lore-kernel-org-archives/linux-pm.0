From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] pm: Fix build issues in ds278* (thinkpad_acpi)
Date: Sun, 24 Dec 2017 18:57:09 +0800
Message-ID: <201712241833.Bzw9bOzN%fengguang.wu@intel.com>
References: <20171224100647.GA13797@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171224100647.GA13797@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
Cc: kbuild-all@01.org, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ognjen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on battery/master]
[also build test ERROR on v4.15-rc5 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ognjen-Galic/pm-Fix-build-issues-in-ds278-thinkpad_acpi/20171224-181540
base:   git://git.infradead.org/battery-2.6.git master
config: i386-randconfig-x007-201752 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_pmod_enabled':
>> drivers/power//supply/ds2780_battery.c:453:29: error: implicit declaration of function 'to_power_supply'; did you mean 'power_supply_put'? [-Werror=implicit-function-declaration]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
                                power_supply_put
>> drivers/power//supply/ds2780_battery.c:453:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_pmod_enabled':
   drivers/power//supply/ds2780_battery.c:472:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_sense_resistor_value':
   drivers/power//supply/ds2780_battery.c:507:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_sense_resistor_value':
   drivers/power//supply/ds2780_battery.c:525:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_rsgain_setting':
   drivers/power//supply/ds2780_battery.c:545:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_rsgain_setting':
   drivers/power//supply/ds2780_battery.c:562:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_get_pio_pin':
   drivers/power//supply/ds2780_battery.c:588:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_set_pio_pin':
   drivers/power//supply/ds2780_battery.c:606:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_read_param_eeprom_bin':
   drivers/power//supply/ds2780_battery.c:632:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_write_param_eeprom_bin':
   drivers/power//supply/ds2780_battery.c:645:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_read_user_eeprom_bin':
   drivers/power//supply/ds2780_battery.c:677:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2780_battery.c: In function 'ds2780_write_user_eeprom_bin':
   drivers/power//supply/ds2780_battery.c:690:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_pmod_enabled':
>> drivers/power//supply/ds2781_battery.c:455:29: error: implicit declaration of function 'to_power_supply'; did you mean 'power_supply_put'? [-Werror=implicit-function-declaration]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
                                power_supply_put
>> drivers/power//supply/ds2781_battery.c:455:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_pmod_enabled':
   drivers/power//supply/ds2781_battery.c:474:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_sense_resistor_value':
   drivers/power//supply/ds2781_battery.c:509:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_sense_resistor_value':
   drivers/power//supply/ds2781_battery.c:527:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_rsgain_setting':
   drivers/power//supply/ds2781_battery.c:547:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_rsgain_setting':
   drivers/power//supply/ds2781_battery.c:564:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_get_pio_pin':
   drivers/power//supply/ds2781_battery.c:590:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_set_pio_pin':
   drivers/power//supply/ds2781_battery.c:608:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_read_param_eeprom_bin':
   drivers/power//supply/ds2781_battery.c:634:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_write_param_eeprom_bin':
   drivers/power//supply/ds2781_battery.c:647:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_read_user_eeprom_bin':
   drivers/power//supply/ds2781_battery.c:679:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   drivers/power//supply/ds2781_battery.c: In function 'ds2781_write_user_eeprom_bin':
   drivers/power//supply/ds2781_battery.c:693:29: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct power_supply *psy = to_power_supply(dev);
                                ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +453 drivers/power//supply/ds2780_battery.c

275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  446  
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  447  static ssize_t ds2780_get_pmod_enabled(struct device *dev,
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  448  	struct device_attribute *attr,
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  449  	char *buf)
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  450  {
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  451  	int ret;
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  452  	u8 control_reg;
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26 @453  	struct power_supply *psy = to_power_supply(dev);
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  454  	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  455  
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  456  	/* Get power mode */
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  457  	ret = ds2780_get_control_register(dev_info, &control_reg);
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  458  	if (ret < 0)
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  459  		return ret;
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  460  
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  461  	return sprintf(buf, "%d\n",
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  462  		 !!(control_reg & DS2780_CONTROL_REG_PMOD));
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  463  }
275ac746 drivers/power/ds2780_battery.c Clifton Barnes 2011-05-26  464  

:::::: The code at line 453 was first introduced by commit
:::::: 275ac74629c4d8ec430d7edecb16d936f46a47c5 w1: add Maxim/Dallas DS2780 Stand-Alone Fuel Gauge IC support

:::::: TO: Clifton Barnes <cabarnes@indesign-llc.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+HP7ph2BbKc20aGI--
