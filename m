From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Add devfreq-event entry
Date: Thu, 05 Nov 2015 13:03:38 +0900
Message-ID: <563AD51A.3000603@samsung.com>
References: <1446692407-18247-1-git-send-email-cw00.choi@samsung.com>
 <1446693434.21133.79.camel@perches.com> <563ACB2C.7030303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:33063 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbbKEEDk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 23:03:40 -0500
In-reply-to: <563ACB2C.7030303@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, myungjoo.ham@samsung.com, rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Hi Joe,

On 2015=EB=85=84 11=EC=9B=94 05=EC=9D=BC 12:21, Chanwoo Choi wrote:
> Hi Joe,
>=20
> On 2015=EB=85=84 11=EC=9B=94 05=EC=9D=BC 12:17, Joe Perches wrote:
>> On Thu, 2015-11-05 at 12:00 +0900, Chanwoo Choi wrote:
>>> This patch adds the devfreq-event[1] entry to review the patches
>>> as just supporter. Patches will be picked up by Myungjoo Ham on
>>> devfreq git repository.
>>> [1] https://lkml.org/lkml/2015/1/25/573
>> []
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>> []
>>> @@ -3340,6 +3340,15 @@ L:	linux-pm@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/devfreq/
>>> =20
>>> +DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
>>> +M:	Chanwoo Choi <cw00.choi@samsung.com>
>>> +L:	linux-pm@vger.kernel.org
>>> +S:	Supported
>>> +F:	drivers/devfreq/event
>>> +F:	drivers/devfreq/devfreq-event.c
>>> +F:	include/linux/devfreq-event.h
>>> +F:	Documentation/devicetree/bindings/devfreq/event
>>> +
>>>  DEVICE NUMBER REGISTRY
>>>  M:	Torben Mathiasen <device@lanana.org>
>>>  W:	http://lanana.org/docs/device-list/index.html
>>
>> It'd be nice to update the DEVFREQ MAINTAINERS entry (and maybe
>> this one as well) so it has the appropriate git repository listed.
>=20
> How can I update the DEVFREQ MAINTAINER entry?
> If you add more detailed comment, I would appreciate=20

Do you mean that update the DEVFREQ-EVENT entry as following?
I add the devfreq git repository information.

diff --git a/MAINTAINERS b/MAINTAINERS
index bd18978d5ad3..0a6de68342e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3340,6 +3340,16 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	drivers/devfreq/
=20
+DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+L:	linux-pm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Supported
+F:	drivers/devfreq/event/
+F:	drivers/devfreq/devfreq-event.c
+F:	include/linux/devfreq-event.h
+F:	Documentation/devicetree/bindings/devfreq/event/
+

Thanks,
Chanwoo Choi

>=20
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index caddb49..ca0ae09 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3349,6 +3349,7 @@ DEVICE FREQUENCY (DEVFREQ)
>>  M:	MyungJoo Ham <myungjoo.ham@samsung.com>
>>  M:	Kyungmin Park <kyungmin.park@samsung.com>
>>  L:	linux-pm@vger.kernel.org
>> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.gi=
t
>=20
> OK. I'll update it.
>=20
> Thanks,
> Chanwoo Choi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

