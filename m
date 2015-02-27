From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2] qcom: scm: Add qcom_scm_set_warm_boot_addr function
Date: Fri, 27 Feb 2015 16:01:50 -0600
Message-ID: <BAA7F8B7-B616-46B1-9753-18A8A1637BF6@codeaurora.org>
References: <1425070047-53449-1-git-send-email-lina.iyer@linaro.org> <EB14AE95-372C-4908-AD4B-D354A01197B7@codeaurora.org> <20150227215125.GF1678@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34453 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbbB0WBy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 17:01:54 -0500
In-Reply-To: <20150227215125.GF1678@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org


On Feb 27, 2015, at 3:51 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Fri, Feb 27 2015 at 14:33 -0700, Kumar Gala wrote:
>>=20
>> On Feb 27, 2015, at 2:47 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>=20
>>> A core can be powered down for cpuidle or when it is hotplugged off=
=2E In
>>> either case, the warmboot return address would be different. Allow
>>> setting the warmboot address for a specific cpu, optimize and write=
 to
>>> the firmware, if the address is different than the previously set
>>> address.
>>>=20
>>> Export qcom_scm_set_warm_boot_addr function move the warm boot flag=
s to
>>> implementation.
>>>=20
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> drivers/firmware/qcom_scm.c | 36 ++++++++++++++++++++++++++++++++++=
++
>>> include/linux/qcom_scm.h    |  5 +----
>>> 2 files changed, 37 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_sc=
m.c
>>> index 6e7a72b..19133ca 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -34,6 +34,23 @@
>>> #define QCOM_SCM_ERROR		-1
>>> #define QCOM_SCM_INTERRUPTED	1
>>>=20
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU0	0x04
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU1	0x02
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU2	0x10
>>> +#define QCOM_SCM_FLAG_WARMBOOT_CPU3	0x40
>>> +
>>> +struct scm_warmboot {
>>> +	int flag;
>>> +	void *entry;
>>> +};
>>> +
>>> +static struct scm_warmboot scm_flags[] =3D {
>>> +	{ .flag =3D QCOM_SCM_FLAG_WARMBOOT_CPU0 },
>>> +	{ .flag =3D QCOM_SCM_FLAG_WARMBOOT_CPU1 },
>>> +	{ .flag =3D QCOM_SCM_FLAG_WARMBOOT_CPU2 },
>>> +	{ .flag =3D QCOM_SCM_FLAG_WARMBOOT_CPU3 },
>>> +};
>>> +
>>> static DEFINE_MUTEX(qcom_scm_lock);
>>>=20
>>> /**
>>> @@ -342,3 +359,22 @@ int qcom_scm_set_boot_addr(u32 addr, int flags=
)
>>> 			&cmd, sizeof(cmd), NULL, 0);
>>> }
>>> EXPORT_SYMBOL(qcom_scm_set_boot_addr);
>>> +
>>=20
>> Since you are adding a new interface, can you add Kdoc style comment=
 header.  I need to do this for the other interfaces as well.
>=20
> OK.
>=20
>>=20
>>> +int qcom_scm_set_warm_boot_addr(void *entry, int cpu)
>>=20
>> I=92d really like to see if we could make the set_boot_addr and set_=
warm_boot_addr have the same interfaces.
>=20
> I am working on making the interfaces similar. There is some check in
> the platsmp.c that uses the cold boot flag array to determine the
> present cpus. Do you think, we can ignore that check over there? If t=
hat
> can be done, I will change the interface for cold boot too.

I don=92t see any reason we can=92t add qcom_scm_set_cold_boot_addr() m=
ove the flags such that they only exist in qcom_scm_set_boot_addr and m=
ake qcom_scm_set_boot_addr static.

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project

