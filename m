From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Wed, 17 Aug 2011 19:07:37 +0900
Message-ID: <CAJ0PZbSJoxNPn=E0y=52+y9uW+y1S7bZXc4vsBUm1QR2RQEPvg@mail.gmail.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl> <87livba2w6.fsf@ti.com>
	<CAJ0PZbTMn_pzFBWbhtMrMo9ZGsnwMNKENgMSDa=oOZCrGh03Gg@mail.gmail.com>
	<87aabq5oqo.fsf@ti.com>
	<CAJ0PZbQQkAPHNwzh0tL9BiNAjjMtUOCoKV1JDzUqj0utx8COgg@mail.gmail.com>
	<CAJOA=zMNToQq=RVrRh2p+kko=n67BWwHjcWX3DGFuYCfAcksOQ@mail.gmail.com>
	<CAJ0PZbQx-T+36eX7MiZqWSMxD-achZ9Z7G_kDWNQ2n0h1NTWSQ@mail.gmail.com>
	<CAJOA=zOi9HzM7M72C+QS6iLcYD_xDeQkEZ3fYpVo_v4f4mfAyQ@mail.gmail.com>
	<CAJ0PZbQNOybrwu=Vxbjgbh-U1YA1Gve=jzpt3wwqA8kgEEPcXA@mail.gmail.com>
	<CAJOA=zNRidM+y6FokWH9xorinQMWKHTyCGXoTNYCpLOfNPsYNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJOA=zNRidM+y6FokWH9xorinQMWKHTyCGXoTNYCpLOfNPsYNA@mail.gmail.com>
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

On Thu, Aug 11, 2011 at 10:28 AM, Turquette, Mike <mturquette@ti.com> wrote:
> On Mon, Aug 8, 2011 at 10:27 PM, MyungJoo Ham <myungjoo.ham@gmail.com> wr=
ote:
>> On Tue, Aug 9, 2011 at 4:13 AM, Turquette, Mike <mturquette@ti.com> wrot=
e:
>>> I'm not getting too bogged down with the OPP specifics because I don't
>>> know if that interface is going to be used in the future, and I don't
>>> think that devfreq will need to know about OPPs once the DVFS QoS API
>>> exists. =A0In that case, devfreq can just requests clock frequencies
>>> through the QoS API. =A0I view devfreq's usage of the OPP library as
>>> temporary.
>>>
>>> The real issue here is that we don't want some weird feedback loop
>>> with device QoS requests and devfreq targets stepping on each other.
>>>
>>> One way to handle this is to partition QoS use in drivers away from
>>> devfreq usage. =A0For example, if a GPU supports performance counters
>>> and can introspect its own usage, then it is a perfect candidate for
>>> devfreq; on the flip-side device drivers should *not* be allowed to
>>> put performance/qos constraints on this particular GPU, since we
>>> assume that the performance counters/devfreq governor will handle the
>>> whole job for us. =A0Since this centralizes the decision-making for the
>>> GPU it is safe for the devfreq->target() call to use the QoS APIs for
>>> controlling the GPU, since no one else will. =A0This avoids the feedback
>>> loop.
>>>
>>> On the other hand, if the GPU does not support performance counters
>>> then it should not use devfreq at all and rely 100% of QoS constraints
>>> from various sources: the GPU driver might request a high OPP every
>>> time work comes in, coupled with a timeout; if a QoS knob is exported
>>> to userspace then some OpenGL library might hold constraints through
>>> it; or some other kernel driver (video-related?) needs to use the GPU
>>> then it can hold a constraint through the QoS API.
>>>
>>> So there is a clear partition of QoS API usage between devices that
>>> support performance counters and ones that do not. =A0We want to avoid a
>>> feedback loop here.
>>
>> Such weird feedback loop may happen if the result frequency ranges
>> from QoS are inconsistent with those from DEVFREQ. However, if DEVFREQ
>> provides frequencies that do not violate QoS requirements, there would
>> be no such feedback loop. If they are consistent (DEVFREQ never gives
>> frequencies that do NOT satisfy QoS), DEVFREQ is transparent to PM
>> QoS.
>
> If two devices, x and y both place frequency constraints on device z,
> then QoS should probably aggregate their requests instead of just
> taking the max. =A0Then if devfreq also determines that it needs to make
> a QoS request against device z, then that will get aggregated on top
> of x and y's requests. =A0This isn't really what we want since x and y's
> requests may be adequate and devfreq's performance counter sampling is
> just requesting performance for operations which have already placed
> requests.

DEVFREQ won't give contradicting frequencies with PM QoS inputs to the
target device. DEVFREQ will choose one from frequencies that satisfy
the PM QoS inputs from both x and y (probably aggregated by PM QoS
framework) as long as the PM QoS part of the target device driver is
properly implemented by enabling satisfying OPPs and disabling
not-satisfying OPPs.

>
>> For now, with OPPs, DEVFREQ will always select frequencies that
>> satisfy QoS requirements if the driver implementation is correct.
>>
>> However, as you mentioned, if we assume that OPP is going to disappear
>> in the future kernel, then we will somehow need to design an interface
>> for device drivers to provide lists of available frequencies to
>> DEVFREQ and those lists are going to be runtime-update-able and where
>> QoS requirements are applied. As with the current DEVFREQ
>
> I'm not saying that OPP is going to disappear because I have no idea
> what the future holds.
>
> My point is that devfreq doesn't need to know about OPP at all. =A0The
> code assumes that OPPs exist for the device and take a frequency as
> part of devfreq->profile->get_target_freq (or something like that) and
> they can just pass that frequency to devfreq->profile->target. =A0If
> that device has support for the OPP library than it can do the job of
> looking up OPPs, etc.

As discussed in the other thread, OPP is the one that describes the
data every DVFS-able device have. Is there any reason to redundantly
define the same data structure and functions that are publicly
available and represent the same things? Every DEVFREQ device will
have multiple pairs of frequencies and voltages associated with the
specific device and use the functions equivalent to those in OPP
library.

>
> Regards,
> Mike
>

Cheers!
MyungJoo
-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
