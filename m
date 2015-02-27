From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2] qcom: scm: Add qcom_scm_set_warm_boot_addr function
Date: Fri, 27 Feb 2015 15:11:56 -0700
Message-ID: <20150227221156.GG1678@linaro.org>
References: <1425070047-53449-1-git-send-email-lina.iyer@linaro.org>
 <EB14AE95-372C-4908-AD4B-D354A01197B7@codeaurora.org>
 <20150227215125.GF1678@linaro.org>
 <BAA7F8B7-B616-46B1-9753-18A8A1637BF6@codeaurora.org>
 <7AD3AAF7-E7D2-4D26-9897-46A6122E66BA@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7AD3AAF7-E7D2-4D26-9897-46A6122E66BA@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 27 2015 at 15:07 -0700, Kumar Gala wrote:
>>>>> +int qcom_scm_set_warm_boot_addr(void *entry, int cpu)
>>>>
>>>> I=E2=80=99d really like to see if we could make the set_boot_addr =
and set_warm_boot_addr have the same interfaces.
>>>
>>> I am working on making the interfaces similar. There is some check =
in
>>> the platsmp.c that uses the cold boot flag array to determine the
>>> present cpus. Do you think, we can ignore that check over there? If=
 that
>>> can be done, I will change the interface for cold boot too.
>>
>> I don=E2=80=99t see any reason we can=E2=80=99t add qcom_scm_set_col=
d_boot_addr() move the flags such that they only exist in qcom_scm_set_=
boot_addr and make qcom_scm_set_boot_addr static.
>>
>> - k
>
>Looking at this for another minute, I think we should have the interfa=
ces be something like:
>
>qcom_scm_set_cold_boot_addr(void * entry, cpumask_t mask);
>qcom_scm_set_warm_boot_addr(void * entry, cpumask_t mask);

Very similar to what I was thinking. I will send another patchest when =
I
get to it.

>
>- k
>
>--=20
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Fo=
rum,
>a Linux Foundation Collaborative Project
>
