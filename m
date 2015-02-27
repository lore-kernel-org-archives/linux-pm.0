From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
Date: Fri, 27 Feb 2015 13:07:19 -0700
Message-ID: <20150227200719.GE1678@linaro.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org>
 <24986C4E-2DED-456F-A1D3-E52037540E01@codeaurora.org>
 <20150226222035.GB1250@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45927 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbbB0UHW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 15:07:22 -0500
Received: by pablf10 with SMTP id lf10so25157677pab.12
        for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2015 12:07:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150226222035.GB1250@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thu, Feb 26 2015 at 15:20 -0700, Lina Iyer wrote:
>On Thu, Feb 26 2015 at 15:10 -0700, Kumar Gala wrote:
>>
>>On Feb 25, 2015, at 4:54 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>
>>>Hi,
>>>
>>>These patches used to be part of my cpuidle patchset, think these can go in
>>>independently.
>>>
>>>The patches do the following -
>>>
>>>1. Add QCOM Secure Monitor specific enumeration for warm boot on qcom targets
>>>2. Add an API to set up the warmboot address. Consolidate the warm boot flags
>>>into the implementation file
>>>
>>>Thanks,
>>>Lina
>>>
>>>Lina Iyer (2):
>>> ARM: qcom: Add SCM warmboot flags for quad core targets.
>>> qcom: scm: Add scm_set_warm_boot_addr function
>>>
>>>arch/arm/mach-qcom/scm-boot.c | 38 ++++++++++++++++++++++++++++++++++++++
>>>arch/arm/mach-qcom/scm-boot.h |  5 +++--
>>>2 files changed, 41 insertions(+), 2 deletions(-)
>>
>>Lina,
>>
>>Do you mind rebasing these patches on my recent SCM cleanup set.  You find it at:
>>
>>git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git qcom/scm-cleanup
>>
>
>Sure. As suggested by Kevin H, I will merge the two patches and rebase
>on top yours and resubmit.
>
I have rebased on top of yours. I will send it shortly. But please note
that source "driver/firmware/Kconfig" is missing in arch/arm/Kconfig for
the driver/firmware to build.

Also, I have a dependency on the scm_call_atomic() api introduced by
Stephen [1] for cpuidle. When can I expect to see that?

[1]. https://lkml.org/lkml/2014/8/4/765


Thanks,
Lina
