From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Tue, 9 Aug 2011 14:27:19 +0900
Message-ID: <CAJ0PZbQNOybrwu=Vxbjgbh-U1YA1Gve=jzpt3wwqA8kgEEPcXA@mail.gmail.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl> <87livba2w6.fsf@ti.com>
	<CAJ0PZbTMn_pzFBWbhtMrMo9ZGsnwMNKENgMSDa=oOZCrGh03Gg@mail.gmail.com>
	<87aabq5oqo.fsf@ti.com>
	<CAJ0PZbQQkAPHNwzh0tL9BiNAjjMtUOCoKV1JDzUqj0utx8COgg@mail.gmail.com>
	<CAJOA=zMNToQq=RVrRh2p+kko=n67BWwHjcWX3DGFuYCfAcksOQ@mail.gmail.com>
	<CAJ0PZbQx-T+36eX7MiZqWSMxD-achZ9Z7G_kDWNQ2n0h1NTWSQ@mail.gmail.com>
	<CAJOA=zOi9HzM7M72C+QS6iLcYD_xDeQkEZ3fYpVo_v4f4mfAyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJOA=zOi9HzM7M72C+QS6iLcYD_xDeQkEZ3fYpVo_v4f4mfAyQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Turquette, Mike" <mturquette@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 9, 2011 at 4:13 AM, Turquette, Mike <mturquette@ti.com> wrote:
> On Thu, Aug 4, 2011 at 11:18 PM, MyungJoo Ham <myungjoo.ham@gmail.com> wr=
ote:
>> On Fri, Aug 5, 2011 at 6:59 AM, Turquette, Mike <mturquette@ti.com> wrot=
e:
>>> On Thu, Aug 4, 2011 at 1:15 AM, MyungJoo Ham <myungjoo.ham@gmail.com> w=
rote:
>>>>
>>>> Ok.. I see.
>>>>
>>>> Now, I can agree with you that tickle is subset of QoS request.
>>>>
>>>> As long as we have QoS request feature on devices with either OPP or
>>>> DEVFREQ, tickling is not needed.
>>>>
>>>> I'll remove tickle in the next revision (along with some bugfixes for
>>>> bugs found recently).
>>>>
>>>>
>>>> Anyway, it appears that clock-rate-wise QoS request may be dealt at
>>>> OPP so that the OPPs meeting the QoS requests w/ frequency or voltage
>>>> specifications are enabled and returned with opp_find_* functions.
>>>> Maybe we will need to separate enable/disable by
>>>> opp_enable()/opp_disable() from enable/disable by QoS requests so that
>>>> the two may have different semantics. Then, QoS requests cannot
>>>> override opp_disable and opp_enable cannot override QoS requests. This
>>>> way, any clock-setting code properly based on OPP (including any
>>>> customized devfreq governors) cannot violate QoS requests.
>>>
>>> If devfreq used the QoS API in it's ->target() call then this would
>>> not be an issue, and further illustrates the idea of devfreq simply
>>> being a policy into a proper QoS API.
>>>
>>> Regards,
>>> Mike
>>>
>>
>> Yes, if we choose an OPP that meets the PM-QoS requests before calling
>> ->target() in devfreq_do(), there wouldn't be an issue.
>>
>> However, if a device is using DEVFREQ, it also means the device has
>> OPPs (mandatory for DEVFREQ). If the device is using PM QoS as well as
>> OPP, I guess the correctly implemented device driver needs to call
>> opp_enable() and opp_disable() according to PM QoS's update_target()
>> calls through the PM QoS notifier cb.
>>
>> Then, for such drivers, DEVFREQ automatically meets PM QoS requests
>> without any modification; as long as QoS meeting OPPs are enabled at
>> the device driver's PM QoS callback, there is no QoS issue.
>>
>> Therefore, now, it appears that neither OPP or DEVFREQ should be
>> allowed to directly touch PM QoS APIs, but, the device driver should
>> do so with notifier by simply calling opp-enable/disable if the
>> frequency is the key QoS "actuator".
>>
>> If we are going to let DEVFREQ handle its corresponding devices' PM
>> QoS APIs, it would mean that both device driver and its DEVFREQ codes
>> will be handling PM QoS API duplicated (or worse, inconsistently).
>
> I'm not getting too bogged down with the OPP specifics because I don't
> know if that interface is going to be used in the future, and I don't
> think that devfreq will need to know about OPPs once the DVFS QoS API
> exists. =A0In that case, devfreq can just requests clock frequencies
> through the QoS API. =A0I view devfreq's usage of the OPP library as
> temporary.
>
> The real issue here is that we don't want some weird feedback loop
> with device QoS requests and devfreq targets stepping on each other.
>
> One way to handle this is to partition QoS use in drivers away from
> devfreq usage. =A0For example, if a GPU supports performance counters
> and can introspect its own usage, then it is a perfect candidate for
> devfreq; on the flip-side device drivers should *not* be allowed to
> put performance/qos constraints on this particular GPU, since we
> assume that the performance counters/devfreq governor will handle the
> whole job for us. =A0Since this centralizes the decision-making for the
> GPU it is safe for the devfreq->target() call to use the QoS APIs for
> controlling the GPU, since no one else will. =A0This avoids the feedback
> loop.
>
> On the other hand, if the GPU does not support performance counters
> then it should not use devfreq at all and rely 100% of QoS constraints
> from various sources: the GPU driver might request a high OPP every
> time work comes in, coupled with a timeout; if a QoS knob is exported
> to userspace then some OpenGL library might hold constraints through
> it; or some other kernel driver (video-related?) needs to use the GPU
> then it can hold a constraint through the QoS API.
>
> So there is a clear partition of QoS API usage between devices that
> support performance counters and ones that do not. =A0We want to avoid a
> feedback loop here.

Such weird feedback loop may happen if the result frequency ranges
from QoS are inconsistent with those from DEVFREQ. However, if DEVFREQ
provides frequencies that do not violate QoS requirements, there would
be no such feedback loop. If they are consistent (DEVFREQ never gives
frequencies that do NOT satisfy QoS), DEVFREQ is transparent to PM
QoS.

For now, with OPPs, DEVFREQ will always select frequencies that
satisfy QoS requirements if the driver implementation is correct.

However, as you mentioned, if we assume that OPP is going to disappear
in the future kernel, then we will somehow need to design an interface
for device drivers to provide lists of available frequencies to
DEVFREQ and those lists are going to be runtime-update-able and where
QoS requirements are applied. As with the current DEVFREQ
implementation, if DEVFREQ chooses frequencies only from those enabled
by the driver (meeting the QoS requirements), things are same with the
cases with OPPs. The reason why QoS requirements are being interpreted
at device drivers, not at DEVFREQ, is that the device driver itself is
the only entity that can interpret QoS requests to frequencies
(latency/#ops/... --> Hz).

And, for the another point, making PM QoS disabled (or ignored?) for
devices with DEVFREQ, I guess that should be left for each device
driver's decision. Even when DVFS is used for a device, there are
cases where QoS requests are needed as well because DEVFREQ is based
on polling which incurs response time that is not acceptable for some
cases: e.g., a sudden user input at idle in a system with high-speed
displays. Besides, there could be another type of PM QoS requirements:
"under xxx MHz" in order to restrict (or as a response to) the
temperature or power consumption rate, which should affect DEVFREQ's
behavior. For battery-powered devices (laptops will want to do so as
well at userspace), I guess such features will be soon needed; at
least, we are working on it.


Cheers!
MyungJoo

>
> Regards,
> Mike
>
>> Cheers,
>> MyungJoo
>>
>>>> How about this concept of getting QoS requests associated with clock r=
ates?
>>>>
>>>>
>>>>
>>>> Cheers!
>>>> MyungJoo.
>>>> --
>>>> MyungJoo Ham, Ph.D.
>>>> Mobile Software Platform Lab,
>>>> Digital Media and Communications (DMC) Business
>>>> Samsung Electronics
>>>> cell: 82-10-6714-2858
>>>> _______________________________________________
>>>> linux-pm mailing list
>>>> linux-pm@lists.linux-foundation.org
>>>> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>>>>
>>>
>>
>>
>>
>> --
>> MyungJoo Ham, Ph.D.
>> Mobile Software Platform Lab,
>> Digital Media and Communications (DMC) Business
>> Samsung Electronics
>> cell: 82-10-6714-2858
>>
>



-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
