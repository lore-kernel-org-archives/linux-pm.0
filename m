Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385901;
	b=ULEMAWb/yPoON4ZiNgIld617MNdwTdhAnO93qP6/xyJhC7pXerHCNKgmpMJQew23tcrv
	 asoYbse4EBtnSlAGK2m+ONK+A0IbIVxYAOP8RxKOlLjpz6aYLIQITa6wizaLUbk4k41j2
	 6GZAGHekcnat8fkcuEaw9TP3vGe3pPiSz62DkJzsgUmEP1+68d/tzDqhei+4c2G2uTDtg
	 fuFZpAas2SS0lA1gpuY92utBgpiKZJkZetzKn4+7PcUAA/W02GKQrvfDucfMQX09fe57z
	 wvmBTvmfH8CUSksOe5Yk48clfpm7yV+5soNwvr9sOfhMUH3wr4VSmxhXI2Pq7OpjQ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385901;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fnpg8++pCSHxAySt0By1k1tE0/H2x/Ojwwrq0p+nEA0=;
	b=vL5uFoWPhjKUdVdlLrHFEmUGWyDFvW/Vpq7+TtURsMVUYkjp89sb9z10br1xsooAK03a
	 zSB5owXNHfCcDSEkFDFyGACIU/dCIOey1RsOeIf/kaEYrtusC6FIxtXiGKKexqnFXEPM/
	 pG9BiHChKHO8LOXqDqO2+4Qy69QBTzzBMKZwJHumn+ZFgZC1fG08ZWaIJWQT3/t5Isus+
	 rQF/AaBCy6q2b+nGMfwnznMRVR2rKlSHUzSu4PORtSL4Nz29F3F0NNCh62EaRSWz42nHi
	 y52EWXrwYAEpyv0xiQlS9tujZ36QJYAjmztu7qwLLl7fBEXdWORbTok5F4bF9UNH30Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AN7nsDIt;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1E606A324;
	Wed, 11 Nov 2026 08:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D1E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AN7nsDIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794385900; x=1825921900;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LuCmyYom3oMHL4Y2LbIgsHBortL/481HciQGfC98Plc=;
  b=AN7nsDItdX0WfIfaGhZiivGHT4AZJC3ERzqRlzhOj43daOarfgSUjfne
   JT0AfNlE3nVGOfERvcMgbDnKkV0Kq+hkuoLttdvHfmhOOAoZ1qZ+t2FQe
   qGxo17kNyZX9/aV+yXwwU+i9lroFfUpH+ESKkO5l45J4GT2XgZvixrTDJ
   x+fxLMGVisN9u+dCNqrNtOqNVfxNiWSfm8xeNngaT9qlTtTysuxiYpBlZ
   mF9/4/EL37NvQV88FR7qrRg6v7uNf9ZsuaC2Q/hvXc3fUw6FgdZiMFYET
   ae+IJmlvOnKgcHMw+wOsWHfU6fX4AydZ7qAGR3InxLhDXLYKMSwfK7Bpc
   Q==;
X-CSE-ConnectionGUID: IZ5WuyB0RAWa0p/F5pS9Xw==
X-CSE-MsgGUID: Ihlr/lMBQkSAXe5erjGXcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3036646"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3036646"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 00:31:40 -0800
X-CSE-ConnectionGUID: pRAqIq2NR/GTWPqaWdxA4Q==
X-CSE-MsgGUID: 9jk+JpjORiylE+j6NeYJPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8250021"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Nov 2026 00:31:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xR3k0-00000000yR3-1jHi;
	Wed, 11 Nov 2026 08:31:36 +0000
Date: Wed, 11 Nov 2026 16:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 9/22]
 drivers/platform/x86/acer-wmi-battery.c:292:9: error: call to undeclared
 function 'devm_battery_hook_register'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202611111639.D9pOcfbe-lkp@intel.com>
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
config: x86_64-randconfig-1000-20261111 (https://download.01.org/0day-ci/ar=
chive/20261111/202611111639.D9pOcfbe-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933=
e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20261111/202611111639.D9pOcfbe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611111639.D9pOcfbe-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/acer-wmi-battery.c:292:9: error: call to undeclared=
 function 'devm_battery_hook_register'; ISO C99 and later do not support im=
plicit function declarations [-Wimplicit-function-declaration]
     292 |         return devm_battery_hook_register(&data->wdev->dev, &dat=
a->hook);
         |                ^
   drivers/platform/x86/acer-wmi-battery.c:292:9: note: did you mean 'acpi_=
battery_hook_register'?
   include/acpi/battery.h:26:6: note: 'acpi_battery_hook_register' declared=
 here
      26 | void acpi_battery_hook_register(struct acpi_battery_hook *hook);
         |      ^
   1 error generated.


vim +/devm_battery_hook_register +292 drivers/platform/x86/acer-wmi-battery=
.c

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
