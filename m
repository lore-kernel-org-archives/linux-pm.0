From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCHv3 1/7] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
Date: Mon, 15 Dec 2014 15:53:06 +0100
Message-ID: <1418655186.20866.5.camel@AMDC1943>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
 <1418372852-12454-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1418372852-12454-2-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-12-12 at 17:27 +0900, Chanwoo Choi wrote:
> This patch add new devfreq_event class for devfreq_event device which=
 provide
> raw data (e.g., memory bus utilization/GPU utilization). This raw dat=
a from
> devfreq_event data would be used for the governor of devfreq subsyste=
m.
> - devfreq_event device : Provide raw data for governor of existing de=
vfreq device
> - devfreq device       : Monitor device state and change frequency/vo=
ltage of device
>                          using the raw data from devfreq_event device
>=20
> The devfreq subsystem support generic DVFS(Dynamic Voltage/Frequency =
Scaling)
> for Non-CPU Devices. The devfreq device would dertermine current devi=
ce state
> using various governor (e.g., ondemand, performance, powersave). Afte=
r completed
> determination of system state, devfreq device would change the freque=
ncy/voltage
> of devfreq device according to the result of governor.
>=20
> But, devfreq governor must need basic data which indicates current de=
vice state.
> Existing devfreq subsystem only consider devfreq device which check c=
urrent system
> state and determine proper system state using basic data. There is no=
 subsystem
> for device providing basic data to devfreq device.
>=20
> The devfreq subsystem must need devfreq_event device(data-provider de=
vice) for
> existing devfreq device. So, this patch add new devfreq_event class f=
or
> devfreq_event device which read various basic data(e.g, memory bus ut=
ilization,
> GPU utilization) and provide measured data to existing devfreq device=
 through
> standard APIs of devfreq_event class.
>=20
> The following description explains the feature of two kind of devfreq=
 class:
> - devfreq class (existing)
>  : devfreq consumer device use raw data from devfreq_event device for
>    determining proper current system state and change voltage/frequen=
cy
>    dynamically using various governors.
>=20
> - devfreq_event class (new)
>  : Provide measured raw data to devfreq device for governor
>=20
> Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

[...]

> +/**
> + * devfreq_event_get_event() - Get event and total_event from devfre=
q-event dev.
> + * @edev	: the devfreq-event device
> + *
> + * Note that this function get the calculated event data from devfre=
q-event dev
> + * after stoping the progress of whole sequence of devfreq-event dev=
=2E Return
> + * current event data and total_event should be stored in second par=
ameter
> + * (total_event).
> + */
> +u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *tot=
al_event)
> +{

I think this function should return int (0 for success, negative
otherwise) and store the "event" under pointer passed as argument.
Why? Because:
1. error conditions are indicated with 'return 0' but should be 'return
-EINVAL'
2. Exynos-ppmu driver returns -EINVAL.
Checking for error conditions is in such case more complex than it
should.


Best regards,
Krzysztof


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
