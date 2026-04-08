Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996A2D7DF8;
	Wed,  8 Apr 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641433; cv=none; b=I6g2rGYpoUimkgTYvYyJlsr35zxbdYJ0URdl+1xy0n5vDfSPO5TXUxzYiy93FDpr5wnPER/2n8rA+SKJDzmgAI+3qwZ6Tza24JTOeqOY45ISyWRZvaRCGnn2l1vrpWgh0Xz/R3fATeWl2Vee5NlZ3Fdm+8CtNnhVB6YVrT3mefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641433; c=relaxed/simple;
	bh=ygyHYmJhRKAjYV6QfMQiNmjx6SwHLjGVTuiJiGrSc9s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YXpPcgi/KAottU0k1HujT0TixOWefVrNnrE9pzpaWN6BfGEYJLuOJxmMwXoWnydDfOwtdENoOBpiTDG5mahu1X8YXbk95EkA0ozKNwH4ghpiD48/iVukTWjFCeqAkkKXw3XuB8bSsZ4UEyCxfwtLDW9ADzAX3HH//5OkdMRjuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=as/Lf9p3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="as/Lf9p3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775641433; x=1807177433;
  h=date:from:to:cc:subject:message-id;
  bh=ygyHYmJhRKAjYV6QfMQiNmjx6SwHLjGVTuiJiGrSc9s=;
  b=as/Lf9p32kzV095v/MFNHzrR4k2cR8UfdyYn+/zmxoNXXPpZT7Y9brXw
   IZzrlLp7939Z4hyo7hM0/Mpp3zYJbq21oJ/BhmSZJTLnrUcSqij9Er5Pr
   CPvRNMmLhdwm5CW4Qhzn1b/Fi142rBFhAvnQXgYqs1CAUio5G8mdbLD1I
   +Z9D9n/YOqkQL1QeOjNu5oWLMUGUmVgDm0al4LkKi0/M3WX6GfNzuzrSp
   QiU1ft7mRjolV5YBkvNP0u4bQdzh52GGivntm0n8jH7sRyHfiFASobK3n
   IiWmXX54as5W9NVqY7cQvqjuOPQoPfeIDBkwFgbo6CB4Dvfcuz+66OSRY
   g==;
X-CSE-ConnectionGUID: LeVQ5AqkQ7+MLeo/4+3uHA==
X-CSE-MsgGUID: MDhFUiTFTh+yCDqDsxNVyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="99243868"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="99243868"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 02:43:49 -0700
X-CSE-ConnectionGUID: /UtGf5BdRVC/1g05cvsYzw==
X-CSE-MsgGUID: wnb/32F6SB6iOfI23jua4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="233297492"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Apr 2026 02:43:47 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wAPRo-000000001gV-204O;
	Wed, 08 Apr 2026 09:43:44 +0000
Date: Wed, 08 Apr 2026 17:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:bleeding-edge 170/268]
 drivers/hwmon/emc2305.c:312:undefined reference to
 `devm_thermal_of_cooling_device_register'
Message-ID: <202604081734.3OJSeExW-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi Daniel,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   d18364264af84e2a89da14c6b5f0eae2ba7f98de
commit: e1b96fba58c6fe18a31a06f752ebc8ad6921b1cb [170/268] thermal/of: Move OF code where it belongs to
config: x86_64-randconfig-074-20260408 (https://download.01.org/0day-ci/archive/20260408/202604081734.3OJSeExW-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604081734.3OJSeExW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604081734.3OJSeExW-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `emc2305_set_single_tz':
>> drivers/hwmon/emc2305.c:312:(.text+0x311f7a1): undefined reference to `devm_thermal_of_cooling_device_register'
   ld: vmlinux.o: in function `max6650_probe':
>> drivers/hwmon/max6650.c:796:(.text+0x318d88a): undefined reference to `devm_thermal_of_cooling_device_register'
   ld: vmlinux.o: in function `tc654_probe':
>> drivers/hwmon/tc654.c:544:(.text+0x3193384): undefined reference to `devm_thermal_of_cooling_device_register'


vim +312 drivers/hwmon/emc2305.c

0d8400c5a2ce159 Michael Shych   2022-08-10  301  
2ed4db7a1d07b34 Florin Leotescu 2025-06-03  302  static int emc2305_set_single_tz(struct device *dev, struct device_node *fan_node, int idx)
0d8400c5a2ce159 Michael Shych   2022-08-10  303  {
0d8400c5a2ce159 Michael Shych   2022-08-10  304  	struct emc2305_data *data = dev_get_drvdata(dev);
0d8400c5a2ce159 Michael Shych   2022-08-10  305  	long pwm;
0d8400c5a2ce159 Michael Shych   2022-08-10  306  	int i, cdev_idx, ret;
0d8400c5a2ce159 Michael Shych   2022-08-10  307  
0d8400c5a2ce159 Michael Shych   2022-08-10  308  	cdev_idx = (idx) ? idx - 1 : 0;
0d8400c5a2ce159 Michael Shych   2022-08-10  309  	pwm = data->pwm_min[cdev_idx];
0d8400c5a2ce159 Michael Shych   2022-08-10  310  
0d8400c5a2ce159 Michael Shych   2022-08-10  311  	data->cdev_data[cdev_idx].cdev =
2ed4db7a1d07b34 Florin Leotescu 2025-06-03 @312  		devm_thermal_of_cooling_device_register(dev, fan_node,
2115cbeec8a3ccc Florin Leotescu 2025-03-21  313  							emc2305_fan_name[idx], data,
0d8400c5a2ce159 Michael Shych   2022-08-10  314  							&emc2305_cooling_ops);
0d8400c5a2ce159 Michael Shych   2022-08-10  315  
0d8400c5a2ce159 Michael Shych   2022-08-10  316  	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
0d8400c5a2ce159 Michael Shych   2022-08-10  317  		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
0d8400c5a2ce159 Michael Shych   2022-08-10  318  		return PTR_ERR(data->cdev_data[cdev_idx].cdev);
0d8400c5a2ce159 Michael Shych   2022-08-10  319  	}
0429415a084a154 Florin Leotescu 2025-06-03  320  
0429415a084a154 Florin Leotescu 2025-06-03  321  	if (data->cdev_data[cdev_idx].cur_state > 0)
0429415a084a154 Florin Leotescu 2025-06-03  322  		/* Update pwm when temperature is above trips */
0429415a084a154 Florin Leotescu 2025-06-03  323  		pwm = EMC2305_PWM_STATE2DUTY(data->cdev_data[cdev_idx].cur_state,
0429415a084a154 Florin Leotescu 2025-06-03  324  					     data->max_state, EMC2305_FAN_MAX);
0429415a084a154 Florin Leotescu 2025-06-03  325  
0d8400c5a2ce159 Michael Shych   2022-08-10  326  	/* Set minimal PWM speed. */
0d8400c5a2ce159 Michael Shych   2022-08-10  327  	if (data->pwm_separate) {
0d8400c5a2ce159 Michael Shych   2022-08-10  328  		ret = emc2305_set_pwm(dev, pwm, cdev_idx);
0d8400c5a2ce159 Michael Shych   2022-08-10  329  		if (ret < 0)
0d8400c5a2ce159 Michael Shych   2022-08-10  330  			return ret;
0d8400c5a2ce159 Michael Shych   2022-08-10  331  	} else {
0d8400c5a2ce159 Michael Shych   2022-08-10  332  		for (i = 0; i < data->pwm_num; i++) {
0d8400c5a2ce159 Michael Shych   2022-08-10  333  			ret = emc2305_set_pwm(dev, pwm, i);
0d8400c5a2ce159 Michael Shych   2022-08-10  334  			if (ret < 0)
0d8400c5a2ce159 Michael Shych   2022-08-10  335  				return ret;
0d8400c5a2ce159 Michael Shych   2022-08-10  336  		}
0d8400c5a2ce159 Michael Shych   2022-08-10  337  	}
0d8400c5a2ce159 Michael Shych   2022-08-10  338  	data->cdev_data[cdev_idx].cur_state =
0429415a084a154 Florin Leotescu 2025-06-03  339  		EMC2305_PWM_DUTY2STATE(pwm, data->max_state,
0d8400c5a2ce159 Michael Shych   2022-08-10  340  				       EMC2305_FAN_MAX);
0d8400c5a2ce159 Michael Shych   2022-08-10  341  	data->cdev_data[cdev_idx].last_hwmon_state =
0429415a084a154 Florin Leotescu 2025-06-03  342  		EMC2305_PWM_DUTY2STATE(pwm, data->max_state,
0d8400c5a2ce159 Michael Shych   2022-08-10  343  				       EMC2305_FAN_MAX);
0d8400c5a2ce159 Michael Shych   2022-08-10  344  	return 0;
0d8400c5a2ce159 Michael Shych   2022-08-10  345  }
0d8400c5a2ce159 Michael Shych   2022-08-10  346  

:::::: The code at line 312 was first introduced by commit
:::::: 2ed4db7a1d07b349b50e890dee3d0f245230d254 hwmon: (emc2305) Configure PWM channels based on DT properties

:::::: TO: Florin Leotescu <florin.leotescu@nxp.com>
:::::: CC: Guenter Roeck <linux@roeck-us.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
