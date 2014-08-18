From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 1/2] PM / devfreq: Export helper functions for drivers
Date: Mon, 18 Aug 2014 14:15:48 +0100
Message-ID: <9hhsikuey63.fsf@arm.com>
References: <2126088679.390471407886644188.JavaMail.weblogic@epmlwas02a>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <2126088679.390471407886644188.JavaMail.weblogic@epmlwas02a>
	(=?utf-8?B?Iu2VqOuqheyjvCIncw==?= message of "Tue, 12 Aug 2014 23:37:25
 +0000 (GMT)")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "Hernandez, Carlos" <ceh@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "orjan.eide@arm.com" <orjan.eide@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

=ED=95=A8=EB=AA=85=EC=A3=BC <myungjoo.ham@samsung.com> writes:

>> ------- Original Message -------
>> Sender : Hernandez, Carlos<ceh@ti.com>
>> Date : 2014-08-12 22:49 (GMT+09:00)
>> Title : RE: [PATCH 1/2] PM / devfreq: Export helper functions for dr=
ivers
>>=20
>> Acked-By: Carlos Hernandez=20
>>=20
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@=
vger.kernel.org] On Behalf Of Punit Agrawal
>> Sent: Friday, July 18, 2014 10:10 AM
>> To: linux-pm@vger.kernel.org; linux-samsung-soc@vger.kernel.org
>> Cc: orjan.eide@arm.com; linux-kernel@vger.kernel.org; linux-arm-kern=
el@lists.infradead.org; MyungJoo Ham; Kyungmin Park
>> Subject: [PATCH 1/2] PM / devfreq: Export helper functions for drive=
rs
>>=20
>> From: =C3=98rjan Eide=20
>>=20
>> These functions are indended for use by drivers and should be availa=
ble also when the driver is built as a module.>=20
>>=20
>> Cc: MyungJoo Ham=20
>> Cc: Kyungmin Park=20
>> Signed-off-by: =C3=98rjan Eide=20
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>
> There will be some modifications to this patch for consistency with
> other pending patches, but please don't worry about them. I'll handle
> them while merging this.

Great! Thanks MyungJoo.

>
>
> Cheers,
> MyungJoo.
>
>> ---
>> drivers/devfreq/devfreq.c |    3 +++
>> 1 file changed, 3 insertions(+)
>
>
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
