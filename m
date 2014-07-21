From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
Date: Mon, 21 Jul 2014 18:35:25 +0100
Message-ID: <9hh8unmr4wy.fsf@arm.com>
References: <32148397.172891405898897186.JavaMail.weblogic@epml01>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:53769 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932502AbaGURgF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Jul 2014 13:36:05 -0400
In-Reply-To: <32148397.172891405898897186.JavaMail.weblogic@epml01>
	(=?utf-8?B?Iu2VqOuqheyjvCIncw==?= message of "Sun, 20 Jul 2014 23:28:17
 +0000 (GMT)")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "orjan.eide@arm.com" <orjan.eide@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

=ED=95=A8=EB=AA=85=EC=A3=BC <myungjoo.ham@samsung.com> writes:

> Sender : Punit Agrawal<punit.agrawal@arm.com>
>> From: =C3=98rjan Eide=20
>>
>> These functions are indended for use by drivers and should be availa=
ble
>> also when the driver is built as a module.
>>
>> Cc: MyungJoo Ham=20
>> Cc: Kyungmin Park=20
>> Signed-off-by: =C3=98rjan Eide=20
>
> Dear Punit,

Hi MyungJoo,

>
>
> Just being curious, is there any reason not to use EXPORT_SYMBOL_GPL =
?

No reason other than to match the existing EXPORT_SYMBOLs in this file.

Would you prefer this and the following patch to use EXPORT_SYMBOL_GPL
instead?

>
>
> Cheers,
> MyungJoo.
>
> --
> MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD
> Frontier CS Lab, Software Center
> Samsung Electronics
> Cell: +82-10-6714-2858--
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
