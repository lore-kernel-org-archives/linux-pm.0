Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066632;
	b=HB+1bScESn9UEJMGUrlYh4wZ17WfC3Q7mEAo+LItRhpsiQ9ez34kiLuKmHr20vHH+2Uu
	 xWSiZaJUwpabR65iRvq8wkqW0xXxIGs/xWmS35SawrmsrOscGekRGUpc/dzsr2Ws7+XBX
	 pzM5hhK7i6jXPO9L6n0IoJmxSIYkU4Zb0aJcrnj/vjAGD5452K/BgbITQaZ2kyXncuVGI
	 TaeDlSl5IRH2OosAlBoLjH1Lv59sz9pGdl4Vg/8j5p8fdPYBAM+NFAyq5dMfxyiC7d5cj
	 iB8NDGFFnCMvLD/Ad36/amB/9E0ZtK0d616SgYgeMVuhp5QIdaluQDfI3K8OhNxBRhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066632;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent;
	bh=Z9H4mGgi+GR/pE1/qKcr2eppdukJRUXCrufQrY6XzDc=;
	b=ZWje2gS1WOsC7s1iTglilKaf0ZKxX33yNlNke7pWByaWn23k76YkxXacO29+7G+9sxsH
	 +YVsTTYOrmYGrNqGGuDxA2GkoRoGAY3uSDVa9zH60s1tmUBb18k3Cl/x5Iv+SYPK2m2Mp
	 779KO95JPI+TpawsKnvXp4Cozmt+yxX1DvF6p/91bQctYrRigyTHzFSPt3TWK6p9WCrY1
	 vm+KJ3wxC6yfKEbLXEmIqqqXxJeJR+fTfTITtxNw55TQogOoTXx4pN48mec1QBzjSic9m
	 T0GHub1iW5cWHxv2ulJ0+de0soXu6pW0Xzbsxf/OmOZ+9xecu7Q/IcdWgfhv2mOXHYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k0FPX7FW;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD7606A326;
	Thu, 19 Nov 2026 05:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AD7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k0FPX7FW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795066632; x=1826602632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=93PQqPubhfw8/CwU/mw+PGeEOjq2DG3IhCw4EJYT5dI=;
  b=k0FPX7FWxYE7/tNnU2Unt9HHPnJEwX9811eh/jZpVAG6DZ02mmYJFPpa
   LV3QodvkUy4p5lop3dMNY2BkMd4H47Dqc3mG8g2DTx83TrNowLxG8+/W+
   5Shu9cuPqfFpRMwcakozN+ydn1wPi1/RW+NIDr9hV3CIUNyMfLLT1zjAM
   zH/fK6DbN3pexh6/1dcAA+bAf+2nhAmHDl1QCl65HBbQjAnylkUDKEsNl
   T6WST6Ib8unkpt0JR/wvUIEiA/wUVhdaS4TmSwhx+Y+IwWQwHPx/6Uokr
   RKefuTn2C8mrmNxJghXe40osj+KtlhLwQ/GN1WJFrjX9MjPlRCN+PuLbc
   w==;
X-CSE-ConnectionGUID: Wg6esyOZSai2yXe6xFpciw==
X-CSE-MsgGUID: 8lG8jjt0QGao/MFxtz09SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3793304"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3793304"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 21:37:12 -0800
X-CSE-ConnectionGUID: ocqMr8EnR1qhb1ZTMoMecw==
X-CSE-MsgGUID: IWFpCOCITiWkOHEPTlnOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10569705"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 21:37:11 -0800
Date: Wed, 18 Nov 2026 21:45:11 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: jez@sfcompute.com, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew James <ajames@sfcompute.com>,
	John Ranzie <jranzie@sfcompute.com>
Subject: Re: [PATCH 0/2] thermal: intel: hfi: Stop hardware writing to freed
 memory after kexec
Message-ID: <20261119054511.GC7495@ranerica-svr.sc.intel.com>
References: <20261028-hfi-kexec-v1-0-956234dcfb2b@sfcompute.com>
 <CAJZ5v0hf9odYCxz1r3Er5dh2tjXCtDwKuhdS1b3tP6MOMjQSeA@mail.gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hf9odYCxz1r3Er5dh2tjXCtDwKuhdS1b3tP6MOMjQSeA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Nov 13, 2026 at 04:26:06PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Wed, Oct 28, 2026 at 1:20 AM Jez Ng via B4 Relay
> <devnull+jez.sfcompute.com@kernel.org> wrote:
> >
> > HFI hardware writes updates to a table at a physical address the kernel
> > programs. Nothing disables HFI on shutdown, and since commit b33f3d2677b8
> > ("thermal: intel: hfi: Enable HFI only when required") a kernel that
> > starts without thermal netlink clients does not touch HFI at all. So
> > after a kexec, hardware keeps writing into the previous kernel's table,
> > which the new kernel treats as free memory.
> >
> > We hit this on dual-socket Sapphire Rapids hosts (Xeon Platinum 8462Y+)
> > that boot a Debian 6.1 kernel and kexec into a 7.0 kernel. The new
> > kernel crashed in find_inode_fast() when the inode hash table landed on
> > one of the old table pages. Reading MSR 0x17d0 on the running 7.0
> > kernel showed both packages still pointing at the 6.1 kernel's tables,
> > and the corruption had the HFI table layout: a timestamp, a changed
> > flag, then one row per CPU.
> >
> > Patch 1 disables HFI in a syscore shutdown callback, which covers
> > reboot, power off and kexec, and keeps it disabled afterwards: on kexec,
> > user space runs until machine_shutdown(), so a new thermal netlink
> > client could otherwise enable HFI again. Patch 2 makes a starting kernel
> > disable HFI if the previous kernel left it enabled. Patch 2 can only
> > narrow the window: hardware can still write between kernel start and
> > the moment the package's first CPU reaches the thermal online callback,
> > which was about 30 seconds into boot on these hosts.
> >
> > This is the kexec counterpart of the hibernation corruption fixed by
> > commit 97566d09fd02 ("thermal: intel: hfi: Add syscore callbacks for
> > system-wide PM"), which disables HFI for suspend and hibernation but not
> > for shutdown.
> >
> > Tested on one of the hosts above with both patches applied to this base,
> > alternating 100 kexecs (kexec_file_load + reboot(LINUX_REBOOT_CMD_KEXEC))
> > between the patched kernel and an unpatched 7.0 kernel. Before each
> > kexec, a thermal netlink subscriber enabled HFI on both packages. All
> > 100 passed:
> >
> >  - Patch 1: after each of the 50 kexecs out of the patched kernel, the
> >    unpatched kernel read HW_FEEDBACK_CONFIG = 0 on both packages.
> >
> >  - Patch 2: after each of the 50 kexecs into the patched kernel, it
> >    logged "HFI left enabled on package N, disabled" for both packages
> >    and read HW_FEEDBACK_CONFIG = 0.
> 
> Ricardo, can you please have a look at this series and let me know
> what you think about it?

Hi Rafael, Jez,

These patches fix a real problem, and I think they can be applied
once we close on my comments on patch 2.

This series does not cover processors that ignore a write to
MSR_IA32_HW_FEEDBACK_PTR after the first one. On those processors, the
HFI table of the first kernel after reset must be preserved across
kexec and reused by the next kernel. I have work in progress for that,
based on Kexec Handover (KHO), and plan to send it as a follow-up to
this series.
