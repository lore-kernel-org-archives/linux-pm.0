Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA418C332;
	Wed, 24 Jun 2026 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296387; cv=none; b=rQ9WrI7KzLQcn9qts2yc8Oc0JvHgCpHfiqLMjv81aEmUUNgknQMDtTwleaIaO7gJT3Ga/qfAkCbIy+bX7OkWFh8Tg5TwxrIUNA+GLZJDSv9/1+Fb8MlBKgSAwWmaEVxMn1+zdPNZy69hOT8Vl4IUMXMAtlBwlpoOCW/0gyovXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296387; c=relaxed/simple;
	bh=KYq/FGlOspjFJcHsROaTN9iguFQqWbIshCZc0TjEUfM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E7E1gdeMZ1ota38ToP63f8avP2ph7Fn2k8mP7moWo0yyPsJe72/rkzhnvOrFWz95HTuVqpDhSfcGAjvbMSJstWWergQhDGBn/8wihWgT+sWt6G6BqPHL15olHRwtJyKafLQuajmLsyM+7yPQN94eg8rtWnH1GvjefcU7ZhiU8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7n9oZ/N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7n9oZ/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782296386; x=1813832386;
  h=date:from:to:cc:subject:message-id;
  bh=KYq/FGlOspjFJcHsROaTN9iguFQqWbIshCZc0TjEUfM=;
  b=c7n9oZ/N+Ax5O+rH1feBSWpLcjPI17EeVuUsbtrSF+2hdjxfCZQlM8H8
   I2RhS5ryrIcU470Nc4+jW+VDZ3rl3W+NjDR/+edfOirPa2BIlOe1T87BR
   i4pDpGN8TgccDLGxOJIVgwfywxDTqLXhqun8GQkAN4Fine6taJEPBed9k
   43ROIYYWVUcnuLKesATWuXYqThZggUX+Dj2UmZoxNzofJJlrsQjTdj9Ku
   s295NfbWZ4Le/x9mrRZXUdhNJ/vcg+kppdUfPmfEjQbvwnMhFVlDmW8PO
   PXsZ2NsKQUuBOsSOKfChUxSFxHpD9NZ6n/RT8ADgfFlD5ZRC+Nb7Zjtt0
   w==;
X-CSE-ConnectionGUID: 1HrkkCK2SRqnpWRCCldImA==
X-CSE-MsgGUID: L/lTk0dhR6eT4oZ2M6jOCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100478023"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="100478023"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:19:45 -0700
X-CSE-ConnectionGUID: T8rzb2ZjRc2Fgu1Wdw4xwg==
X-CSE-MsgGUID: RoFyrXBDTA2jWNhz5qivxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="273489082"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 24 Jun 2026 03:19:43 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wcKho-000000003Hh-3k6p;
	Wed, 24 Jun 2026 10:19:40 +0000
Date: Wed, 24 Jun 2026 18:19:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [rafael-pm:linux-next 15/16]
 drivers/pnp/isapnp/core.c:392:31: sparse: sparse: incorrect type in argument
 1 (different base types)
Message-ID: <202606241828.hRy0jZOE-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
head:   7b8d80921156c54cf7fcc35a830342686958aeea
commit: efc2cb1d5a32de297e45525c43dc4d1bda50a528 [15/16] PNP: make pnp_eisa_id_to_string() take __be32 id
config: loongarch-randconfig-r134-20260624 (https://download.01.org/0day-ci/archive/20260624/202606241828.hRy0jZOE-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project a9b492db3d50683e446cd1a5c9ffaf4e92cb77a7)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260624/202606241828.hRy0jZOE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606241828.hRy0jZOE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pnp/isapnp/core.c:392:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 [usertype] id @@     got unsigned int [assigned] [usertype] eisa_id @@
   drivers/pnp/isapnp/core.c:392:31: sparse:     expected restricted __be32 [usertype] id
   drivers/pnp/isapnp/core.c:392:31: sparse:     got unsigned int [assigned] [usertype] eisa_id
   drivers/pnp/isapnp/core.c:605:55: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 [usertype] id @@     got unsigned int [assigned] [usertype] eisa_id @@
   drivers/pnp/isapnp/core.c:605:55: sparse:     expected restricted __be32 [usertype] id
   drivers/pnp/isapnp/core.c:605:55: sparse:     got unsigned int [assigned] [usertype] eisa_id
   drivers/pnp/isapnp/core.c:768:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 [usertype] id @@     got unsigned int [assigned] [usertype] eisa_id @@
   drivers/pnp/isapnp/core.c:768:39: sparse:     expected restricted __be32 [usertype] id
   drivers/pnp/isapnp/core.c:768:39: sparse:     got unsigned int [assigned] [usertype] eisa_id

vim +392 drivers/pnp/isapnp/core.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  378  
^1da177e4c3f415 Linus Torvalds 2005-04-16  379  /*
^1da177e4c3f415 Linus Torvalds 2005-04-16  380   *  Parse logical device tag.
^1da177e4c3f415 Linus Torvalds 2005-04-16  381   */
9dd78466c956ac4 Bjorn Helgaas  2007-07-26  382  static struct pnp_dev *__init isapnp_parse_device(struct pnp_card *card,
9dd78466c956ac4 Bjorn Helgaas  2007-07-26  383  						  int size, int number)
^1da177e4c3f415 Linus Torvalds 2005-04-16  384  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  385  	unsigned char tmp[6];
^1da177e4c3f415 Linus Torvalds 2005-04-16  386  	struct pnp_dev *dev;
25eb846189d20db Bjorn Helgaas  2008-04-28  387  	u32 eisa_id;
25eb846189d20db Bjorn Helgaas  2008-04-28  388  	char id[8];
^1da177e4c3f415 Linus Torvalds 2005-04-16  389  
^1da177e4c3f415 Linus Torvalds 2005-04-16  390  	isapnp_peek(tmp, size);
25eb846189d20db Bjorn Helgaas  2008-04-28  391  	eisa_id = tmp[0] | tmp[1] << 8 | tmp[2] << 16 | tmp[3] << 24;
25eb846189d20db Bjorn Helgaas  2008-04-28 @392  	pnp_eisa_id_to_string(eisa_id, id);
bda1e4e5a3d9760 Bjorn Helgaas  2008-04-28  393  
bda1e4e5a3d9760 Bjorn Helgaas  2008-04-28  394  	dev = pnp_alloc_dev(&isapnp_protocol, number, id);
bda1e4e5a3d9760 Bjorn Helgaas  2008-04-28  395  	if (!dev)
bda1e4e5a3d9760 Bjorn Helgaas  2008-04-28  396  		return NULL;
bda1e4e5a3d9760 Bjorn Helgaas  2008-04-28  397  
^1da177e4c3f415 Linus Torvalds 2005-04-16  398  	dev->card = card;
^1da177e4c3f415 Linus Torvalds 2005-04-16  399  	dev->capabilities |= PNP_CONFIGURABLE;
^1da177e4c3f415 Linus Torvalds 2005-04-16  400  	dev->capabilities |= PNP_READ;
^1da177e4c3f415 Linus Torvalds 2005-04-16  401  	dev->capabilities |= PNP_WRITE;
^1da177e4c3f415 Linus Torvalds 2005-04-16  402  	dev->capabilities |= PNP_DISABLE;
f44900020926b2c Bjorn Helgaas  2008-04-28  403  	pnp_init_resources(dev);
^1da177e4c3f415 Linus Torvalds 2005-04-16  404  	return dev;
^1da177e4c3f415 Linus Torvalds 2005-04-16  405  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  406  

:::::: The code at line 392 was first introduced by commit
:::::: 25eb846189d20db4114cebf14fee96d69bef4667 PNP: add pnp_eisa_id_to_string()

:::::: TO: Bjorn Helgaas <bjorn.helgaas@hp.com>
:::::: CC: Len Brown <len.brown@intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
