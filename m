From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2] thermal: consistently use int for trip temp
Date: Mon, 14 Mar 2016 17:44:07 +0800
Message-ID: <56E687E7.4090802@nvidia.com>
References: <1456997626-28298-1-git-send-email-wni@nvidia.com> <56DD3A84.4080304@nvidia.com> <56DE45F7.6060307@nvidia.com> <20160308210900.GB8145@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17287 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933711AbcCNJoD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 05:44:03 -0400
In-Reply-To: <20160308210900.GB8145@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8809=E6=97=A5 05:09, Eduardo Valentin wrote:
> On Tue, Mar 08, 2016 at 11:24:39AM +0800, Wei Ni wrote:
>>
>>
>> On 2016=E5=B9=B403=E6=9C=8807=E6=97=A5 16:23, Wei Ni wrote:
>>> There had a build error in previous patch.
>>> Fixed it in this version.
>>> Please review it.
>>
>> Add CC: linux-pm@vger.kernel.org
>>

Hi Rui,
Will you take this patch?

>>>
>>> Thanks.
>>> Wei.
>>>
>>> On 2016=E5=B9=B403=E6=9C=8803=E6=97=A5 17:33, Wei Ni wrote:
>>>> The commit 17e8351a7739 consistently use int for temperature,
>>>> however it missed a few in trip temperature and thermal_core.
>>>>
>>>> In current codes, the trip->temperature used "unsigned long"
>>>> and zone->temperature used"int", if the temperature is negative
>>>> value, it will get wrong result when compare temperature with
>>>> trip temperature.
>>>>
>>>> This patch can fix it.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>=20
> Rui are you collecting this one?
>=20
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>=20
