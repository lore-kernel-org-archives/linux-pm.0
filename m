From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 0/2] Add SCM warmboot support for QCOM SoCs
Date: Fri, 27 Feb 2015 15:23:57 -0600
Message-ID: <0A05D548-BD53-4A33-A5C7-F396E1915FFA@codeaurora.org>
References: <1424904852-12719-1-git-send-email-lina.iyer@linaro.org> <24986C4E-2DED-456F-A1D3-E52037540E01@codeaurora.org> <20150226222035.GB1250@linaro.org> <20150227200719.GE1678@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58147 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbbB0VYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 16:24:00 -0500
In-Reply-To: <20150227200719.GE1678@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org


On Feb 27, 2015, at 2:07 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Thu, Feb 26 2015 at 15:20 -0700, Lina Iyer wrote:
>> On Thu, Feb 26 2015 at 15:10 -0700, Kumar Gala wrote:
>>>=20
>>> On Feb 25, 2015, at 4:54 PM, Lina Iyer <lina.iyer@linaro.org> wrote=
:
>>>=20
>>>> Hi,
>>>>=20
>>>> These patches used to be part of my cpuidle patchset, think these =
can go in
>>>> independently.
>>>>=20
>>>> The patches do the following -
>>>>=20
>>>> 1. Add QCOM Secure Monitor specific enumeration for warm boot on q=
com targets
>>>> 2. Add an API to set up the warmboot address. Consolidate the warm=
 boot flags
>>>> into the implementation file
>>>>=20
>>>> Thanks,
>>>> Lina
>>>>=20
>>>> Lina Iyer (2):
>>>> ARM: qcom: Add SCM warmboot flags for quad core targets.
>>>> qcom: scm: Add scm_set_warm_boot_addr function
>>>>=20
>>>> arch/arm/mach-qcom/scm-boot.c | 38 +++++++++++++++++++++++++++++++=
+++++++
>>>> arch/arm/mach-qcom/scm-boot.h |  5 +++--
>>>> 2 files changed, 41 insertions(+), 2 deletions(-)
>>>=20
>>> Lina,
>>>=20
>>> Do you mind rebasing these patches on my recent SCM cleanup set.  Y=
ou find it at:
>>>=20
>>> git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git =
qcom/scm-cleanup
>>>=20
>>=20
>> Sure. As suggested by Kevin H, I will merge the two patches and reba=
se
>> on top yours and resubmit.
>>=20
> I have rebased on top of yours. I will send it shortly. But please no=
te
> that source "driver/firmware/Kconfig" is missing in arch/arm/Kconfig =
for
> the driver/firmware to build.

I=92ll fix this.

>=20
> Also, I have a dependency on the scm_call_atomic() api introduced by
> Stephen [1] for cpuidle. When can I expect to see that?
>=20
> [1]. https://lkml.org/lkml/2014/8/4/765

Please add the patch to your patchset.

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project

