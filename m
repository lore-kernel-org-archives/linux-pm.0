From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v6 04/21] PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER
 notifier
Date: Mon, 28 Mar 2016 12:35:21 +0900
Message-ID: <56F8A679.5010009@samsung.com>
References: <190611333.27621459133690582.JavaMail.weblogic@epmlwas02a>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <190611333.27621459133690582.JavaMail.weblogic@epmlwas02a>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?UTF-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016=EB=85=84 03=EC=9B=94 28=EC=9D=BC 11:54, MyungJoo Ham wrote:
>>  =20
>>  This patch adds the new DEVFREQ_TRANSITION_NOTIFIER notifier to sen=
d
>> the notification when the frequency of device is changed.
>> This notifier has two state as following:
>> - DEVFREQ_PRECHANGE  : Notify it before chaning the frequency of dev=
ice
>> - DEVFREQ_POSTCHANGE : Notify it after changed the frequency of devi=
ce
>>
>> And this patch adds the resourced-managed function to release the re=
source
>> automatically when error happen.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/devfreq/devfreq.c | 163 +++++++++++++++++++++++++++++++++++=
++++++++++-
>>  include/linux/devfreq.h   |  58 ++++++++++++++++-
>>  2 files changed, 219 insertions(+), 2 deletions(-)
>=20
> []
>=20
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index aa0b8424ebc3..152ea342529c 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -19,6 +19,13 @@
>> =20
>>  #define DEVFREQ_NAME_LEN 16
>> =20
>> +/* DEVFREQ notifier interface */
>> +#define DEVFREQ_TRANSITION_NOTIFIER	(0)
>> +
>> +/* Transition notifiers of DEVFREQ_TRANSITION_NOTIFIER */
>> +#define	DEVFREQ_PRECHANGE		(0)
>> +#define DEVFREQ_POSTCHANGE		(1)
>> +
>>  struct devfreq;
>> =20
>>  /**
>> @@ -177,6 +184,13 @@ struct devfreq {
>>  	unsigned int *trans_table;
>>  	unsigned long *time_in_state;
>>  	unsigned long last_stat_updated;
>> +
>> +	struct srcu_notifier_head transition_notifier_list;
>> +};
>=20
> Like other properties of struct devfreq, please add
> descriptions above. Other than that, it looks good.

OK. I was missing the description. I'll add it.

Best Regards,
Chanwoo Choi
