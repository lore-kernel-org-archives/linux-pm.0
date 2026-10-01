Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B22BD022;
	Thu,  1 Oct 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871882; cv=none; b=YhAoGMbIscJHBaqBKbxk+bnHMreIPkXrzLAVkIjle9cW1uC88/JjXzxVlPuBGJqae1UvN742k5NlPsx4JUAWEvyU3zxFvMYtzMO2w+NxJcRQ6YxrSHsKVzj250Tq5wJMOsM6jhxnDgEkMPVQg1gXVh5MGGqjE167sTBhxDSCnSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871882; c=relaxed/simple;
	bh=LdA11I/nUewSl4reDrAPjEkS9+UNNAsC7hhq6mX0lXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/4qJvdyjPhnctYbtJ8WjHmvUIkIsxMr3vO7V9ZF+nXmNnJJqYHVr3b77/zHwXf/dVQZPMvbJcz5s21/RwWlbmX4al/joRH8Leqvaqm5U3Sq69arMUCRZObNn087JW0Xrgsh+206S0P/4uZJsYe5mMyTWJfT/xCsmQ6ENmALMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4xfcYQu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4xfcYQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790871880; x=1822407880;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LdA11I/nUewSl4reDrAPjEkS9+UNNAsC7hhq6mX0lXw=;
  b=A4xfcYQuuZ09DTesGjaBmh/OyTdT28ML+ge1jiPV8LS1MpaoZ0jp2Px2
   0nZoQUbpcP9Cup4Rdt7A5XWcvnrsAGwGoujKTRUaXPX2mXwi9TU/CHgvl
   VIPSBCHVyOioKzktDBQyIY/eTKwZkAS0Gi9JG9Vibg4SXJiha6vyFyJat
   ypZo6Ez8P6pLl4+xB8w2mUmEx0ZQwBOLapUaVRklU9T/++3VV2CLFntwr
   C/mZSodqNquOU4uxuMDaVaDk2/ekfMvj9acT51XWxGk2GC5Jxh1HT+y3o
   LMj8fUC236ulTWt+PlR2f4Tep3bNuGwE2+DZWpQ2UWODyhJStP2p60zWn
   A==;
X-CSE-ConnectionGUID: E+CynqiBThO3EQ8SQZt6qw==
X-CSE-MsgGUID: OyDFrVOkSN6q/TssnCSxcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="103011532"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="103011532"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 09:24:37 -0700
X-CSE-ConnectionGUID: kex1FDhVSja/AyOfsNxdnw==
X-CSE-MsgGUID: yz97lrRpR7aCNRjNQ6LfTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="279338349"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 09:24:36 -0700
Message-ID: <aa1d85c2-cd19-4c18-9a6c-85f83c6c18fa@linux.intel.com>
Date: Thu, 1 Oct 2026 09:24:20 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools/power turbostat: Add rugged Panther Lake support
To: Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260819174154.1184393-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJvTdKm5g2-rLjSXNPkGqUU3BD-PUbSbNJecBn2-CA29O3WJvQ@mail.gmail.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAJvTdKm5g2-rLjSXNPkGqUU3BD-PUbSbNJecBn2-CA29O3WJvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Len,

On 10/1/2026 7:49 AM, Len Brown wrote:
> perf_model_support() also should be updated.

Thanks. Will submit a patch to update it.

> 
> thanks,
> -Len
> 
> On Wed, Aug 19, 2026 at 1:41 PM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
>> Add CPU model for rugged Panther Lake.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>>  tools/power/x86/turbostat/turbostat.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index 920694c3c1ec..f5b3afa050bf 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -1229,6 +1229,7 @@ static const struct platform_data turbostat_pdata[] = {
>>         { INTEL_ARROWLAKE, &adl_features },
>>         { INTEL_LUNARLAKE_M, &lnl_features },
>>         { INTEL_PANTHERLAKE_L, &lnl_features },
>> +       { INTEL_PANTHERLAKE_R, &lnl_features },
>>         { INTEL_NOVALAKE, &lnl_features },
>>         { INTEL_NOVALAKE_L, &lnl_features },
>>         { INTEL_WILDCATLAKE_L, &lnl_features },
>> --
>> 2.43.0
>>
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

