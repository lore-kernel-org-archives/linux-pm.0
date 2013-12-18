From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 2/2] charger-manager : Support deivce tree in charger
 manager driver
Date: Wed, 18 Dec 2013 14:47:06 +0900
Message-ID: <52B136DA.9060608@samsung.com>
References: <1387332853-5923-1-git-send-email-jonghwa3.lee@samsung.com>
 <1387332853-5923-3-git-send-email-jonghwa3.lee@samsung.com>
 <CAKDJKT658j+1DMEZnrADzZt=+uPbT4G8cs9AntXq491=Y5X8dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48882 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab3LRFrJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 00:47:09 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXZ00C6SMQJ0120@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 18 Dec 2013 14:47:07 +0900 (KST)
In-reply-to: <CAKDJKT658j+1DMEZnrADzZt=+uPbT4G8cs9AntXq491=Y5X8dw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, myungjoo.ham@samsung.com, cw00.choi@samsung.com

Hi,
On 2013=EB=85=84 12=EC=9B=94 18=EC=9D=BC 12:26, Manish Badarkhe wrote:

> Hi
>=20
>> +static inline struct charger_desc *cm_get_drv_data(struct platform_=
device *pdev)
>> +{
>> +#ifdef CONFIG_OF
>> +       if (pdev->dev.of_node)
>> +               return of_cm_parse_desc(&pdev->dev);
>> +#endif
>> +       return (struct charger_desc *)dev_get_platdata(&pdev->dev);
>> +}
>=20
> Can you make use of IS_ENABLED(CONFIG_OF) to get rid of #ifdef?
>=20

Ok, no problem.

Thanks,
Jonghwa

> Thanks
> Manish Badarkhe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


