Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A53ECBDA;
	Tue, 15 Sep 2026 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441538; cv=none; b=Jc2ILDBwhxaWRfiKSpIOi2DfzolOjLhAzOeZGsnu8CLP1K37nlYB4fpXTon/YBODtQCmz5n1u+57EjX1Vvtk/PfUldF72XASPFH32MuBDHZV+ukrekz91VRYEo9hsXox48kj+zHR7xHY5d/jkFGNZZai1HA09kerdAbFi7DHaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441538; c=relaxed/simple;
	bh=4mkIJoJNOJRtXhhuuN9Q/eceM46ZXH9X/o/xcepPTnE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i+KKnmHvENJjGNzdiD6lOpzqou+RKXfhxDEDi3CVE6zqZpZ/SjFapqUJTu1u+WYZ2VjTPfROHN5k+/NuEVmTXaodYR5MP4455YbE1FQaYaRCI6WQ/i2bhQZ+NAXPRHwBI4Qzhu1UFauE14/6tFpdQtKX9it/0ikEQ3iy+VKq+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlEGIx7s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlEGIx7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789441537; x=1820977537;
  h=date:from:to:cc:subject:message-id;
  bh=4mkIJoJNOJRtXhhuuN9Q/eceM46ZXH9X/o/xcepPTnE=;
  b=UlEGIx7sqkCV8gCmIlU60nUnMnHpjSAl+Y1v8aG5pGVEMI4Y0HR5vIn2
   J7vebxSdrA+YvkH7dhGHb4eaNIxqvr3EYhlcH4p0pIRe+cCKuSb3VpXli
   sJ2EI0iGEcGeZAH191y+iNGwkfuvhQERdH8i3OdCquWGMx72Zxr0V3TXX
   d64J5GrVlc96i5ZryhkUyMUBAjzULG7ahF6v6sp4LO7TmW9xsIYFWaqtS
   5g7hqQdRMnvjE4O+336bmTxl+1gS5ViXMhGYCpMuFZYYnJn9DY2xQUBaU
   AsQtbwM5OEzOMUp6D/FNPYFAOG90AoNo0dUSqDmzs/3FEchs0eKHmZCq5
   w==;
X-CSE-ConnectionGUID: aHLvoQrYRL+v82I5Cqymhw==
X-CSE-MsgGUID: mT18UYjxQMaES0ULzp5JkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89639870"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89639870"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 20:05:36 -0700
X-CSE-ConnectionGUID: NDHNewW7TWegvOp8NZpqGg==
X-CSE-MsgGUID: 9VfeY8PrQCiNvX6lxoiB3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269539888"
Received: from igk-lkp-server01.igk.intel.com (HELO 71151d66d536) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 14 Sep 2026 20:05:35 -0700
Received: from kbuild by 71151d66d536 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6JUC-000000000Tr-3GYp;
	Tue, 15 Sep 2026 03:05:32 +0000
Date: Tue, 15 Sep 2026 05:04:40 +0200
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 84/100]
 drivers/thunderbolt/acpi.c:31:6: warning: variable 'dev' is used
 uninitialized whenever 'if' condition is true
Message-ID: <202609150550.ZyqBeGWm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c4effca721d9748be701b3c3b8a666b380b2a4e5
commit: b9097c67f26d601c7585c1765ccd9984cc1d67bf [84/100] thunderbolt: Switch to use acpi_bus_get_primary_device()
config: i386-randconfig-051-20260915 (https://download.01.org/0day-ci/archive/20260915/202609150550.ZyqBeGWm-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260915/202609150550.ZyqBeGWm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609150550.ZyqBeGWm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thunderbolt/acpi.c:31:6: warning: variable 'dev' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
      31 |         if (dev_fwnode(nhi->dev) != fwnode)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/property.h:36:2: note: expanded from macro 'dev_fwnode'
      36 |         _Generic((dev),                                                 \
         |         ^
   drivers/thunderbolt/acpi.c:77:13: note: uninitialized use occurs here
      77 |         put_device(dev);
         |                    ^~~
   drivers/thunderbolt/acpi.c:31:2: note: remove the 'if' if its condition is always false
      31 |         if (dev_fwnode(nhi->dev) != fwnode)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      32 |                 goto out_put;
         |                 ~~~~~~~~~~~~
   drivers/thunderbolt/acpi.c:21:20: note: initialize the variable 'dev' to silence this warning
      21 |         struct device *dev;
         |                           ^
         |                            = NULL
   1 warning generated.


vim +31 drivers/thunderbolt/acpi.c

b2be2b05cf3b1c Mika Westerberg   2019-04-02  13  
b2be2b05cf3b1c Mika Westerberg   2019-04-02  14  static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
408e1d965a1d5f Mika Westerberg   2022-12-27  15  				    void **ret)
b2be2b05cf3b1c Mika Westerberg   2019-04-02  16  {
7f7b571becf373 Rafael J. Wysocki 2022-02-01  17  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
b2be2b05cf3b1c Mika Westerberg   2019-04-02  18  	struct fwnode_handle *fwnode;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  19  	struct tb_nhi *nhi = data;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  20  	struct pci_dev *pdev;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  21  	struct device *dev;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  22  
7f7b571becf373 Rafael J. Wysocki 2022-02-01  23  	if (!adev)
b2be2b05cf3b1c Mika Westerberg   2019-04-02  24  		return AE_OK;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  25  
2ae18cc2269fc2 Heikki Krogerus   2022-10-24  26  	fwnode = fwnode_find_reference(acpi_fwnode_handle(adev), "usb4-host-interface", 0);
2ae18cc2269fc2 Heikki Krogerus   2022-10-24  27  	if (IS_ERR(fwnode))
b2be2b05cf3b1c Mika Westerberg   2019-04-02  28  		return AE_OK;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  29  
b2be2b05cf3b1c Mika Westerberg   2019-04-02  30  	/* It needs to reference this NHI */
8c3ff7c5ae15cc Konrad Dybcio     2026-05-21 @31  	if (dev_fwnode(nhi->dev) != fwnode)
b2be2b05cf3b1c Mika Westerberg   2019-04-02  32  		goto out_put;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  33  
b2be2b05cf3b1c Mika Westerberg   2019-04-02  34  	/*
f20998f23a8ce3 Mathias Nyman     2024-08-30  35  	 * Ignore USB3 ports here as USB core will set up device links between
f20998f23a8ce3 Mathias Nyman     2024-08-30  36  	 * tunneled USB3 devices and NHI host during USB device creation.
f20998f23a8ce3 Mathias Nyman     2024-08-30  37  	 * USB3 ports might not even have a physical device yet if xHCI driver
f20998f23a8ce3 Mathias Nyman     2024-08-30  38  	 * isn't bound yet.
b2be2b05cf3b1c Mika Westerberg   2019-04-02  39  	 */
b9097c67f26d60 Rafael J. Wysocki 2026-09-14  40  	dev = acpi_bus_get_primary_device(adev);
f20998f23a8ce3 Mathias Nyman     2024-08-30  41  	if (!dev || !dev_is_pci(dev))
b2be2b05cf3b1c Mika Westerberg   2019-04-02  42  		goto out_put;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  43  
f20998f23a8ce3 Mathias Nyman     2024-08-30  44  	/* Check that this matches a PCIe root/downstream port. */
b2be2b05cf3b1c Mika Westerberg   2019-04-02  45  	pdev = to_pci_dev(dev);
f20998f23a8ce3 Mathias Nyman     2024-08-30  46  	if (pci_is_pcie(pdev) &&
b2be2b05cf3b1c Mika Westerberg   2019-04-02  47  	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
f20998f23a8ce3 Mathias Nyman     2024-08-30  48  	     pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
b2be2b05cf3b1c Mika Westerberg   2019-04-02  49  		const struct device_link *link;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  50  
f3380cac0c0b3a Mika Westerberg   2021-11-14  51  		/*
f3380cac0c0b3a Mika Westerberg   2021-11-14  52  		 * Make them both active first to make sure the NHI does
f3380cac0c0b3a Mika Westerberg   2021-11-14  53  		 * not runtime suspend before the consumer. The
f3380cac0c0b3a Mika Westerberg   2021-11-14  54  		 * pm_runtime_put() below then allows the consumer to
f3380cac0c0b3a Mika Westerberg   2021-11-14  55  		 * runtime suspend again (which then allows NHI runtime
f3380cac0c0b3a Mika Westerberg   2021-11-14  56  		 * suspend too now that the device link is established).
f3380cac0c0b3a Mika Westerberg   2021-11-14  57  		 */
f3380cac0c0b3a Mika Westerberg   2021-11-14  58  		pm_runtime_get_sync(&pdev->dev);
f3380cac0c0b3a Mika Westerberg   2021-11-14  59  
8c3ff7c5ae15cc Konrad Dybcio     2026-05-21  60  		link = device_link_add(&pdev->dev, nhi->dev,
b2be2b05cf3b1c Mika Westerberg   2019-04-02  61  				       DL_FLAG_AUTOREMOVE_SUPPLIER |
f3380cac0c0b3a Mika Westerberg   2021-11-14  62  				       DL_FLAG_RPM_ACTIVE |
b2be2b05cf3b1c Mika Westerberg   2019-04-02  63  				       DL_FLAG_PM_RUNTIME);
b2be2b05cf3b1c Mika Westerberg   2019-04-02  64  		if (link) {
8c3ff7c5ae15cc Konrad Dybcio     2026-05-21  65  			dev_dbg(nhi->dev, "created link from %s\n",
b2be2b05cf3b1c Mika Westerberg   2019-04-02  66  				dev_name(&pdev->dev));
408e1d965a1d5f Mika Westerberg   2022-12-27  67  			*(bool *)ret = true;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  68  		} else {
8c3ff7c5ae15cc Konrad Dybcio     2026-05-21  69  			dev_warn(nhi->dev, "device link creation from %s failed\n",
b2be2b05cf3b1c Mika Westerberg   2019-04-02  70  				 dev_name(&pdev->dev));
b2be2b05cf3b1c Mika Westerberg   2019-04-02  71  		}
f3380cac0c0b3a Mika Westerberg   2021-11-14  72  
f3380cac0c0b3a Mika Westerberg   2021-11-14  73  		pm_runtime_put(&pdev->dev);
b2be2b05cf3b1c Mika Westerberg   2019-04-02  74  	}
b2be2b05cf3b1c Mika Westerberg   2019-04-02  75  
b2be2b05cf3b1c Mika Westerberg   2019-04-02  76  out_put:
b9097c67f26d60 Rafael J. Wysocki 2026-09-14  77  	put_device(dev);
2ae18cc2269fc2 Heikki Krogerus   2022-10-24  78  	fwnode_handle_put(fwnode);
b2be2b05cf3b1c Mika Westerberg   2019-04-02  79  	return AE_OK;
b2be2b05cf3b1c Mika Westerberg   2019-04-02  80  }
b2be2b05cf3b1c Mika Westerberg   2019-04-02  81  

:::::: The code at line 31 was first introduced by commit
:::::: 8c3ff7c5ae15cc71000f10f4d0f26669b9471faa thunderbolt: Move pci_device out of tb_nhi

:::::: TO: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
:::::: CC: Mika Westerberg <mika.westerberg@linux.intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
