From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCHv3 1/7] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
Date: Tue, 16 Dec 2014 10:23:50 +0900
Message-ID: <548F89A6.7000202@samsung.com>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
 <1418372852-12454-2-git-send-email-cw00.choi@samsung.com>
 <1418655186.20866.5.camel@AMDC1943>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1418655186.20866.5.camel@AMDC1943>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 12/15/2014 11:53 PM, Krzysztof Kozlowski wrote:
> On pi=C4=85, 2014-12-12 at 17:27 +0900, Chanwoo Choi wrote:
>> This patch add new devfreq_event class for devfreq_event device whic=
h provide
>> raw data (e.g., memory bus utilization/GPU utilization). This raw da=
ta from
>> devfreq_event data would be used for the governor of devfreq subsyst=
em.
>> - devfreq_event device : Provide raw data for governor of existing d=
evfreq device
>> - devfreq device       : Monitor device state and change frequency/v=
oltage of device
>>                          using the raw data from devfreq_event devic=
e
>>
>> The devfreq subsystem support generic DVFS(Dynamic Voltage/Frequency=
 Scaling)
>> for Non-CPU Devices. The devfreq device would dertermine current dev=
ice state
>> using various governor (e.g., ondemand, performance, powersave). Aft=
er completed
>> determination of system state, devfreq device would change the frequ=
ency/voltage
>> of devfreq device according to the result of governor.
>>
>> But, devfreq governor must need basic data which indicates current d=
evice state.
>> Existing devfreq subsystem only consider devfreq device which check =
current system
>> state and determine proper system state using basic data. There is n=
o subsystem
>> for device providing basic data to devfreq device.
>>
>> The devfreq subsystem must need devfreq_event device(data-provider d=
evice) for
>> existing devfreq device. So, this patch add new devfreq_event class =
for
>> devfreq_event device which read various basic data(e.g, memory bus u=
tilization,
>> GPU utilization) and provide measured data to existing devfreq devic=
e through
>> standard APIs of devfreq_event class.
>>
>> The following description explains the feature of two kind of devfre=
q class:
>> - devfreq class (existing)
>>  : devfreq consumer device use raw data from devfreq_event device fo=
r
>>    determining proper current system state and change voltage/freque=
ncy
>>    dynamically using various governors.
>>
>> - devfreq_event class (new)
>>  : Provide measured raw data to devfreq device for governor
>>
>> Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20
> [...]
>=20
>> +/**
>> + * devfreq_event_get_event() - Get event and total_event from devfr=
eq-event dev.
>> + * @edev	: the devfreq-event device
>> + *
>> + * Note that this function get the calculated event data from devfr=
eq-event dev
>> + * after stoping the progress of whole sequence of devfreq-event de=
v. Return
>> + * current event data and total_event should be stored in second pa=
rameter
>> + * (total_event).
>> + */
>> +u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *to=
tal_event)
>> +{
>=20
> I think this function should return int (0 for success, negative
> otherwise) and store the "event" under pointer passed as argument.
> Why? Because:
> 1. error conditions are indicated with 'return 0' but should be 'retu=
rn
> -EINVAL'
> 2. Exynos-ppmu driver returns -EINVAL.
> Checking for error conditions is in such case more complex than it
> should.

In this patchset,
the return value (event) and *total_event of devfreq_event_get_event() =
should
be used for busy_time/total_time of struct devfreq_dev_status (include/=
linux/devfreq.h).
The busy_time/total_time is 'unsigned long' type.

So, I'll modify the prototype of devfreq_event_get_event() as following=
 by adding
new 'devfreq_event_data' structure.

struct devfreq_event_data {
	u64 event;
	u64 total_event;
};

int devfreq_event_get_event(struct devfreq_event_edev *edev, struct dev=
freq_event_data *edata);

Best Regards,
Chanwoo Choi



--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
