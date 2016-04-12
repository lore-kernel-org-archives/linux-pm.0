From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2] thermal: consistently use int for trip temp
Date: Tue, 12 Apr 2016 16:51:30 +0800
Message-ID: <570CB712.70305@nvidia.com>
References: <1456997626-28298-1-git-send-email-wni@nvidia.com> <56DD3A84.4080304@nvidia.com> <56DE45F7.6060307@nvidia.com> <20160308210900.GB8145@localhost.localdomain> <56E687E7.4090802@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:33502 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755917AbcDLIup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 04:50:45 -0400
In-Reply-To: <56E687E7.4090802@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8814=E6=97=A5 17:44, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8809=E6=97=A5 05:09, Eduardo Valentin wrote:
>> On Tue, Mar 08, 2016 at 11:24:39AM +0800, Wei Ni wrote:
>>>
>>>
>>> On 2016=E5=B9=B403=E6=9C=8807=E6=97=A5 16:23, Wei Ni wrote:
>>>> There had a build error in previous patch.
>>>> Fixed it in this version.
>>>> Please review it.
>>>
>>> Add CC: linux-pm@vger.kernel.org
>>>
>=20
> Hi Rui,
> Will you take this patch?

Rui, could you please take a look this patch?

>=20
>>>>
>>>> Thanks.
>>>> Wei.
>>>>
>>>> On 2016=E5=B9=B403=E6=9C=8803=E6=97=A5 17:33, Wei Ni wrote:
>>>>> The commit 17e8351a7739 consistently use int for temperature,
>>>>> however it missed a few in trip temperature and thermal_core.
>>>>>
>>>>> In current codes, the trip->temperature used "unsigned long"
>>>>> and zone->temperature used"int", if the temperature is negative
>>>>> value, it will get wrong result when compare temperature with
>>>>> trip temperature.
>>>>>
>>>>> This patch can fix it.
>>>>>
>>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>
>> Rui are you collecting this one?
>>
>> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
