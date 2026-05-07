Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED864508E5;
	Thu,  7 May 2026 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183861; cv=none; b=bGo40sP71dXGgewRRGUBBSB3YHw6FW96Buutd2zebyx4vmYCRHWu9zbQoUrhltN9Px7/M3e3Mi2ww1K7HbR5atJnty/FI/5bO4VSNNoxbYX9nOQgjrEoRmKjy5avmxM/oYv2I1r3lb5OwB8qtYpXyW+Cr0BH0DOgSrVkIubRo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183861; c=relaxed/simple;
	bh=34OJZhJ5yG++EW43nWqRAhv5Or5whGUi9gWAxb0QMZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f2WDmgD7x673jVrc+vyIPSE7dCjCfnQkYBuXnlV5XszH1Xne1FQiRaUp8oAatOmwgJudTbd8UKtLEaKVeik2UKCbT1aESgwQmYYOIAbDoXI0uiRX4/ebgsJLAcsv9Nn94Gv4Gg9B/XQ2iHOJnWwVyNrl/oTWXHrXjSEJn+yGCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pb6ocjBS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pb6ocjBS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778183860; x=1809719860;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=34OJZhJ5yG++EW43nWqRAhv5Or5whGUi9gWAxb0QMZo=;
  b=Pb6ocjBSUnQuNhfa5WbzlHuGs9O53rYm17JQX5nLrB6qvz6IneHUTyNP
   Oq7PXDP4B+O2nY5JmUj+vxGHwRo0/zqx/FS0H0V4xCoYXpLgT02qUVULi
   JzW9MfUs6983bSk/lT5cZlqkybNoPqEf5G21YHz+uzTqYneWiNXhm4Rw+
   4HY+2F2PMgpV27JynojJ32myGOlD2Cvu0JKyVAHlkKtgtGp+UpO3cDGAp
   6CA0dfAQcGOQ8dByDmNOA9pLFknRh7K8y18io3PfiiGqpi+havGdSUhwf
   b4SNP852XH2S+kRpx+pfosMFz5V37U0Z7P2vH/LBhChKp2U+6ES0kiynH
   g==;
X-CSE-ConnectionGUID: /fsY0rzlR8OxcTlJAtS8JQ==
X-CSE-MsgGUID: yhasLK1eT1+EycGuwZndnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89843711"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="89843711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 12:57:39 -0700
X-CSE-ConnectionGUID: gfg9R6fiRDmA/gZxfpFeUQ==
X-CSE-MsgGUID: bzow6c6WQoOZxBN1Wy1PMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="240549809"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 12:57:37 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wL4ql-000000000Pf-0KFw;
	Thu, 07 May 2026 19:57:35 +0000
Date: Fri, 08 May 2026 03:56:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 15/24]
 drivers/platform/x86/xo15-ebook.c:104:17: error: label 'err_free_input' used
 but not defined
Message-ID: <202605080333.a4CP1ejZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   232e74ed0633787ae1258c7d33ef7599210396ce
commit: f3f83acc4b2615dc2f4a25bc5bcca4af83cf0cae [15/24] platform/x86: xo15=
-ebook: Register ACPI notify handler directly
config: i386-buildonly-randconfig-004-20260507 (https://download.01.org/0da=
y-ci/archive/20260508/202605080333.a4CP1ejZ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260508/202605080333.a4CP1ejZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605080333.a4CP1ejZ-lkp@i=
ntel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/xo15-ebook.c: In function 'ebook_switch_add':
>> drivers/platform/x86/xo15-ebook.c:104:17: error: label 'err_free_input' =
used but not defined
     104 |                 goto err_free_input;
         |                 ^~~~


vim +/err_free_input +104 drivers/platform/x86/xo15-ebook.c

44cb98c48e19f5 Rafael J. Wysocki 2012-06-27   80 =20
89ca11771a4b50 Paul Fox          2011-02-03   81  static int ebook_switch_a=
dd(struct acpi_device *device)
89ca11771a4b50 Paul Fox          2011-02-03   82  {
39789590cff404 Andy Shevchenko   2023-10-10   83  	const struct acpi_device=
_id *id;
89ca11771a4b50 Paul Fox          2011-02-03   84  	struct ebook_switch *but=
ton;
89ca11771a4b50 Paul Fox          2011-02-03   85  	struct input_dev *input;
89ca11771a4b50 Paul Fox          2011-02-03   86  	int error;
89ca11771a4b50 Paul Fox          2011-02-03   87 =20
bf4afc53b77aea Linus Torvalds    2026-02-21   88  	button =3D kzalloc_obj(s=
truct ebook_switch);
89ca11771a4b50 Paul Fox          2011-02-03   89  	if (!button)
89ca11771a4b50 Paul Fox          2011-02-03   90  		return -ENOMEM;
89ca11771a4b50 Paul Fox          2011-02-03   91 =20
89ca11771a4b50 Paul Fox          2011-02-03   92  	device->driver_data =3D =
button;
89ca11771a4b50 Paul Fox          2011-02-03   93 =20
89ca11771a4b50 Paul Fox          2011-02-03   94  	button->input =3D input =
=3D input_allocate_device();
89ca11771a4b50 Paul Fox          2011-02-03   95  	if (!input) {
89ca11771a4b50 Paul Fox          2011-02-03   96  		error =3D -ENOMEM;
89ca11771a4b50 Paul Fox          2011-02-03   97  		goto err_free_button;
89ca11771a4b50 Paul Fox          2011-02-03   98  	}
89ca11771a4b50 Paul Fox          2011-02-03   99 =20
39789590cff404 Andy Shevchenko   2023-10-10  100  	id =3D acpi_match_acpi_d=
evice(ebook_device_ids, device);
39789590cff404 Andy Shevchenko   2023-10-10  101  	if (!id) {
39789590cff404 Andy Shevchenko   2023-10-10  102  		dev_err(&device->dev, "=
Unsupported hid\n");
89ca11771a4b50 Paul Fox          2011-02-03  103  		error =3D -ENODEV;
89ca11771a4b50 Paul Fox          2011-02-03 @104  		goto err_free_input;
89ca11771a4b50 Paul Fox          2011-02-03  105  	}
89ca11771a4b50 Paul Fox          2011-02-03  106 =20
8625c4c06a79dd Ilpo J=C3=A4rvinen     2025-04-07  107  	strscpy(acpi_device=
_name(device), XO15_EBOOK_DEVICE_NAME);
8625c4c06a79dd Ilpo J=C3=A4rvinen     2025-04-07  108  	strscpy(acpi_device=
_class(device), XO15_EBOOK_CLASS "/" XO15_EBOOK_SUBCLASS);
89ca11771a4b50 Paul Fox          2011-02-03  109 =20
39789590cff404 Andy Shevchenko   2023-10-10  110  	snprintf(button->phys, s=
izeof(button->phys), "%s/button/input0", id->id);
89ca11771a4b50 Paul Fox          2011-02-03  111 =20
8625c4c06a79dd Ilpo J=C3=A4rvinen     2025-04-07  112  	input->name =3D acp=
i_device_name(device);
89ca11771a4b50 Paul Fox          2011-02-03  113  	input->phys =3D button->=
phys;
89ca11771a4b50 Paul Fox          2011-02-03  114  	input->id.bustype =3D BU=
S_HOST;
89ca11771a4b50 Paul Fox          2011-02-03  115  	input->dev.parent =3D &d=
evice->dev;
89ca11771a4b50 Paul Fox          2011-02-03  116 =20
89ca11771a4b50 Paul Fox          2011-02-03  117  	input->evbit[0] =3D BIT_=
MASK(EV_SW);
89ca11771a4b50 Paul Fox          2011-02-03  118  	set_bit(SW_TABLET_MODE, =
input->swbit);
89ca11771a4b50 Paul Fox          2011-02-03  119 =20
89ca11771a4b50 Paul Fox          2011-02-03  120  	error =3D input_register=
_device(input);
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  121  	if (error) {
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  122  		input_free_device(input=
);
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  123  		goto err_free_button;
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  124  	}
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  125 =20
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  126  	error =3D acpi_dev_insta=
ll_notify_handler(device, ACPI_DEVICE_NOTIFY,
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  127  						ebook_switch_notify=
, device);
89ca11771a4b50 Paul Fox          2011-02-03  128  	if (error)
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  129  		goto err_unregister_inp=
ut;
89ca11771a4b50 Paul Fox          2011-02-03  130 =20
89ca11771a4b50 Paul Fox          2011-02-03  131  	ebook_send_state(device);
89ca11771a4b50 Paul Fox          2011-02-03  132 =20
89ca11771a4b50 Paul Fox          2011-02-03  133  	if (device->wakeup.flags=
.valid) {
89ca11771a4b50 Paul Fox          2011-02-03  134  		/* Button's GPE is run-=
wake GPE */
89ca11771a4b50 Paul Fox          2011-02-03  135  		acpi_enable_gpe(device-=
>wakeup.gpe_device,
89ca11771a4b50 Paul Fox          2011-02-03  136  				device->wakeup.gpe_nu=
mber);
89ca11771a4b50 Paul Fox          2011-02-03  137  		device_set_wakeup_enabl=
e(&device->dev, true);
89ca11771a4b50 Paul Fox          2011-02-03  138  	}
89ca11771a4b50 Paul Fox          2011-02-03  139 =20
89ca11771a4b50 Paul Fox          2011-02-03  140  	return 0;
89ca11771a4b50 Paul Fox          2011-02-03  141 =20
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  142  err_unregister_input:
f3f83acc4b2615 Rafael J. Wysocki 2026-02-09  143  	input_unregister_device(=
input);
89ca11771a4b50 Paul Fox          2011-02-03  144  err_free_button:
89ca11771a4b50 Paul Fox          2011-02-03  145  	kfree(button);
89ca11771a4b50 Paul Fox          2011-02-03  146  	return error;
89ca11771a4b50 Paul Fox          2011-02-03  147  }
89ca11771a4b50 Paul Fox          2011-02-03  148 =20

:::::: The code at line 104 was first introduced by commit
:::::: 89ca11771a4b50ed616ab6c37e0ef333d02f1d47 OLPC XO-1.5 ebook switch dr=
iver

:::::: TO: Paul Fox <pgf@laptop.org>
:::::: CC: Matthew Garrett <mjg@redhat.com>

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
