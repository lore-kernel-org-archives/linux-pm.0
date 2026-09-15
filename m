Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43271632DD;
	Tue, 15 Sep 2026 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513818; cv=none; b=Es7e432wpxSFth3bwONBuvBedGItJZPnNZXqRpyp+tPB+rMuLgJbPGOV3cwU1ko7ae6bQ7v2hApamb2e8qlSO1l73vyQVo0ggnzv0UngnMYm9G8d9Su7nMb1DISC1Q6UL5Kw36359u3e7mJUzqH0oTxwHALD/JXJHL4JJuFVuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513818; c=relaxed/simple;
	bh=RZq3Kt1ydl4Q+l9LF+oJVyPrfu7FdAXaIkAf7BjmzoY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ek8nK9HoM1z9xd19pki2iWdlgO6H9dfeqtxC/of3vC1R6EoGs2GtWFQKbv4whE4TxoSgosuLM9+3Qq0LHzzX0f44KDqgdAU9RlmV/oW+dl7ZkaOfZsfS8onmJOU6WaTuZ9qZSBQhnXbYAYuYIJNoR+1+DE8Vbwq1khzfMKdrnQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpzwGR7S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpzwGR7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789513817; x=1821049817;
  h=date:from:to:cc:subject:message-id;
  bh=RZq3Kt1ydl4Q+l9LF+oJVyPrfu7FdAXaIkAf7BjmzoY=;
  b=ZpzwGR7Shq9xP2Gkrj/SXXnsqCyhgoUyTyyccFXo+H31OLDXlZRlLXRR
   kDbjsgXLeXqjyj+kLMeR8nI8CANjxrYmh6kesBbjJs7n1AqxKnRx1YHNI
   Xm/efdPRPSG6gyBVJMVQ9jCnZzTrEiaq8DK2/PIFDWFLpr210YlasOJjE
   b7H+mr8UTkVyc0t9uPEVvL7UwAtltsYfmBmy6G8doGuTU6oeJmTUPUR+0
   0OLP4d+5UC+kAmuZgkJE928itOGAM05l6ZdpqgrCOr758I+2uuZJSUKsE
   MZGAW5scg7jzsuKZ9SXGelJB+H8O5f75Q98dIQ9OqXXNgDYzQFCIBp9Z4
   Q==;
X-CSE-ConnectionGUID: 5wOJEw5xSkaZOebyrVdjMg==
X-CSE-MsgGUID: MbfNCiM5Sryeolvh0ywXuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100552586"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100552586"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:10:16 -0700
X-CSE-ConnectionGUID: L8Cq+e0BSPW5JWIQhBQASw==
X-CSE-MsgGUID: OceGY1NsSjGoFqpOVue9ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298209724"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 16:10:14 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6cI0-0000000059h-0ZRM;
	Tue, 15 Sep 2026 23:10:12 +0000
Date: Wed, 16 Sep 2026 07:10:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 92/100]
 sound/soc/loongson/loongson_card.c:206:46: error: implicit declaration of
 function 'acpi_bus_get_primary_device'; did you mean 'acpi_get_gpe_device'?
Message-ID: <202609160705.vk4ADT7O-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   c4effca721d9748be701b3c3b8a666b380b2a4e5
commit: 6527c23fee030337d74b3b4becef50bf6d68cecc [92/100] ASoC: loongson: Switch to use acpi_bus_get_primary_device()
config: arc-randconfig-001-20260916 (https://download.01.org/0day-ci/archive/20260916/202609160705.vk4ADT7O-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260916/202609160705.vk4ADT7O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609160705.vk4ADT7O-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   sound/soc/loongson/loongson_card.c: In function 'loongson_card_parse_acpi':
>> sound/soc/loongson/loongson_card.c:206:46: error: implicit declaration of function 'acpi_bus_get_primary_device'; did you mean 'acpi_get_gpe_device'? [-Werror=implicit-function-declaration]
     struct device *phy_dev __free(put_device) = acpi_bus_get_primary_device(adev);
                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                 acpi_get_gpe_device
>> sound/soc/loongson/loongson_card.c:206:46: warning: initialization of 'struct device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


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
