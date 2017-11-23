From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/4] rk3399_dmc: Fix line continuation format
Date: Thu, 23 Nov 2017 11:35:30 +0900
Message-ID: <5A1633F2.6000103@samsung.com>
References: <1511347280.6989.81.camel@perches.com>
        <cover.1510845910.git.joe@perches.com>
        <7d659960e45f66894126fba9e2d54cf25ae1185b.1510845910.git.joe@perches.com>
        <5A150792.6050104@samsung.com>
        <CGME20171116152742epcas2p22b17887a4d7f2adcd3beb414988dbce3@epcms1p1>
        <20171123012100epcms1p13f78950557de06dbbd65996c8b0645ee@epcms1p1>
        <5A162835.5050806@samsung.com> <1511402826.2385.3.camel@perches.com>
        <5A162E8A.3040207@samsung.com> <1511403518.2385.8.camel@perches.com>
        <5A163119.1050500@samsung.com> <1511404163.2385.11.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42307 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdKWCff (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 21:35:35 -0500
In-reply-to: <1511404163.2385.11.camel@perches.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2017년 11월 23일 11:29, Joe Perches wrote:
> On Thu, 2017-11-23 at 11:23 +0900, Chanwoo Choi wrote:
>> On 2017년 11월 23일 11:18, Joe Perches wrote:
>>> never break user-visible strings such as
>>> printk messages, because that breaks the ability to grep for them
>>
>> So, I suggested "Or, we better to modify the error message within 80 char.".
> 
> Run checkpatch on your suggestion.
> You will get a "split_string" warning.

I knew about this. I don't like to hurt the readability
in order to fix the warning with the improper way.

If you want to fix it, I suggested that you better to modify
the error message within 80 char. Or I prefer the Myungjoo's opinion.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
