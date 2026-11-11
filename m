Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393999;
	b=17BuIl/BJ3Whj0Nr46Cd/9N2Kklisgm9tSCWRJKP/SqMg+qTYuPtj0hWFsiBhxVMPzDC
	 8i4JuhXrkA5c398h6PyKsB03xJoFJIB3FKBLpCJ/IUCIlPmuW43CiNfFbpOE7f6mBbFF0
	 yMXgMgt2q0Iyenf5ZES7QTeHcy/FYI+ybJGijUsy4AZVVjk8mIOA+q+FpAafIJBhZeZKm
	 RBry9pZ69W7CEVTo4lfCvDw22qWa6UOhff2HM3oDPl+eEObzFn9suHkFa8Ep5VLdoA1Ft
	 PqXhYmSKsHHBmgn1QVnO2Y1FpSFyFYtwQBTYK5OTqoTBLRaCruyQUKRTLkm4+MvzzFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393999;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZS416nY8ExP39YQ01I5vRj/eYSpgEwqrVtZE/+h8ulw=;
	b=XErwhQTLEGxFzzB7Un0qeXJoRN7ky608DIsdC0t6ze9ggWB9EShfli3nRiFTflI6up3T
	 o1ALrzBgf6JCxMsRLa+XAoj/TJv+n9PbxpwIGPVE93eCHrIgLj5Y32TNom7IxhSgB3hZj
	 /96Qpj81SP4VQumkAYG1RVfG5kTLTkR0GespEAZt9qDDbDCoFpxbAQrPlmSuPR6Ki40/J
	 c5rX3uUCeLfep9vjXLmEgKrOmp+0s1QynQIbZzUxYJrHSo2C/CBk17EfnEvfZKPPmycpK
	 QCUVY51W2xsk+IODp06zP05Vh26aDr+94X/329Z2EgOpPha/6kwpz3X41+RFPyzw1wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=INpYfB4S;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E509606A321;
	Wed, 11 Nov 2026 10:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E509606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=INpYfB4S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794393999; x=1825929999;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=YoP1oiZhXdLsMGk4xqxz+pquVXQMtRV9gUudtX59dYo=;
  b=INpYfB4S1gjHyJUtm4jY6BWTO7yi8ortQL1RRXlVx64SyxfHsuM6jAbL
   XbZBAsk6Xjs/houAEycdsN9dVuYvxEbpBw7dahZCbJycPjamiAxjTgQMX
   R9fskUBs4lQmtximxkz33BahTO6+jMSfmUHHYegkJe++OcMU/uSz0pd1D
   bA+UPRomggh/lzyqAdEAlI3dpH+rsCEYGkGoezyOS5BYGOfiE59+weeBh
   Re8cYscqXL3kTWRuxufQVNNSINlcR8rEPrgCv3x3+6pGOF5xNKZIeUZ8s
   s3uGKqJ77zW/l0FhQd6k2VSw4ptxVvlufub5Lo/DQdSAFu4ot6n29aWjY
   Q==;
X-CSE-ConnectionGUID: PJgcahXbQYO0sCuFpu63Zw==
X-CSE-MsgGUID: Z4+sLm2OR+OQbJrx1FbmSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3196716"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3196716"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 02:46:38 -0800
X-CSE-ConnectionGUID: IUTHcJ0dSwCzeGQxiw1KUQ==
X-CSE-MsgGUID: y29INZLbSl+4RRe+xKlFdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8220207"
Received: from igk-lkp-server01.igk.intel.com (HELO 1073a420ae3a) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 11 Nov 2026 02:46:36 -0800
Received: from kbuild by 1073a420ae3a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xR5qb-000000000Yt-2AHk;
	Wed, 11 Nov 2026 10:46:33 +0000
Date: Wed, 11 Nov 2026 11:46:22 +0100
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 9/22]
 drivers/platform/x86/hp/hp-wmi.c:1057:16: error: implicit declaration of
 function 'devm_battery_hook_register'; did you mean
 'acpi_battery_hook_register'?
Message-ID: <202611111143.CWKE7ewK-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   51bafe2e7302403a43ba45415bf9a268a7fcaa05
commit: fafe4f5166bc3d43e28967efb9ea82b1f456b798 [9/22] Merge branch 'acpi-=
battery' into bleeding-edge
config: x86_64-randconfig-2003-20261111 (https://download.01.org/0day-ci/ar=
chive/20261111/202611111143.CWKE7ewK-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20261111/202611111143.CWKE7ewK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111143.CWKE7ewK-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/hp/hp-wmi.c: In function 'hp_wmi_charge_control_set=
up':
>> drivers/platform/x86/hp/hp-wmi.c:1057:16: error: implicit declaration of=
 function 'devm_battery_hook_register'; did you mean 'acpi_battery_hook_reg=
ister'? [-Wimplicit-function-declaration]
    1057 |         return devm_battery_hook_register(dev, &hp_wmi_charge_ba=
ttery_hook);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                acpi_battery_hook_register


vim +1057 drivers/platform/x86/hp/hp-wmi.c

929433336e0a6e Shang En Sim 2026-09-30  1033 =20
929433336e0a6e Shang En Sim 2026-09-30  1034  static int __init hp_wmi_char=
ge_control_setup(struct device *dev)
929433336e0a6e Shang En Sim 2026-09-30  1035  {
929433336e0a6e Shang En Sim 2026-09-30  1036  	enum power_supply_charge_beh=
aviour behaviour;
929433336e0a6e Shang En Sim 2026-09-30  1037  	int ret;
929433336e0a6e Shang En Sim 2026-09-30  1038 =20
929433336e0a6e Shang En Sim 2026-09-30  1039  	if (!dmi_check_system(hp_wmi=
_charge_control_quirks))
929433336e0a6e Shang En Sim 2026-09-30  1040  		return 0;
929433336e0a6e Shang En Sim 2026-09-30  1041 =20
929433336e0a6e Shang En Sim 2026-09-30  1042  	/*
929433336e0a6e Shang En Sim 2026-09-30  1043  	 * Firmware retains inhibit =
across reboot, so seed from GBCO rather
929433336e0a6e Shang En Sim 2026-09-30  1044  	 * than assuming auto.
929433336e0a6e Shang En Sim 2026-09-30  1045  	 */
929433336e0a6e Shang En Sim 2026-09-30  1046  	ret =3D hp_wmi_charge_mode_r=
ead();
929433336e0a6e Shang En Sim 2026-09-30  1047  	if (ret < 0)
929433336e0a6e Shang En Sim 2026-09-30  1048  		return 0;
929433336e0a6e Shang En Sim 2026-09-30  1049 =20
929433336e0a6e Shang En Sim 2026-09-30  1050  	ret =3D hp_wmi_charge_mode_t=
o_behaviour(ret, &behaviour);
929433336e0a6e Shang En Sim 2026-09-30  1051  	if (ret)
929433336e0a6e Shang En Sim 2026-09-30  1052  		return 0;
929433336e0a6e Shang En Sim 2026-09-30  1053 =20
929433336e0a6e Shang En Sim 2026-09-30  1054  	scoped_guard(mutex, &hp_wmi_=
charge_lock)
929433336e0a6e Shang En Sim 2026-09-30  1055  		hp_wmi_charge_behaviour =3D =
behaviour;
929433336e0a6e Shang En Sim 2026-09-30  1056 =20
929433336e0a6e Shang En Sim 2026-09-30 @1057  	return devm_battery_hook_reg=
ister(dev, &hp_wmi_charge_battery_hook);
929433336e0a6e Shang En Sim 2026-09-30  1058  }
929433336e0a6e Shang En Sim 2026-09-30  1059  #else
929433336e0a6e Shang En Sim 2026-09-30  1060  static int __init hp_wmi_char=
ge_control_setup(struct device *dev)
929433336e0a6e Shang En Sim 2026-09-30  1061  {
929433336e0a6e Shang En Sim 2026-09-30  1062  	return 0;
929433336e0a6e Shang En Sim 2026-09-30  1063  }
929433336e0a6e Shang En Sim 2026-09-30  1064  #endif
929433336e0a6e Shang En Sim 2026-09-30  1065 =20

:::::: The code at line 1057 was first introduced by commit
:::::: 929433336e0a6e5014af7b8849f369712d2c8964 platform/x86: hp-wmi: add c=
harge_behaviour support for Spectre 8C15/8C17

:::::: TO: Shang En Sim <sim@shangen.org>
:::::: CC: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
