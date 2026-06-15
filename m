Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF6407576;
	Mon, 15 Jun 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538510; cv=none; b=ajD3MvnmGaWdgbsZFT6zbsy2B++/WjZApD5qCcFl8tW6Yu9SSb/Fcxqama/jQ3n0tMi0mQaUnAlWWwVak875ytamv1UR9qC7F83/eWnqmBu67Q/NBN5+PIvb9jyV9OWABbqtnA50VeMfkHHjv2CwIjpeag0cWBshzmyuf2mCk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538510; c=relaxed/simple;
	bh=btAje+m+vwXmU3T0PD7Wzm0Kq9kUQ+NR6IfXo98vWXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acMd7r2rDPP8zCkv3kxPDJ7RDuFbQD1sBPuiQW+39+hrB8E8M91QM9RpPQNBWxtdDVeuETTQD3WKsZTM0pIeCSKJjWlOU8PJvuS68Wau0jQ90bjoouXEp8cEP9MOYB/nE5mj4jjfTBKiL9rvGff73K+4c1MXSOyuDi0dwCT/rd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2cTh84q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2cTh84q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781538502; x=1813074502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=btAje+m+vwXmU3T0PD7Wzm0Kq9kUQ+NR6IfXo98vWXs=;
  b=E2cTh84qrjM+yOXFcBk85qCJnFemMU+Dw7TrQvLnHMQdG4Gg7o2XbBXd
   Yncpgwt8i/mxBvOysqk+ksZzPP89QDMMAHQYhoF8843HCtwvbcCNTno7u
   ALLxKhfsmAiZ+o1T2MsDzAPamase3KZEsQVnb9FtypTJWBDWVpCH3hPIT
   AvNusWqzaWX/NNlNaziYNpcpO61/aKcMOERaFyU8Yr5VTE8sV5RfxsuRI
   Kikuj+FvUWAdnfWjH82LaWdQxjLnsIwNhjzzTuCG+8tzkVtecd2VtaEbU
   Uiq4xK4ynAfzGKcRoVI2TFd9Hl6qx071vqkoJCtD8vtcok4I6gsIe91ZI
   A==;
X-CSE-ConnectionGUID: BUQ4OAIkRDiIxAyDv6auFw==
X-CSE-MsgGUID: 25hkajXZQ2SfeVI6C0Rhpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99858092"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="99858092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 08:48:21 -0700
X-CSE-ConnectionGUID: FMMEgbjeSseffmDZwvyXyA==
X-CSE-MsgGUID: zG1oTW/0Qs2NNXCjCBM4kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="247593376"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Jun 2026 08:48:17 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZ9Xq-00000000S1C-1jOi;
	Mon, 15 Jun 2026 15:48:14 +0000
Date: Mon, 15 Jun 2026 23:47:50 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Kees Cook <kees@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	pengpeng@iscas.ac.cn
Subject: Re: [PATCH] thermal: intel: int3400: clean up ODVP on probe failures
Message-ID: <202606152311.IuBPWDFs-lkp@intel.com>
References: <20260615070326.71761-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260615070326.71761-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v7.1 next-20260612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/thermal-intel-int3400-clean-up-ODVP-on-probe-failures/20260615-152757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20260615070326.71761-1-pengpeng%40iscas.ac.cn
patch subject: [PATCH] thermal: intel: int3400: clean up ODVP on probe failures
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260615/202606152311.IuBPWDFs-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260615/202606152311.IuBPWDFs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606152311.IuBPWDFs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/intel/int340x_thermal/int3400_thermal.c:651:1: warning: unused label 'free_imok' [-Wunused-label]
     651 | free_imok:
         | ^~~~~~~~~~
>> drivers/thermal/intel/int340x_thermal/int3400_thermal.c:659:1: warning: unused label 'free_art_trt' [-Wunused-label]
     659 | free_art_trt:
         | ^~~~~~~~~~~~~
   2 warnings generated.


vim +/free_imok +651 drivers/thermal/intel/int340x_thermal/int3400_thermal.c

0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  556  
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  557  static int int3400_thermal_probe(struct platform_device *pdev)
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  558  {
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  559  	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  560  	struct int3400_thermal_priv *priv;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  561  	int result;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  562  
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  563  	if (!adev)
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  564  		return -ENODEV;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  565  
bf4afc53b77aea drivers/thermal/intel/int340x_thermal/int3400_thermal.c Linus Torvalds      2026-02-21  566  	priv = kzalloc_obj(*priv);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  567  	if (!priv)
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  568  		return -ENOMEM;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  569  
006f006f1e5c48 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  570  	priv->pdev = pdev;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  571  	priv->adev = adev;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  572  
c5738dddc01be4 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  573  	result = int3400_thermal_get_uuids(priv);
8d485da0ddee79 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  574  
8d485da0ddee79 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  575  	/* Missing IDSP isn't fatal */
8d485da0ddee79 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  576  	if (result && result != -ENODEV)
c5738dddc01be4 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  577  		goto free_priv;
c5738dddc01be4 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  578  
8d485da0ddee79 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  579  	priv->current_uuid_index = -1;
8d485da0ddee79 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  580  
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  581  	result = acpi_parse_art(priv->adev->handle, &priv->art_count,
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  582  				&priv->arts, true);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  583  	if (result)
f126079123f9d0 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2015-02-25  584  		dev_dbg(&pdev->dev, "_ART table parsing error\n");
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  585  
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  586  	result = acpi_parse_trt(priv->adev->handle, &priv->trt_count,
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  587  				&priv->trts, true);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  588  	if (result)
f126079123f9d0 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2015-02-25  589  		dev_dbg(&pdev->dev, "_TRT table parsing error\n");
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  590  
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  591  	platform_set_drvdata(pdev, priv);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  592  
0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  593  	int3400_setup_gddv(priv);
0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  594  
006f006f1e5c48 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  595  	evaluate_odvp(priv);
006f006f1e5c48 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  596  
cbcd51e822bf51 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Rafael J. Wysocki   2023-08-30  597  	priv->thermal = thermal_tripless_zone_device_register("INT3400 Thermal", priv,
cbcd51e822bf51 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Rafael J. Wysocki   2023-08-30  598  							      &int3400_thermal_ops,
cbcd51e822bf51 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Rafael J. Wysocki   2023-08-30  599  							      &int3400_thermal_params);
0ab15365ff38c8 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  600  	if (IS_ERR(priv->thermal)) {
0ab15365ff38c8 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  601  		result = PTR_ERR(priv->thermal);
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  602  		goto free_odvp;
0ab15365ff38c8 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  603  	}
0ab15365ff38c8 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  604  
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  605  	priv->rel_misc_dev_res = acpi_thermal_rel_misc_device_add(
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  606  							priv->adev->handle);
6306e68a63f262 drivers/thermal/int340x_thermal/int3400_thermal.c       Jacob Pan           2014-06-12  607  
19ecaea2686222 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2014-12-02  608  	result = sysfs_create_group(&pdev->dev.kobj, &uuid_attribute_group);
19ecaea2686222 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2014-12-02  609  	if (result)
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  610  		goto free_rel_misc;
19ecaea2686222 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2014-12-02  611  
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16  612  	if (acpi_has_method(priv->adev->handle, "IMOK")) {
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16  613  		result = sysfs_create_group(&pdev->dev.kobj, &imok_attribute_group);
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16  614  		if (result)
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  615  			goto free_uuid;
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16  616  	}
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16  617  
7931e28098a4c1 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Lee, Chun-Yi        2022-08-08  618  	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
13f3cbfbb8c9f3 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Thomas Weißschuh    2024-11-21  619  		result = device_create_bin_file(&pdev->dev, &bin_attr_data_vault);
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  620  		if (result) {
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  621  			kfree(priv->data_vault);
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  622  			priv->data_vault = NULL;
0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  623  			goto free_uuid;
0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  624  		}
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  625  	}
0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  626  
38e44da591303d drivers/thermal/int340x_thermal/int3400_thermal.c       Brian Bian          2017-08-09  627  	result = acpi_install_notify_handler(
38e44da591303d drivers/thermal/int340x_thermal/int3400_thermal.c       Brian Bian          2017-08-09  628  			priv->adev->handle, ACPI_DEVICE_NOTIFY, int3400_notify,
38e44da591303d drivers/thermal/int340x_thermal/int3400_thermal.c       Brian Bian          2017-08-09  629  			(void *)priv);
38e44da591303d drivers/thermal/int340x_thermal/int3400_thermal.c       Brian Bian          2017-08-09  630  	if (result)
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  631  		goto free_sysfs;
38e44da591303d drivers/thermal/int340x_thermal/int3400_thermal.c       Brian Bian          2017-08-09  632  
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  633  	result = production_mode_init(priv);
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  634  	if (result)
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  635  		goto free_notify;
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  636  
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  637  	return 0;
19ecaea2686222 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2014-12-02  638  
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  639  free_notify:
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  640  	acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
5c36cf27846a36 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Srinivas Pandruvada 2023-01-23  641  				   int3400_notify);
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  642  free_sysfs:
006f006f1e5c48 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  643  	cleanup_odvp(priv);
e9a7c526c29b0a drivers/thermal/intel/int340x_thermal/int3400_thermal.c Rafael J. Wysocki   2022-08-30  644  	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
13f3cbfbb8c9f3 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Thomas Weißschuh    2024-11-21  645  		device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
006f006f1e5c48 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  646  		kfree(priv->data_vault);
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  647  		priv->data_vault = NULL;
006f006f1e5c48 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  648  	}
0ba13c763aacb2 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Matthew Garrett     2020-04-13  649  free_uuid:
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  650  	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16 @651  free_imok:
f1b07a14694be0 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Sumeet Pawnikar     2021-07-16  652  	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  653  free_rel_misc:
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  654  	if (!priv->rel_misc_dev_res)
0be86969ae385c drivers/thermal/int340x_thermal/int3400_thermal.c       Alexey Khoroshilov  2017-12-30  655  		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
19ecaea2686222 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2014-12-02  656  	thermal_zone_device_unregister(priv->thermal);
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  657  free_odvp:
19f67ce6d353c4 drivers/thermal/intel/int340x_thermal/int3400_thermal.c Pengpeng Hou        2026-06-15  658  	cleanup_odvp(priv);
f126079123f9d0 drivers/thermal/int340x_thermal/int3400_thermal.c       Srinivas Pandruvada 2015-02-25 @659  free_art_trt:
0ab15365ff38c8 drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-23  660  	kfree(priv->trts);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  661  	kfree(priv->arts);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  662  free_priv:
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  663  	kfree(priv);
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  664  	return result;
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  665  }
816cab931f288c drivers/thermal/int340x_thermal/int3400_thermal.c       Zhang Rui           2014-03-14  666  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
