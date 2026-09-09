Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996B455192;
	Wed,  9 Sep 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940257; cv=none; b=eTnmr65PQjx8zLBR660blVgr9qNnyOk/iQrt8DYOw61HODKGwei5t74zstQP3n0d7lFtdNmtvPcESSU5t/Bod9cYQRZdIpKqBgKASMUzB7/cv8Zez5Dpf0N1kdVcVFb3lNMxRRONhFHY2ONuCIIZ/+m+CX+xd/mbSFiDF3x/kA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940257; c=relaxed/simple;
	bh=8F0Ei2ADVhTACBTdWLc3ypxF0x6jw1ombxI/ZsdGEjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqo4kZtRUVbydRfHqyuIqg1pw4tZIIhby2aT/840EeQexGjh9lzUvsQ12NwgyBTVQhkfBG9o2hpjI7DLGmi9jz9e88O6mLjk7V9NnDbwQZLegzW+Zc9Y5G+sAEkCYa4fBbVn+1Za1Pqm41XrcCHP+Bc2rbYv7ie1ndtCXdInnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGkwKTCO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGkwKTCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940252; x=1820476252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8F0Ei2ADVhTACBTdWLc3ypxF0x6jw1ombxI/ZsdGEjk=;
  b=iGkwKTCOajtPcqKpwZhtJGxEtRNG6KJ9gJsUfQp0GZ1+9mUwz+vH9UcW
   SaTe5mcNMR5zTQTcwKeWJ7/aEQo3qH2jxQ/MJdiPPjT2ASy91JEPh5F4H
   7mGB5vcy8Tx7tvihegkB8QXTefwopE78EyJoLo527FPhik0hKnsqZ5K9k
   +E/1p/Ze9r4oD4gTN58Hijp8mT6/4UDSiH5XR8V1YokVeNMJAe7KASxBH
   85nsUSOTiBIFfEf6UQC5YOh8vK+ZBGUw7bCQzxZIUzYRL/9jWlWzAxMJy
   zhIrCSnl0L5hHOegXbT2VQmhCKi8dOCQnASO2/cTXkA+j4i8s6DJZCbY5
   w==;
X-CSE-ConnectionGUID: np/XYqzqReiZNZB//g8v5g==
X-CSE-MsgGUID: klbkykVdS+W1UBQ6OCPRdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106725230"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106725230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 00:50:48 -0700
X-CSE-ConnectionGUID: YGt60OXITHmm6Ifxgle+Nw==
X-CSE-MsgGUID: lT2DXUgtTZClrGGvcJOWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="266942103"
Received: from lkp-server02.sh.intel.com (HELO cdbc6ec9b517) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 09 Sep 2026 00:50:46 -0700
Received: from kbuild by cdbc6ec9b517 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4D4t-0000000004t-1vtl;
	Wed, 09 Sep 2026 07:50:43 +0000
Date: Wed, 9 Sep 2026 15:48:26 +0800
From: kernel test robot <lkp@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Georgi Djakov <djakov@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] interconnect: qcom: implement get_bw with rpmh_read
Message-ID: <202609091547.IZVghFTg-lkp@intel.com>
References: <20260908-topic-sm8x50-icc-read-rpmh-v2-1-b6f1c4205450@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-topic-sm8x50-icc-read-rpmh-v2-1-b6f1c4205450@linaro.org>

Hi Neil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cee9395acd8043be0644b25c34bfa86623f2b935]

url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/interconnect-qcom-implement-get_bw-with-rpmh_read/20260908-100915
base:   cee9395acd8043be0644b25c34bfa86623f2b935
patch link:    https://lore.kernel.org/r/20260908-topic-sm8x50-icc-read-rpmh-v2-1-b6f1c4205450%40linaro.org
patch subject: [PATCH v2] interconnect: qcom: implement get_bw with rpmh_read
config: arc-randconfig-r112-20260909 (https://download.01.org/0day-ci/archive/20260909/202609091547.IZVghFTg-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260909/202609091547.IZVghFTg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609091547.IZVghFTg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/interconnect/qcom/icc-rpmh.c:169:35: sparse: sparse: invalid assignment: *=
   drivers/interconnect/qcom/icc-rpmh.c:169:35: sparse:    left side has type unsigned long long
   drivers/interconnect/qcom/icc-rpmh.c:169:35: sparse:    right side has type restricted __le32
>> drivers/interconnect/qcom/icc-rpmh.c:172:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] __base @@     got restricted __le16 [usertype] width @@
   drivers/interconnect/qcom/icc-rpmh.c:172:33: sparse:     expected unsigned int [usertype] __base
   drivers/interconnect/qcom/icc-rpmh.c:172:33: sparse:     got restricted __le16 [usertype] width
   drivers/interconnect/qcom/icc-rpmh.c:178:35: sparse: sparse: invalid assignment: *=
   drivers/interconnect/qcom/icc-rpmh.c:178:35: sparse:    left side has type unsigned long long
   drivers/interconnect/qcom/icc-rpmh.c:178:35: sparse:    right side has type restricted __le32
   drivers/interconnect/qcom/icc-rpmh.c:181:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] __base @@     got restricted __le16 [usertype] width @@
   drivers/interconnect/qcom/icc-rpmh.c:181:33: sparse:     expected unsigned int [usertype] __base
   drivers/interconnect/qcom/icc-rpmh.c:181:33: sparse:     got restricted __le16 [usertype] width
   drivers/interconnect/qcom/icc-rpmh.c:231:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] unit @@     got unsigned int [usertype] @@
   drivers/interconnect/qcom/icc-rpmh.c:231:28: sparse:     expected restricted __le32 [usertype] unit
   drivers/interconnect/qcom/icc-rpmh.c:231:28: sparse:     got unsigned int [usertype]
   drivers/interconnect/qcom/icc-rpmh.c:232:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] width @@     got unsigned short [usertype] @@
   drivers/interconnect/qcom/icc-rpmh.c:232:29: sparse:     expected restricted __le16 [usertype] width
   drivers/interconnect/qcom/icc-rpmh.c:232:29: sparse:     got unsigned short [usertype]

vim +169 drivers/interconnect/qcom/icc-rpmh.c

   138	
   139	static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
   140	{
   141		struct qcom_icc_node *qn = node->data;
   142		u32 avg_max = 0;
   143		u32 peak_max = 0;
   144		u64 x, y;
   145		int i;
   146	
   147		if (!qn->num_bcms) {
   148			*avg = INT_MAX;
   149			*peak = INT_MAX;
   150	
   151			return 0;
   152		}
   153	
   154		for (i = 0; i < qn->num_bcms; ++i) {
   155			struct qcom_icc_bcm *bcm = qn->bcms[i];
   156	
   157			/* Use AMC vote for boot-up */
   158			x = bcm->vote_x[QCOM_ICC_BUCKET_AMC];
   159			y = bcm->vote_y[QCOM_ICC_BUCKET_AMC];
   160	
   161			/* Consider enable mask and convert to INT_MAX */
   162			if (bcm->enable_mask) {
   163				if (x & bcm->enable_mask)
   164					avg_max = INT_MAX;
   165				if (y & bcm->enable_mask)
   166					peak_max = INT_MAX;
   167			} else {
   168				if (x) {
 > 169					x *= bcm->aux_data.unit;
   170					do_div(x, bcm->vote_scale);
   171					x *= qn->buswidth * qn->channels;
 > 172					do_div(x, bcm->aux_data.width);
   173	
   174					avg_max = max(avg_max, x);
   175				}
   176	
   177				if (y) {
   178					y *= bcm->aux_data.unit;
   179					do_div(y, bcm->vote_scale);
   180					y *= qn->buswidth;
   181					do_div(y, bcm->aux_data.width);
   182	
   183					peak_max = max(peak_max, y);
   184				}
   185			}
   186		}
   187	
   188		*avg = avg_max;
   189		*peak = peak_max;
   190	
   191		return 0;
   192	}
   193	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
