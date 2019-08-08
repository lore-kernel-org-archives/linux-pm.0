Return-Path: <SRS0=lDgx=WE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CF8C433FF
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D7218B6
	for <linux-pm@archiver.kernel.org>; Thu,  8 Aug 2019 15:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfHHPOQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:14:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:58082 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733010AbfHHPOQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 11:14:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 08:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="374883139"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.86.4]) ([10.252.86.4])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 08:14:12 -0700
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
To:     Dave Hansen <dave.hansen@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>, x86@kernel.org
Cc:     bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <fb0e7bd3-d3b1-8163-2766-99a75de994d9@intel.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <e2832973-6013-2b8a-90cb-ffcf54760bcd@linux.intel.com>
Date:   Thu, 8 Aug 2019 20:44:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fb0e7bd3-d3b1-8163-2766-99a75de994d9@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dave,

On 08-Aug-19 7:26 PM, Dave Hansen wrote:
>> +++ b/arch/x86/include/asm/intel-family.h
>> @@ -79,6 +79,7 @@
>>    #define INTEL_FAM6_ATOM_GOLDMONT_PLUS    0x7A /* Gemini Lake */
>>      #define INTEL_FAM6_ATOM_TREMONT_X    0x86 /* Jacobsville */
>> +#define INTEL_FAM6_ATOM_ELKHART_LAKE    0x96 /*Elkhart Lake */
> Should we be merging these before we have a user for them?

We have few patches that need this. They will soon follow once this is 
accepted.

Thanks

Rajneesh


>
