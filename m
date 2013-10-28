From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 1/3] charger-manager : Replace kzalloc to devm_kzalloc and
 remove uneccessary code.
Date: Mon, 28 Oct 2013 11:01:22 +0900
Message-ID: <526DC572.7060504@samsung.com>
References: <1382669253-23629-1-git-send-email-jonghwa3.lee@samsung.com>
 <1382669253-23629-2-git-send-email-jonghwa3.lee@samsung.com>
 <20131025233041.GB13859@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26907 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546Ab3J1CBX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Oct 2013 22:01:23 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVC0083WWA446D0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 28 Oct 2013 11:01:22 +0900 (KST)
In-reply-to: <20131025233041.GB13859@teo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Vorontsov <anton@enomsg.org>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com

On 2013=EB=85=84 10=EC=9B=94 26=EC=9D=BC 08:30, Anton Vorontsov wrote:

> On Fri, Oct 25, 2013 at 11:47:31AM +0900, Jonghwa Lee wrote:
>> Use devm function for dynamic memory allocation.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> ---
>=20
> 1/3 applied, thanks!
>=20
> Anton


Thanks,
Jonghwa

>=20


