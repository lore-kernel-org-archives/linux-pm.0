Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364418;
	b=VfqBRDnnqzi1lJlzbwFWtRUbm04OmJuODw745mgvOjBXewSgMqUsH7qPUKPlgXrF/4/i
	 fLD11/5yj1NY9ITdwRBDED7tGgOohvse+ut8Ai5+NYXCZrf9DAqCj3T8lWj8zm3bEZKG3
	 ONd5QrfNIPrRVA7M/9ZIzmZaH3xZ2lxjG11JkTojEgx4UhSLbwlKpQPz/ekURNqZCKRNu
	 2kcTYwT4pEYGTkGqbcKc+cu1eaFNSSRENTvj7cNPWZV4Eexvztww12aNYJXM8MvKdcTGM
	 ATPdAcGfEoc1C6KbVvLNrjFjMWzWTVBX3H8nzeG6572SP9cbcRmGPCuQvfhO1kf5vAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364418;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ol9buaURzmW+aC8m44JQOZJHBB9zfvr6i45XcRPM0I0=;
	b=VOg81lStLekHvrnFuN/Z6kAQ/Vi7hSUhctNKDICyNjosf31meWdbLlhCtpbpW1gmEnYw
	 Dx8AsPT9uggaJxqymq1EXO3R26uHPXHT2qlQzR+xr5qTNxy4DQ2fOOyFB1OW9/o7seXeS
	 hEwozyTJGh2OfffxjNkaQlH54fbkGjN3zN6smayP5/iKitwnCb/qg4fP4xw7eWrwvEMLk
	 6gm+/WMnMqQKnrNpQT1Yzhc+h1by3bpl7e3fHGdRXjPxpiVvjRNq8z4k/Ci+COxrdqHAg
	 2CuStAKI601kns2WV9weRfPJAR+w73huS1mlNxzJtV6XPPULPQ4V8CWHhXkXHhsEK2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NlvdoeO5;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A595606A326;
	Wed, 11 Nov 2026 02:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A595606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NlvdoeO5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794364418; x=1825900418;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=s50BGaztiCB0EzWNAhapCTAYgc3gMULj1sAImxm0lKM=;
  b=NlvdoeO5eUgQOMgM1GIxwW6Y9y65iMT//kIdxByMcEQpnqva4v8i1ett
   N8N7j3qOsQ9c1pI9bSk2F3YYY9tLspX49uzA1xmL6v7NZYLddzdMeGH0n
   U07XyImgYmJWY14uk1Fl2w7PNH9eAf+4sbV4TZNQsst7uWah9c5FEy+a0
   nrxqPbvNHO/luLwTxjVLh58OEmW/2U+V0jcm28zK73CYUilTqVyGNFcso
   XjxL93Fk6Ug/Z2C7wqgTVwI2bvXqNT0X3vGGAQpIv66VnXTXkGZOIjuuY
   VohAs2wk9cHtOGKE6PkQ2IpoyR1TSa/BZztAbdhl1dmwhtRrJ4fAaLsJZ
   g==;
X-CSE-ConnectionGUID: N1VJIf3MTIGCWih/hv4ApA==
X-CSE-MsgGUID: N7y3GpAfRoulJyFPbpgdFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3154557"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3154557"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 18:33:38 -0800
X-CSE-ConnectionGUID: f4snPYusRHCUXzwqjL+OLg==
X-CSE-MsgGUID: V60PV1sLSSuuWsGufj2wSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8219921"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 10 Nov 2026 18:33:37 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQy9V-00000000xw3-3Vdd;
	Wed, 11 Nov 2026 02:33:33 +0000
Date: Wed, 11 Nov 2026 10:33:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 9/22]
 drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declaration
 of function 'devm_battery_hook_register'; did you mean
 'acpi_battery_hook_register'?
Message-ID: <202611111027.YYwIlIDB-lkp@intel.com>
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
config: x86_64-randconfig-1011-20261111 (https://download.01.org/0day-ci/ar=
chive/20261111/202611111027.YYwIlIDB-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20261111/202611111027.YYwIlIDB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111027.YYwIlIDB-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/acer-wmi-battery.c: In function 'acer_wmi_battery_p=
robe':
>> drivers/platform/x86/acer-wmi-battery.c:292:16: error: implicit declarat=
ion of function 'devm_battery_hook_register'; did you mean 'acpi_battery_ho=
ok_register'? [-Wimplicit-function-declaration]
     292 |         return devm_battery_hook_register(&data->wdev->dev, &dat=
a->hook);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                acpi_battery_hook_register


vim +292 drivers/platform/x86/acer-wmi-battery.c

c72dd9994952eb Jelle van der Waa 2026-09-13  275 =20
c72dd9994952eb Jelle van der Waa 2026-09-13  276  static int acer_wmi_batte=
ry_probe(struct wmi_device *wdev, const void *context)
c72dd9994952eb Jelle van der Waa 2026-09-13  277  {
c72dd9994952eb Jelle van der Waa 2026-09-13  278  	struct acer_wmi_battery_=
data *data;
c72dd9994952eb Jelle van der Waa 2026-09-13  279 =20
4dd10fbbeb9c33 Kees Cook         2026-10-28  280  	data =3D devm_kzalloc_ob=
j(&wdev->dev, *data);
c72dd9994952eb Jelle van der Waa 2026-09-13  281  	if (!data)
c72dd9994952eb Jelle van der Waa 2026-09-13  282  		return -ENOMEM;
c72dd9994952eb Jelle van der Waa 2026-09-13  283 =20
c72dd9994952eb Jelle van der Waa 2026-09-13  284  	dev_set_drvdata(&wdev->d=
ev, data);
c72dd9994952eb Jelle van der Waa 2026-09-13  285  	data->wdev =3D wdev;
c72dd9994952eb Jelle van der Waa 2026-09-13  286  	data->battery_ext =3D he=
alth_mode ? &acer_wmi_battery_extension_v2
c72dd9994952eb Jelle van der Waa 2026-09-13  287  					: &acer_wmi_battery_=
extension_v1;
c72dd9994952eb Jelle van der Waa 2026-09-13  288  	data->hook.name =3D "Ace=
r Battery Extension";
c72dd9994952eb Jelle van der Waa 2026-09-13  289  	data->hook.add_battery =
=3D acer_battery_add;
c72dd9994952eb Jelle van der Waa 2026-09-13  290  	data->hook.remove_batter=
y =3D acer_battery_remove;
c72dd9994952eb Jelle van der Waa 2026-09-13  291 =20
c72dd9994952eb Jelle van der Waa 2026-09-13 @292  	return devm_battery_hook=
_register(&data->wdev->dev, &data->hook);
c72dd9994952eb Jelle van der Waa 2026-09-13  293  }
c72dd9994952eb Jelle van der Waa 2026-09-13  294 =20

:::::: The code at line 292 was first introduced by commit
:::::: c72dd9994952eb09442827caecb945474ae3072b platform/x86: add Acer batt=
ery control driver

:::::: TO: Jelle van der Waa <jelle@vdwaa.nl>
:::::: CC: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
