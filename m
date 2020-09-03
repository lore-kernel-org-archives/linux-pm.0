Return-Path: <SRS0=Boio=CM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7DDC433E9
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F39B20716
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgICQNY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:13:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:51539 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgICQNU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 12:13:20 -0400
IronPort-SDR: SEn1VCuIgsSlG4ssSl4gkLqRSlIVgUEbUNeVCbYmj9ma/kuteeNfItz+Nevx6P9/Werl/LkiwM
 yHstA9pgaOVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="156874695"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="156874695"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 09:13:19 -0700
IronPort-SDR: fk5N31e8TGXqszp/hkGx3Y27Do4CNUaLdLlqnJp1760vL/L5dq2hrU3xSP3351G+w/bgBSa+0U
 R2mw+5q6ydyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="331834658"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2020 09:13:19 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.ger.corp.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 247D458079D;
        Thu,  3 Sep 2020 09:13:15 -0700 (PDT)
Message-ID: <515651b2caa08799df03f07dcc429321b4dcc05e.camel@gmail.com>
Subject: Re: [RFC v4 1/1] selftests/cpuidle: Add support for cpuidle latency
 measurement
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Pratik Sampat <psampat@linux.ibm.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com
Date:   Thu, 03 Sep 2020 19:13:15 +0300
In-Reply-To: <9c5156274a86573ad592e6e431f3cbee8135b736.camel@gmail.com>
References: <20200902114506.45809-1-psampat@linux.ibm.com>
         <20200902114506.45809-2-psampat@linux.ibm.com>
         <b59481655c29d081eea4f34c00166517738000e5.camel@gmail.com>
         <fa616fed-66be-bcad-83b8-b1173a3a444f@linux.ibm.com>
         <9c5156274a86573ad592e6e431f3cbee8135b736.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2020-09-03 at 17:50 +0300, Artem Bityutskiy wrote:
> Well, things depend on platform, it is really "void", it is just
> different and it measures an optimized case. The result may be smaller
> observed latency.

Sorry, I meant to say it is _not_ really "void".

