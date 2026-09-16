Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13B22B8DF;
	Wed, 16 Sep 2026 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789518565; cv=none; b=Pl2kFP6pBC6CMeutZIdjgPA4lOmdSxbxo9oloA9rSqNjRxTvuDZp58ncse+FoGV07PAHNy7Y1v3KCN3jEBmg4dIDrMe+e/gR7cL3IbC+AttRLRtXxKn/vfsxW2bPkK6wcuwjAvicq9dhwwqzNC8QY98TRXPQbcwwzxF83vEElW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789518565; c=relaxed/simple;
	bh=Tz+tqRNn/aA1911kgrqYzfw8sthbUKwIqOh4k1kGZIc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N1QgbL/VK1dB5oQPf59aqqPYdJTPELn1edtrCIIytLaxtC8THOTaVBVxeDxHeRxgw8bD8GilvbZBHEoUFq4lq0Vi0C88KVWuHoyG91n8IaSBOKmXkEzemYhumbm7GArcf5pXdBKa8SBP9gFFr1nWCzZMfKhE8ZSx7EcEWRL0gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEQ4tpy1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEQ4tpy1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789518564; x=1821054564;
  h=date:from:to:cc:subject:message-id;
  bh=Tz+tqRNn/aA1911kgrqYzfw8sthbUKwIqOh4k1kGZIc=;
  b=eEQ4tpy1pBlUq4yjPKqPYHahzcS9z2/cJLBT5En6dWMD/fF0vHaXPYDT
   5p1dt6q/dmApUKJETL8sGg+NhJ8V+MPysl+jK4AA6vP5pVxp2m1R6NXCs
   1lw1Q48VSX6BL086+zpbY+YZoRsVHFdZvNLzlwdUs2oG2CLmnC/70QGhT
   VApG4/mj9X+H/y7whSd5s7akqr1kE+zNd/X7jX/XjlpksZy2jHP3SrwMC
   YGr621nQc4IXT+G73cB7tTgVqDq0QmUvxbjZ/EtWhSJtOgZECodLIhtOk
   NcAJyDnmY73wLZsgFkSsFju05DwAVsiXm4iJcVao8wXCaiAEyS9HMCa5n
   g==;
X-CSE-ConnectionGUID: +2L7rAO8TwiMG10AHpxDIQ==
X-CSE-MsgGUID: U7opoxCnSLKAzX7TxSztjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115431407"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115431407"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:29:23 -0700
X-CSE-ConnectionGUID: 4hkmRjNqS9iu4T6J0pAXhA==
X-CSE-MsgGUID: Cj5fT9G4SwaXFOi4+CdoMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="276924478"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Sep 2026 17:29:22 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6dWZ-000000005E5-0lzI;
	Wed, 16 Sep 2026 00:29:19 +0000
Date: Wed, 16 Sep 2026 08:28:33 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 92/100]
 sound/soc/loongson/loongson_card.c:206:53: error: initialization of 'struct
 device *' from 'int' makes pointer from integer without a cast
Message-ID: <202609160802.42lSCDhD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c4effca721d9748be701b3c3b8a666b380b2a4e5
commit: 6527c23fee030337d74b3b4becef50bf6d68cecc [92/100] ASoC: loongson: Switch to use acpi_bus_get_primary_device()
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260916/202609160802.42lSCDhD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260916/202609160802.42lSCDhD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609160802.42lSCDhD-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/soc/loongson/loongson_card.c: In function 'loongson_card_parse_acpi':
   sound/soc/loongson/loongson_card.c:206:53: error: implicit declaration of function 'acpi_bus_get_primary_device' [-Wimplicit-function-declaration]
     206 |         struct device *phy_dev __free(put_device) = acpi_bus_get_primary_device(adev);
         |                                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/loongson/loongson_card.c:206:53: error: initialization of 'struct device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]


vim +206 sound/soc/loongson/loongson_card.c

   193	
   194	static int loongson_card_parse_acpi(struct loongson_card_data *data)
   195	{
   196		struct snd_soc_card *card = &data->snd_card;
   197		const char *codec_dai_name;
   198		struct acpi_device *adev;
   199		int i, ret;
   200	
   201		/* fixup platform name based on reference node */
   202		adev = loongson_card_acpi_find_device(card, "cpu");
   203		if (!adev)
   204			return -ENOENT;
   205	
 > 206		struct device *phy_dev __free(put_device) = acpi_bus_get_primary_device(adev);
   207		if (!phy_dev)
   208			return -EPROBE_DEFER;
   209	
   210		/* fixup codec name based on reference node */
   211		adev = loongson_card_acpi_find_device(card, "codec");
   212		if (!adev)
   213			return -ENOENT;
   214		snprintf(codec_name, sizeof(codec_name), "i2c-%s", acpi_dev_name(adev));
   215	
   216		ret = device_property_read_string(card->dev, "codec-dai-name", &codec_dai_name);
   217		if (ret)
   218			return ret;
   219	
   220		for (i = 0; i < card->num_links; i++) {
   221			loongson_dai_links[i].platforms->name = dev_name(phy_dev);
   222			loongson_dai_links[i].codecs->name = codec_name;
   223			loongson_dai_links[i].codecs->dai_name = codec_dai_name;
   224		}
   225	
   226		return 0;
   227	}
   228	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
