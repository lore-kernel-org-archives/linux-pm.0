Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7F2ED17B
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774097561; cv=none; b=R7BhFqsUdi72Oia6KtrYe4nVNNd1nSOWl6tDi8xKyRCdflzxlXBGy5rsOObJnJmT0rzB6FeS49KMCv9MTLeSZpPMD2AxJn64YU9SJAVKq1UjHukSGD6jtoLjzl9IcL4g0o1sHdwQyv5UL+VjKPGITfIGrC2ArTpognsk/Bw1sMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774097561; c=relaxed/simple;
	bh=JIuJkZZttoOzKPM0gXcgQPryTYEMZb6jC8ptmj5Xuqs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ONh4cgP5hEayJlx8iqCGpv7gOjy8l4eXkAr/XBOZHMljaq1YDKro3Fxk0tIrRIYZy5lMiBvZWyUh3pnkoWHQ4r6T0qoi5m8znLTnh71QGLgmu10bFUHy8w+FA54xyH72cirgD0tvTZP50icNDyfjsrXDVAeFqb9WxM+e9R3vcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4CUn+C7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4CUn+C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774097557; x=1805633557;
  h=date:from:to:cc:subject:message-id;
  bh=JIuJkZZttoOzKPM0gXcgQPryTYEMZb6jC8ptmj5Xuqs=;
  b=A4CUn+C76hE0gwP66dlT5qYtFXThn2n5PJiaeBiQvEaBNDamnnnzE90O
   GRqZgMt8vEHFs6jIUBMMU2lm/ZAM8nizvUApZfUgwica7ktzu/4H0PoM3
   FggBk8vPyT58I42RMiSstUwYsHX2KdxVd2lqVrsi7DUOuIfKxdlO3ewux
   /dD656T23dILMMI7VAvYyZ4mJ8WphvR5RTGtPgfSLBbebWX3crUPTFmET
   Oh8Pr9KWwYn/tvwa5BqGYjoUlTE08kR16WAfpZ8SENXRlWAmUyC5l0xE7
   gUkq/ojmmPyCHzOKp44qOQLIGMOC+fOXrY7DMfv222ePVeNTf8P52eQOP
   w==;
X-CSE-ConnectionGUID: F618VCQdSDiOQ1/ToDRhvw==
X-CSE-MsgGUID: NY0icRMFTA6a1CS2Er4Nyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="79029434"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="79029434"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 05:52:36 -0700
X-CSE-ConnectionGUID: ktkgtm4CTtic1Zx+ghqyXA==
X-CSE-MsgGUID: tOdiYfZ2Qy+PbPkyb1CscA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="222640011"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 21 Mar 2026 05:52:35 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3vod-0000000067N-2dTW;
	Sat, 21 Mar 2026 12:52:31 +0000
Date: Sat, 21 Mar 2026 13:52:29 +0100
From: kernel test robot <lkp@intel.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [chanwoo:devfreq-next 5/5]
 drivers/devfreq/devfreq.c:1946:37: error: redefinition of 'devfreq_group'
Message-ID: <202603211336.i375F7lD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-next
head:   38aa14f9be920f3fea6fe3f16b69b7a0cd0478a1
commit: 38aa14f9be920f3fea6fe3f16b69b7a0cd0478a1 [5/5] PM / devfreq: change devfreq_class to a const struct
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260321/202603211336.i375F7lD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603211336.i375F7lD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603211336.i375F7lD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/devfreq/devfreq.c:1946:37: error: redefinition of 'devfreq_group'
    1946 | static const struct attribute_group devfreq_group = {
         |                                     ^
   drivers/devfreq/devfreq.c:40:1: note: previous definition is here
      40 | ATTRIBUTE_GROUPS(devfreq);
         | ^
   include/linux/sysfs.h:291:37: note: expanded from macro 'ATTRIBUTE_GROUPS'
     291 | static const struct attribute_group _name##_group = {           \
         |                                     ^
   <scratch space>:89:1: note: expanded from here
      89 | devfreq_group
         | ^
>> drivers/devfreq/devfreq.c:1955:38: error: redefinition of 'devfreq_groups'
    1955 | static const struct attribute_group *devfreq_groups[] = {
         |                                      ^
   drivers/devfreq/devfreq.c:40:1: note: previous definition is here
      40 | ATTRIBUTE_GROUPS(devfreq);
         | ^
   include/linux/sysfs.h:298:11: note: expanded from macro 'ATTRIBUTE_GROUPS'
     298 | };                                                              \
         |                                                                 ^
   include/linux/sysfs.h:285:38: note: expanded from macro '\
   __ATTRIBUTE_GROUPS'
     285 | static const struct attribute_group *_name##_groups[] = {       \
         |                                      ^
   <scratch space>:93:1: note: expanded from here
      93 | devfreq_groups
         | ^
   2 errors generated.


vim +/devfreq_group +1946 drivers/devfreq/devfreq.c

9005b65099ee4f MyungJoo Ham  2011-10-02  1945  
e4999090951abc Pengjie Zhang 2025-12-16 @1946  static const struct attribute_group devfreq_group = {
e4999090951abc Pengjie Zhang 2025-12-16  1947  	.attrs = devfreq_attrs,
e4999090951abc Pengjie Zhang 2025-12-16  1948  };
e4999090951abc Pengjie Zhang 2025-12-16  1949  
e4999090951abc Pengjie Zhang 2025-12-16  1950  static const struct attribute_group gov_attr_group = {
e4999090951abc Pengjie Zhang 2025-12-16  1951  	.attrs = governor_attrs,
e4999090951abc Pengjie Zhang 2025-12-16  1952  	.is_visible = gov_attr_visible,
e4999090951abc Pengjie Zhang 2025-12-16  1953  };
e4999090951abc Pengjie Zhang 2025-12-16  1954  
e4999090951abc Pengjie Zhang 2025-12-16 @1955  static const struct attribute_group *devfreq_groups[] = {
e4999090951abc Pengjie Zhang 2025-12-16  1956  	&devfreq_group,
e4999090951abc Pengjie Zhang 2025-12-16  1957  	&gov_attr_group,
e4999090951abc Pengjie Zhang 2025-12-16  1958  	NULL
e4999090951abc Pengjie Zhang 2025-12-16  1959  };
e4999090951abc Pengjie Zhang 2025-12-16  1960  

:::::: The code at line 1946 was first introduced by commit
:::::: e4999090951abcf39543aa22b7a7a7f13c5a5857 PM / devfreq: use _visible attribute to replace create/remove_sysfs_files()

:::::: TO: Pengjie Zhang <zhangpengjie2@huawei.com>
:::::: CC: Chanwoo Choi <cw00.choi@samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
