Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFE3A8742;
	Mon, 23 Mar 2026 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269265; cv=none; b=fTMJZmxSctF+s1nHY5QP9HDXvUbkRwr7DfYw4yoJcgMv4+qxwVC6Q3dkemfe3Vj3iuMt2gkrQmLgl7Nrmi10SOICYbwvDANyrfblryw4P6pf9Vt2kDn6iib9TlEoquV9623xJIlH7Hds3yvG6QBoa3AiIRsUUYGuwZ44y1/3p3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269265; c=relaxed/simple;
	bh=kX39cQigXLllv505alMHPGCKIOePb5ceGhrB9+kAs0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9qxJIIaM0eBhBT27MaMotOuycp9cFDqI4dw/6LkM5Kq/Rz3FrElwz70wSTF5GME8coS5dFIt3/Qsq9NiYS+iE2MZG8y6w3PruQBwr0VsvFZXmU2Vs3tWlzC+vcN1kmiWIRDp5vJ0bfA/C/aFanu3KCemV/WxIxfSq//2PiZAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSpL4DzL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSpL4DzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774269259; x=1805805259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kX39cQigXLllv505alMHPGCKIOePb5ceGhrB9+kAs0g=;
  b=CSpL4DzLIsCRpwTqJBuKc5ycUYvX2lFoMFBW9zdW+FcbD+48fevHB+j3
   g4CyJtrEelqJhjeBtyD/k85nlJg8a4fDwpTpkdZCOsDo6ijxN2ty5UnLj
   saZc3gJjR8TMO4LocyAFRClgoSweJg/fJ/N9SiRPwm3Fw4fPBFfFjwV9H
   Xgjro6jYiY5lhgxUOow4lhQs/ce8YXqgqIz1SPrsd5p1m1YuAv8mPn1sw
   rnuT0jYOx4GNcswiJZPwZ2gxD8bgELNpjYlrVoJ5A0MQ+/S3wwNcs9XO3
   2BJ2PJVmApUkF5RvqF98yeDzrMW+U5P+ZEbUC/1MsJWNbyBI1i5coz07R
   A==;
X-CSE-ConnectionGUID: R//a/azSSxus3bTFgyTR5Q==
X-CSE-MsgGUID: GoH3Uu+5So67chFXBiRLug==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75329338"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75329338"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 05:34:17 -0700
X-CSE-ConnectionGUID: rsfdTnrvTIufpy9pbztCFQ==
X-CSE-MsgGUID: NgFf8TAnSHaHyBdydqofHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="228087116"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Mar 2026 05:34:14 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4eTy-000000000Vd-3Dhn;
	Mon, 23 Mar 2026 12:34:10 +0000
Date: Mon, 23 Mar 2026 20:33:36 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, memxor@gmail.com,
	bpf@vger.kernel.org, Samuel Wu <wusamuel@google.com>,
	kernel-team@android.com, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PM: wakeup: Add kfuncs to lock/unlock
 wakeup_sources
Message-ID: <202603232018.pdjbZ3eL-lkp@intel.com>
References: <20260320160055.4114055-2-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320160055.4114055-2-wusamuel@google.com>

Hi Samuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v7.0-rc5 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Wu/PM-wakeup-Add-kfuncs-to-lock-unlock-wakeup_sources/20260323-064540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260320160055.4114055-2-wusamuel%40google.com
patch subject: [PATCH v1 1/2] PM: wakeup: Add kfuncs to lock/unlock wakeup_sources
config: x86_64-randconfig-121-20260323 (https://download.01.org/0day-ci/archive/20260323/202603232018.pdjbZ3eL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603232018.pdjbZ3eL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603232018.pdjbZ3eL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/power/wakeup.c:1189:32: sparse: sparse: symbol 'bpf_wakeup_sources_read_lock' was not declared. Should it be static?
>> drivers/base/power/wakeup.c:1202:18: sparse: sparse: symbol 'bpf_wakeup_sources_read_unlock' was not declared. Should it be static?

vim +/bpf_wakeup_sources_read_lock +1189 drivers/base/power/wakeup.c

  1177	
  1178	/**
  1179	 * bpf_wakeup_sources_read_lock - Acquire the SRCU lock for wakeup sources
  1180	 *
  1181	 * The underlying SRCU lock returns an integer index. However, the BPF verifier
  1182	 * requires a pointer (PTR_TO_BTF_ID) to strictly track the state of acquired
  1183	 * resources using KF_ACQUIRE and KF_RELEASE semantics. We use an opaque
  1184	 * structure pointer (struct bpf_ws_lock *) to satisfy the verifier while
  1185	 * safely encoding the integer index within the pointer address itself.
  1186	 *
  1187	 * Return: An opaque pointer encoding the SRCU lock index + 1 (to avoid NULL).
  1188	 */
> 1189	__bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
  1190	{
  1191		return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
  1192	}
  1193	
  1194	/**
  1195	 * bpf_wakeup_sources_read_unlock - Release the SRCU lock for wakeup sources
  1196	 * @lock: The opaque pointer returned by bpf_wakeup_sources_read_lock()
  1197	 *
  1198	 * The BPF verifier guarantees that @lock is a valid, unreleased pointer from
  1199	 * the acquire function. We decode the pointer back into the integer SRCU index
  1200	 * by subtracting 1 and release the lock.
  1201	 */
> 1202	__bpf_kfunc void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock)
  1203	{
  1204		wakeup_sources_read_unlock((int)(long)lock - 1);
  1205	}
  1206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
