Return-Path: <SRS0=aTLV=EF=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C6C5517A
	for <linux-pm@archiver.kernel.org>; Fri, 30 Oct 2020 18:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 961D420797
	for <linux-pm@archiver.kernel.org>; Fri, 30 Oct 2020 18:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgJ3Sxl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 30 Oct 2020 14:53:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:35272 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbgJ3Sw6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 14:52:58 -0400
IronPort-SDR: kXLnUGdHmdEQXlj3f2y9pYx9pkydLjewyak9s+ke8k1Qk5mxuOlfGyjXyhZowtFdMCJogRx7EK
 thZoVi6NAFig==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147937037"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="147937037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:52:58 -0700
IronPort-SDR: SZlwGUN8hgrMDuMLC9YXhr9ynFTgZtBuh/H92ahRRdpGQMHtzekUMCPES5jsQi0zlAfQsVVsjF
 z0MmaRWJz70Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="361933781"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2020 11:52:58 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 44BF15807B4;
        Fri, 30 Oct 2020 11:52:57 -0700 (PDT)
Message-ID: <cb61ec8078a92e0b33610d192611102d8d2ec4d0.camel@gmail.com>
Subject: wult: tool for measuring C-state latency
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Date:   Fri, 30 Oct 2020 20:52:56 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I've finally published wult on github. This is a tool for measuring C-
state latency. We use in on x68 platforms. It does not support non-x86
today.

I talked about this tool last year on Plumbers. You'll find the video
recording link in the documentation web pages.

Wult comes with kernel drivers, but they are not ready to be submitted
upstream yet, so out of tree for now.

Repo: https://github.com/intel/wult
Docs: https://intel.github.io/wult/

Just FYI, in case it is useful.

Feedback very welcome, thanks!

Artem.

