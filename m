Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6DA59C995;
	Thu, 17 Sep 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656261; cv=none; b=mWWVllJlGUXp+Y40aa83pijdBa2EP/at/jaUrPZhmMuClgIXvzOOwC3tgSIxRtKd6eiu20mICDpy1GTZ9qwikJS+kC0mRBdO9JbE8rrpKGA2EkNENfwDIYNzI2UbwQZ1Los4n59GUqWXp5cn7FUeKgeta0zhawB6qsuNi/8S0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656261; c=relaxed/simple;
	bh=fgOcdHPD2TZKgufAHTVhqcVWGrvfpBid9Xt/WoiDt64=;
	h=Date:From:To:Cc:Subject:Message-ID; b=u5fOnbbK+TT14JMQ/PIgDug21dWRch41cxeOcyMPxO9j8Zcy0LSnRmvTOpAsCW0FkM2MsF9/XOmnX65NiSm41BxA68xr+Lx0pxp4xPOke5ISXGorePsIvnqBRUIHEO6FvdNJcZrjH9cst6YSLQL6z3BdXOkx1Y5zBw1Eg+qWqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFgoLF5c; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFgoLF5c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789656255; x=1821192255;
  h=date:from:to:cc:subject:message-id;
  bh=fgOcdHPD2TZKgufAHTVhqcVWGrvfpBid9Xt/WoiDt64=;
  b=XFgoLF5cu6qP0rxTJFnpzblQRuDJ8IDhzeRdxUTeYFzrLNCOuk9YaRaV
   9mWXd5acIq/Ui4yocl+yuvxoMu6VXB/ulbVrcfq412E1qq0BX8TxoxJex
   2EHFlSyg94xIsARi585MBluHMfxfX3x8vSsoStz980e+vbyL9yQQdd/Qe
   0FGJVwJAMKXf3/leHk0wOYD5XLx30mRYodUEgurWEM+yF88gqr/55Dn4j
   Tgx4Q8Yg1UwSPd7xtKgbmzdOfEo3jEpG/fQf8SdO992+RuYSvLNNOYdjB
   ORs+yf3T3tdbx1krCMhBC0Hg+y6d3VyKq4pbu+F9Q9KCAjMNaWMxIgKMg
   w==;
X-CSE-ConnectionGUID: zLlKGjqdQ3Cf4U265JfJBA==
X-CSE-MsgGUID: zhYBbcVSRpWh9+PxUBhoAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90102624"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90102624"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 07:44:07 -0700
X-CSE-ConnectionGUID: 7aedmUayT/i13+JrZkoftA==
X-CSE-MsgGUID: mlCPDRp6QO2CB7ncgRjX8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269567570"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 07:44:05 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7DLH-0000000080V-1V71;
	Thu, 17 Sep 2026 14:44:03 +0000
Date: Thu, 17 Sep 2026 22:43:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 84/106]
 drivers/bluetooth/btintel.c:2725:7: error: implicit declaration of function
 'acpi_has_method'; did you mean 'acpi_has_watchdog'?
Message-ID: <202609172243.uPgiesDR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   7d81fd7f1644e8172350caa5b32aa00e57050ec0
commit: b732fbc37b8eaacdb07b9463a45728b5152e1028 [84/106] ACPI: bus: Use acpi/acpi_bus.h without CONFIG_ACPI
config: sparc-randconfig-1000-20260917 (https://download.01.org/0day-ci/archive/20260917/202609172243.uPgiesDR-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609172243.uPgiesDR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609172243.uPgiesDR-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/bluetooth/btintel.c: In function 'btintel_set_dsm_reset_method':
>> drivers/bluetooth/btintel.c:2725:7: error: implicit declaration of function 'acpi_has_method'; did you mean 'acpi_has_watchdog'? [-Werror=implicit-function-declaration]
     if (!acpi_has_method(handle, "_PRR")) {
          ^~~~~~~~~~~~~~~
          acpi_has_watchdog
   cc1: some warnings being treated as errors


vim +2725 drivers/bluetooth/btintel.c

8f0a3786f56d9fa Kiran K 2023-06-11  2705  
8f0a3786f56d9fa Kiran K 2023-06-11  2706  static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
8f0a3786f56d9fa Kiran K 2023-06-11  2707  					 struct intel_version_tlv *ver_tlv)
8f0a3786f56d9fa Kiran K 2023-06-11  2708  {
8f0a3786f56d9fa Kiran K 2023-06-11  2709  	struct btintel_data *data = hci_get_priv(hdev);
8f0a3786f56d9fa Kiran K 2023-06-11  2710  	acpi_handle handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
8f0a3786f56d9fa Kiran K 2023-06-11  2711  	u8 reset_payload[4] = {0x01, 0x00, 0x01, 0x00};
8f0a3786f56d9fa Kiran K 2023-06-11  2712  	union acpi_object *obj, argv4;
8f0a3786f56d9fa Kiran K 2023-06-11  2713  	enum {
8f0a3786f56d9fa Kiran K 2023-06-11  2714  		RESET_TYPE_WDISABLE2,
8f0a3786f56d9fa Kiran K 2023-06-11  2715  		RESET_TYPE_VSEC
8f0a3786f56d9fa Kiran K 2023-06-11  2716  	};
8f0a3786f56d9fa Kiran K 2023-06-11  2717  
8f0a3786f56d9fa Kiran K 2023-06-11  2718  	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
8f0a3786f56d9fa Kiran K 2023-06-11  2719  
8f0a3786f56d9fa Kiran K 2023-06-11  2720  	if (!handle) {
8f0a3786f56d9fa Kiran K 2023-06-11  2721  		bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
8f0a3786f56d9fa Kiran K 2023-06-11  2722  		return;
8f0a3786f56d9fa Kiran K 2023-06-11  2723  	}
8f0a3786f56d9fa Kiran K 2023-06-11  2724  
8f0a3786f56d9fa Kiran K 2023-06-11 @2725  	if (!acpi_has_method(handle, "_PRR")) {
8f0a3786f56d9fa Kiran K 2023-06-11  2726  		bt_dev_err(hdev, "No support for _PRR ACPI method");
8f0a3786f56d9fa Kiran K 2023-06-11  2727  		return;
8f0a3786f56d9fa Kiran K 2023-06-11  2728  	}
8f0a3786f56d9fa Kiran K 2023-06-11  2729  
8f0a3786f56d9fa Kiran K 2023-06-11  2730  	switch (ver_tlv->cnvi_top & 0xfff) {
8f0a3786f56d9fa Kiran K 2023-06-11  2731  	case 0x910: /* GalePeak2 */
8f0a3786f56d9fa Kiran K 2023-06-11  2732  		reset_payload[2] = RESET_TYPE_VSEC;
8f0a3786f56d9fa Kiran K 2023-06-11  2733  		break;
8f0a3786f56d9fa Kiran K 2023-06-11  2734  	default:
8f0a3786f56d9fa Kiran K 2023-06-11  2735  		/* WDISABLE2 is the default reset method */
8f0a3786f56d9fa Kiran K 2023-06-11  2736  		reset_payload[2] = RESET_TYPE_WDISABLE2;
8f0a3786f56d9fa Kiran K 2023-06-11  2737  
8f0a3786f56d9fa Kiran K 2023-06-11  2738  		if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
8f0a3786f56d9fa Kiran K 2023-06-11  2739  				    BIT(DSM_SET_WDISABLE2_DELAY))) {
8f0a3786f56d9fa Kiran K 2023-06-11  2740  			bt_dev_err(hdev, "No dsm support to set reset delay");
8f0a3786f56d9fa Kiran K 2023-06-11  2741  			return;
8f0a3786f56d9fa Kiran K 2023-06-11  2742  		}
8f0a3786f56d9fa Kiran K 2023-06-11  2743  		argv4.integer.type = ACPI_TYPE_INTEGER;
8f0a3786f56d9fa Kiran K 2023-06-11  2744  		/* delay required to toggle BT power */
8f0a3786f56d9fa Kiran K 2023-06-11  2745  		argv4.integer.value = 160;
8f0a3786f56d9fa Kiran K 2023-06-11  2746  		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
8f0a3786f56d9fa Kiran K 2023-06-11  2747  					DSM_SET_WDISABLE2_DELAY, &argv4);
8f0a3786f56d9fa Kiran K 2023-06-11  2748  		if (!obj) {
8f0a3786f56d9fa Kiran K 2023-06-11  2749  			bt_dev_err(hdev, "Failed to call dsm to set reset delay");
8f0a3786f56d9fa Kiran K 2023-06-11  2750  			return;
8f0a3786f56d9fa Kiran K 2023-06-11  2751  		}
8f0a3786f56d9fa Kiran K 2023-06-11  2752  		ACPI_FREE(obj);
8f0a3786f56d9fa Kiran K 2023-06-11  2753  	}
8f0a3786f56d9fa Kiran K 2023-06-11  2754  
8f0a3786f56d9fa Kiran K 2023-06-11  2755  	bt_dev_info(hdev, "DSM reset method type: 0x%02x", reset_payload[2]);
8f0a3786f56d9fa Kiran K 2023-06-11  2756  
8f0a3786f56d9fa Kiran K 2023-06-11  2757  	if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
8f0a3786f56d9fa Kiran K 2023-06-11  2758  			    DSM_SET_RESET_METHOD)) {
8f0a3786f56d9fa Kiran K 2023-06-11  2759  		bt_dev_warn(hdev, "No support for dsm to set reset method");
8f0a3786f56d9fa Kiran K 2023-06-11  2760  		return;
8f0a3786f56d9fa Kiran K 2023-06-11  2761  	}
8f0a3786f56d9fa Kiran K 2023-06-11  2762  	argv4.buffer.type = ACPI_TYPE_BUFFER;
8f0a3786f56d9fa Kiran K 2023-06-11  2763  	argv4.buffer.length = sizeof(reset_payload);
8f0a3786f56d9fa Kiran K 2023-06-11  2764  	argv4.buffer.pointer = reset_payload;
8f0a3786f56d9fa Kiran K 2023-06-11  2765  
8f0a3786f56d9fa Kiran K 2023-06-11  2766  	obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
8f0a3786f56d9fa Kiran K 2023-06-11  2767  				DSM_SET_RESET_METHOD, &argv4);
8f0a3786f56d9fa Kiran K 2023-06-11  2768  	if (!obj) {
8f0a3786f56d9fa Kiran K 2023-06-11  2769  		bt_dev_err(hdev, "Failed to call dsm to set reset method");
8f0a3786f56d9fa Kiran K 2023-06-11  2770  		return;
8f0a3786f56d9fa Kiran K 2023-06-11  2771  	}
8f0a3786f56d9fa Kiran K 2023-06-11  2772  	ACPI_FREE(obj);
8f0a3786f56d9fa Kiran K 2023-06-11  2773  	data->acpi_reset_method = btintel_acpi_reset_method;
8f0a3786f56d9fa Kiran K 2023-06-11  2774  }
8f0a3786f56d9fa Kiran K 2023-06-11  2775  

:::::: The code at line 2725 was first introduced by commit
:::::: 8f0a3786f56d9fa4b308bdbd54757a51145dbb7a Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM

:::::: TO: Kiran K <kiran.k@intel.com>
:::::: CC: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
