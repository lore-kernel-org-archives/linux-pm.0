Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A547081A;
	Sun, 21 Jun 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078641; cv=none; b=QASuKdzhkz8KATc9uMps3sEgHIPcXlkHi4G74fId2ECOIjjTXzUWUNIjkuYH1e2C7ry29lv+5sCS2MBIGsSmXa5nMiwdg5xyEF+2oZX73OFgy275wVUC0f0D6/C061Iv2jSA/2WRzOpSdBGgDd8Tjuf5FPUoTtZ+O2Wv7/e8U/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078641; c=relaxed/simple;
	bh=/fJJkX/+8BvvzZo1p1vaUpSBU3H3Yn1TAUuW/XVtoHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vi1fwUwPAwYlPTkP+KxX9zZXQmd6i2IO3OA8kqE8h3VCICS1oqCeuYVToeWnCb2wS+CWc38Zl/xvn2pi/LvRJ7GHIfLV01ax3VoOEY8smIVGvKosDVECtg5cA8clAFhGsaomjxnu0VKJr417vF6YhS1lD1KJsJQeYKS4mjMhwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9GyS3KQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9GyS3KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782078640; x=1813614640;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/fJJkX/+8BvvzZo1p1vaUpSBU3H3Yn1TAUuW/XVtoHs=;
  b=m9GyS3KQT+yla93SGrOEm+zXOmI3G6PBFLAGQWUM4SBO0XnjJkU4nFbo
   y0BFXF5ekhj9xneK05KOqnyvqaRiflqaV4idmdLYbKMqWrZvcOA8Gr2bT
   9gfzdK9/FU+PmlEv/dnjwgrkZ7KDZeUrpXDN3FX/Lh2+GiBksBy8tz6Rs
   CgX5/1NJHQgjrDLycSlKBL6oyqxHyRrFFONKIZOzW1dh5Cp60lBTLcimp
   keBtP/4FYS8hiSUVyeNmMMJ/h233qymTxTXEvc9hA9kt/xHK8GeeCqAPJ
   V2TOAgAp2FBPgJypquR84fo4b2AZ46jkNXQ6WJtj/v13Pm0EO8kkrpulV
   Q==;
X-CSE-ConnectionGUID: SQMtNUGRRfiWYg+wKbMSAw==
X-CSE-MsgGUID: II5Z1FI2S7itlV0mHxcJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="82683324"
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="82683324"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 14:50:40 -0700
X-CSE-ConnectionGUID: wuAlyXjpSj2bUCWne90h9Q==
X-CSE-MsgGUID: a9KqFL1OQFSe6BX+GZt0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="249122701"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 14:50:40 -0700
Message-ID: <dd33bb24d2e8f048f2a10ea9536c9643572110fb.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/6] cpufreq: intel_pstate: Set cpuinfo_min_freq to a
 lower value with HWP enabled plus cleanups
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sun, 21 Jun 2026 14:50:39 -0700
In-Reply-To: <6005456.DvuYhMxLoT@rafael.j.wysocki>
References: <6005456.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 19:31 +0200, Rafael J. Wysocki wrote:
> Hi,
>=20
> This is in v2 because technically it is an update of
>=20
> https://lore.kernel.org/linux-pm/2381464.iZASKD2KPV@rafael.j.wysocki/
>=20
> but it contains new patches.
>=20
> This series updates the intel_pstate driver to set cpuinfo_min_freq
> to a lower
> value when HWP is enabled to support systems in which CPUs can
> actually run
> at performance levels below the current minimum level.
>=20

Is this intentional?

HWP_CAP: 0x10f163e
MSR 0xce(platform_info: 0x804043df8811b00

cpu0/cpufreq/cpuinfo_min_freq
100000

cpu0/cpufreq/scaling_min_freq
400000

Thanks,
Srinivas

> It also carries out some code cleanups, mostly related to HWP, either
> in
> preparation for the functional changes or top of them.
>=20
> Thanks!
>=20
>=20
>=20
