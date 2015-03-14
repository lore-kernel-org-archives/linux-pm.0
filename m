From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v4 0/3] firmware: qcom: scm: Add cpu power on/off support
Date: Fri, 13 Mar 2015 21:02:33 -0600
Message-ID: <20150314030233.GK497@linaro.org>
References: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
 <20150313171656.GI497@linaro.org>
 <FF397312-A395-40ED-8FCF-E893E2849208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36656 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbCNDCh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 23:02:37 -0400
Received: by padcy3 with SMTP id cy3so6239464pad.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 20:02:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <FF397312-A395-40ED-8FCF-E893E2849208@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org

On Fri, Mar 13 2015 at 18:52 -0600, Kumar Gala wrote:
>I=E2=80=99ve applied these to my =E2=80=98soc=E2=80=99 branch.
>
Great. Thank you.

-Lina.

>- k
>
>On Mar 13, 2015, at 12:16 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> Kumar, Stephen, Andy,
>>
>> Any comments on this patchset?
>>
>> Thanks,
>> Lina
>>
>> On Mon, Mar 02 2015 at 16:30 -0700, Lina Iyer wrote:
>>> Hi,
>>>
>>> This series of patches adds SCM cold boot clean up and support for =
warm boot
>>> for QCOM quad core (and dual core) cpus.
>>>
>>> v4 Changes:
>>> - Added QCOM_SCM_CPU_DOWN_ prefix for L2 on/off enums, relocated th=
em to be close
>>> to the function declaration.
>>>
>>> v3 Changes:
>>> - Addressed review comments from Kumar.
>>> 	+ Cleaned up the cold boot api and the warm boot api to match
>>> 	+ Uniform qcom_scm_ prefix
>>> - Add support for cpu power down using scm_call_atomic1() from [1].
>>> 	+ No longer dependent on the series from sboyd.
>>>
>>> v2 Changes:
>>> - Merge the warm boot patches into a single patch.
>>>
>>> [1]. https://lkml.org/lkml/2014/8/4/765
>>>
>>> Thanks,
>>> Lina
>>>
>>> Lina Iyer (3):
>>> firmware: qcom: scm: Clean cold boot entry to export only the API
>>> firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
>>> firmware: qcom: scm: Support cpu power down through SCM
>>>
>>> arch/arm/mach-qcom/platsmp.c |  21 +-----
>>> drivers/firmware/qcom_scm.c  | 154 ++++++++++++++++++++++++++++++++=
++++++++++-
>>> include/linux/qcom_scm.h     |  17 +++--
>>> 3 files changed, 163 insertions(+), 29 deletions(-)
>>>
>>> --
>>> 2.1.0
>>>
>
>--=20
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Fo=
rum,
>a Linux Foundation Collaborative Project
>
