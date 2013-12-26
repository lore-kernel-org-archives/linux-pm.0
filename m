From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 3/3] fuelgauge: max17042: Seperate available property set
 for different operation.
Date: Thu, 26 Dec 2013 11:19:35 +0900
Message-ID: <52BB9237.4030908@samsung.com>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
 <1387338834-4046-4-git-send-email-jonghwa3.lee@samsung.com>
 <20131224030206.GI10223@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:52799 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3LZCTl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Dec 2013 21:19:41 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MYE0058E6GSNP20@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Thu, 26 Dec 2013 11:19:40 +0900 (KST)
In-reply-to: <20131224030206.GI10223@lizard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, MyungJoo Ham <myungjoo.ham@samsung.com>

On 2013=EB=85=84 12=EC=9B=94 24=EC=9D=BC 12:02, Anton Vorontsov wrote:

> On Wed, Dec 18, 2013 at 12:53:54PM +0900, Jonghwa Lee wrote:
>> max17042 fuelgauge driver supports various successors based on max17=
042.
>> Some versions use currrent sensor and temperature sensor to increase=
 accuracy,
>> while others don't. So this patch makes driver to support seperate p=
roperty set
>> depending on chip implementation.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> ---
>=20
> You'll have to reiterate this patch as patch 1/3 needs to go.
>=20


Okay, I'll revise it.

Thanks,
Jonghwa

> Thanks,
>=20
> Anton
>=20


