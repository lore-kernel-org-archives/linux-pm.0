From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2] qcom: scm: Add qcom_scm_set_warm_boot_addr function
Date: Fri, 27 Feb 2015 16:07:35 -0600
Message-ID: <7AD3AAF7-E7D2-4D26-9897-46A6122E66BA@codeaurora.org>
References: <1425070047-53449-1-git-send-email-lina.iyer@linaro.org> <EB14AE95-372C-4908-AD4B-D354A01197B7@codeaurora.org> <20150227215125.GF1678@linaro.org> <BAA7F8B7-B616-46B1-9753-18A8A1637BF6@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34750 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbbB0WHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 17:07:37 -0500
In-Reply-To: <BAA7F8B7-B616-46B1-9753-18A8A1637BF6@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org

>>>> +int qcom_scm_set_warm_boot_addr(void *entry, int cpu)
>>>=20
>>> I=92d really like to see if we could make the set_boot_addr and set=
_warm_boot_addr have the same interfaces.
>>=20
>> I am working on making the interfaces similar. There is some check i=
n
>> the platsmp.c that uses the cold boot flag array to determine the
>> present cpus. Do you think, we can ignore that check over there? If =
that
>> can be done, I will change the interface for cold boot too.
>=20
> I don=92t see any reason we can=92t add qcom_scm_set_cold_boot_addr()=
 move the flags such that they only exist in qcom_scm_set_boot_addr and=
 make qcom_scm_set_boot_addr static.
>=20
> - k

Looking at this for another minute, I think we should have the interfac=
es be something like:

qcom_scm_set_cold_boot_addr(void * entry, cpumask_t mask);
qcom_scm_set_warm_boot_addr(void * entry, cpumask_t mask);

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project

