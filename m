From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v4 0/3] firmware: qcom: scm: Add cpu power on/off support
Date: Fri, 13 Mar 2015 19:52:34 -0500
Message-ID: <FF397312-A395-40ED-8FCF-E893E2849208@codeaurora.org>
References: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org> <20150313171656.GI497@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48967 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbbCNAwi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 20:52:38 -0400
In-Reply-To: <20150313171656.GI497@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org

I=92ve applied these to my =91soc=92 branch.

- k

On Mar 13, 2015, at 12:16 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> Kumar, Stephen, Andy,
>=20
> Any comments on this patchset?
>=20
> Thanks,
> Lina
>=20
> On Mon, Mar 02 2015 at 16:30 -0700, Lina Iyer wrote:
>> Hi,
>>=20
>> This series of patches adds SCM cold boot clean up and support for w=
arm boot
>> for QCOM quad core (and dual core) cpus.
>>=20
>> v4 Changes:
>> - Added QCOM_SCM_CPU_DOWN_ prefix for L2 on/off enums, relocated the=
m to be close
>> to the function declaration.
>>=20
>> v3 Changes:
>> - Addressed review comments from Kumar.
>> 	+ Cleaned up the cold boot api and the warm boot api to match
>> 	+ Uniform qcom_scm_ prefix
>> - Add support for cpu power down using scm_call_atomic1() from [1].
>> 	+ No longer dependent on the series from sboyd.
>>=20
>> v2 Changes:
>> - Merge the warm boot patches into a single patch.
>>=20
>> [1]. https://lkml.org/lkml/2014/8/4/765
>>=20
>> Thanks,
>> Lina
>>=20
>> Lina Iyer (3):
>> firmware: qcom: scm: Clean cold boot entry to export only the API
>> firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
>> firmware: qcom: scm: Support cpu power down through SCM
>>=20
>> arch/arm/mach-qcom/platsmp.c |  21 +-----
>> drivers/firmware/qcom_scm.c  | 154 +++++++++++++++++++++++++++++++++=
+++++++++-
>> include/linux/qcom_scm.h     |  17 +++--
>> 3 files changed, 163 insertions(+), 29 deletions(-)
>>=20
>> --=20
>> 2.1.0
>>=20

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project

