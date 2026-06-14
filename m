Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D63264D6;
	Sun, 14 Jun 2026 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781469111; cv=none; b=m25AwlIbeQ+lOhfZlG8+n1ilPp0ZjTUpz87YgFdHRtreRVOBOke3QsyLE0pSQAKGrPTyrxJ5SEYujd65yo2+J+yq4P52ewq7jxrADQBMXZGhoDl7c95XjXEHBfXKjvV6NeVPBicjPOxbFEOWF9sUil1gq52uaxrft3A8SHv67pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781469111; c=relaxed/simple;
	bh=cBWaHdoxmiq6brTd1QAtT75checZ+82ruIMMfjYriyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCr+rwsErpDfvmmrydtePn0jRvIfMYi2KZyTInuIWDyjKIvaYWJlvlayCwY1PqSvWT1H8slGC1ctHzCDreyp0Zz4AOXJ4mM0YOQSKZ+YOVLRnKRjlul8PE3zsnqeUHZYmoHltmA0uqcHJdyQedK0l2timZWyn9XYhWbqEMUwIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8QdGKfg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8QdGKfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781469108; x=1813005108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cBWaHdoxmiq6brTd1QAtT75checZ+82ruIMMfjYriyA=;
  b=R8QdGKfgKVl8U4E6fq5qAdJA8Elg+afsgn5pl/gpgu3B/eFPqugGolz9
   rbopakomM9gYarNPKIgh9mh5iS+kfHhEBgT7sf3mqP+IVXSpBAZP2Bud3
   pLu18LrHHadX5ryAEYsKHBF41Qa4HS1hCwl63C03zp3Al3zZWuWzWim6E
   NQkqpQ+uYgOhzXjWzvxuXgCwY2b/ulu5se5LIklYaoy3HYiQtDNeXRI9q
   geCQEAX3aRMpGAPGwFA9EACsENxmHJCvqn+X4y8bhogxTLLdelqQaiyjE
   ZCTXdd+3oXgUzDNmkQeNOGqBlu21IQar60IUJX4qPegz0t10IzQj7YRqh
   w==;
X-CSE-ConnectionGUID: F1GpVEuSRUuKLXXFcnD96w==
X-CSE-MsgGUID: Gq9QTcIaSKyaFnmicGTpgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81231542"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="81231542"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 13:31:47 -0700
X-CSE-ConnectionGUID: FmQOavtWS36NSancMwtHBA==
X-CSE-MsgGUID: k7zjGeMxQayDDF18rv4Y5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="247175398"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Jun 2026 13:31:45 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wYrUc-00000000RBu-17nQ;
	Sun, 14 Jun 2026 20:31:42 +0000
Date: Mon, 15 Jun 2026 04:31:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ronan Marchal <ronanmarchal29@gmail.com>, rafael@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pavel@kernel.org,
	lenb@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ronan Marchal <ronanmarchal29@gmail.com>
Subject: Re: [PATCH] kernel/power/snapshot: Add missing kernel-doc parameter
 descriptions
Message-ID: <202606150431.R9kR0q9p-lkp@intel.com>
References: <20260614144158.82751-1-ronanmarchal29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614144158.82751-1-ronanmarchal29@gmail.com>

Hi Ronan,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master v7.1 next-20260612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ronan-Marchal/kernel-power-snapshot-Add-missing-kernel-doc-parameter-descriptions/20260614-224612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20260614144158.82751-1-ronanmarchal29%40gmail.com
patch subject: [PATCH] kernel/power/snapshot: Add missing kernel-doc parameter descriptions
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260615/202606150431.R9kR0q9p-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260615/202606150431.R9kR0q9p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606150431.R9kR0q9p-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/snapshot.c:2042:1: error: unknown type name 'c'
    2042 | c/**
         | ^
   1 error generated.


vim +/c +2042 kernel/power/snapshot.c

  2041	
> 2042	c/**
  2043	 * enough_free_mem - Check if there is enough free memory for the image.
  2044	 * @nr_pages: Number of non-highmem pages to copy.
  2045	 * @nr_highmem: Number of highmem pages to copy.
  2046	 *
  2047	 * Check if there are enough free non-highmem pages available to save
  2048	 * the hibernation image.
  2049	 */
  2050	static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
  2051	{
  2052		struct zone *zone;
  2053		unsigned int free = alloc_normal;
  2054	
  2055		for_each_populated_zone(zone)
  2056			if (!is_highmem(zone))
  2057				free += zone_page_state(zone, NR_FREE_PAGES);
  2058	
  2059		nr_pages += count_pages_for_highmem(nr_highmem);
  2060		pr_debug("Normal pages needed: %u + %u, available pages: %u\n",
  2061			 nr_pages, PAGES_FOR_IO, free);
  2062	
  2063		return free > nr_pages + PAGES_FOR_IO;
  2064	}
  2065	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
