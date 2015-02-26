From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
Date: Thu, 26 Feb 2015 15:20:35 -0700
Message-ID: <20150226222035.GB1250@linaro.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
 <24986C4E-2DED-456F-A1D3-E52037540E01@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42633 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbbBZWUh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 17:20:37 -0500
Received: by pdbfp1 with SMTP id fp1so16128212pdb.9
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2015 14:20:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <24986C4E-2DED-456F-A1D3-E52037540E01@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thu, Feb 26 2015 at 15:10 -0700, Kumar Gala wrote:
>
>On Feb 25, 2015, at 4:54 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> Hi,
>>
>> These patches used to be part of my cpuidle patchset, think these can go in
>> independently.
>>
>> The patches do the following -
>>
>> 1. Add QCOM Secure Monitor specific enumeration for warm boot on qcom targets
>> 2. Add an API to set up the warmboot address. Consolidate the warm boot flags
>> into the implementation file
>>
>> Thanks,
>> Lina
>>
>> Lina Iyer (2):
>>  ARM: qcom: Add SCM warmboot flags for quad core targets.
>>  qcom: scm: Add scm_set_warm_boot_addr function
>>
>> arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
>> arch/arm/mach-qcom/scm-boot.h |  5 +++--
>> 2 files changed, 41 insertions(+), 2 deletions(-)
>
>Lina,
>
>Do you mind rebasing these patches on my recent SCM cleanup set.  You find it at:
>
>git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git qcom/scm-cleanup
>

Sure. As suggested by Kevin H, I will merge the two patches and rebase
on top yours and resubmit.


>thanks
>
>- k
>
>-- 
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>a Linux Foundation Collaborative Project
>
