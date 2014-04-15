From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Use freq_table for available_frequencies
Date: Mon, 14 Apr 2014 22:16:10 -0700
Message-ID: <534CC09A.30200@codeaurora.org>
References: <8568895.444151397525760132.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <8568895.444151397525760132.JavaMail.weblogic@epml02>
Sender: linux-arm-msm-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/14/2014 06:36 PM, =C7=D4=B8=ED=C1=D6 wrote:
>> MyungJoo/Kyungmin,
>>
>> Bump. Can we accept this patch please?
>>
>> -Saravana
>=20
> Nack.
>=20
> Please note that freq_table is also an optional value, which may
> be null.

Ah, I saw that the max_freq would be zero if freq_table was NULL and I
assumed that it can't be NULL. But I see that the max_freq limit is not
applied if it's zero. Thanks for catching it.

> Besides, please be aware that your code is under rcu_read_lock().

Valid point. I was just trying to keep the diff simple. No one's really
going to be catting this file often when performance matters.

>=20
>=20
> Cheers,
> MyungJoo.
>=20
> ps. I'll send a related patch (avoid accessing null but not-an-error
> pointer at other sysfs nodes). Thank you for letting me catch such bu=
gs anyway.

I can go ahead and do this myself if you don't mind.

-Saravana

--=20
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
hosted by The Linux Foundation
