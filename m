From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Thu, 4 Aug 2011 14:59:22 -0700
Message-ID: <CAJOA=zMNToQq=RVrRh2p+kko=n67BWwHjcWX3DGFuYCfAcksOQ@mail.gmail.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl> <87livba2w6.fsf@ti.com>
	<CAJ0PZbTMn_pzFBWbhtMrMo9ZGsnwMNKENgMSDa=oOZCrGh03Gg@mail.gmail.com>
	<87aabq5oqo.fsf@ti.com>
	<CAJ0PZbQQkAPHNwzh0tL9BiNAjjMtUOCoKV1JDzUqj0utx8COgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQQkAPHNwzh0tL9BiNAjjMtUOCoKV1JDzUqj0utx8COgg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 4, 2011 at 1:15 AM, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
> On Thu, Aug 4, 2011 at 3:33 AM, Kevin Hilman <khilman@ti.com> wrote:
>> MyungJoo Ham <myungjoo.ham@samsung.com> writes:
>>
>>> On Wed, Aug 3, 2011 at 7:02 AM, Kevin Hilman <khilman@ti.com> wrote:
>>
>> [...]
>>
>>>> Maybe I'm not understanding the usage of it fully, but that seems like
>>>> hard-coding policy into the framework that might not be appropriate.
>>>> For example, what if there are other devices with constraints such that
>>>> they cannot currently scale frequency/voltage?
>>>>
>>>> Mabye MyungJoo can explain in more detail the usecases for tickle?
>>>
>>> Tickle is not for QoS between devices. It is for faster reaction to
>>> (human) user inputs at DVFS side where waiting for DVFS's reaction
>>> takes too much time and reducing polling interval costs too much.
>>
>> This is exactly what quality of service (QoS) is about.
>>
>> The user (whether it's a human user input or another device) has low
>> quality and expects higher quality. =A0It wants to request better qualit=
y,
>> so it needs a way to request it.
>>
>> The proposed "tickle" approach proposed here is simply a "request max
>> frequency for duration X" QoS request.
>>
>> Kevin
>>
>
> Ok.. I see.
>
> Now, I can agree with you that tickle is subset of QoS request.
>
> As long as we have QoS request feature on devices with either OPP or
> DEVFREQ, tickling is not needed.
>
> I'll remove tickle in the next revision (along with some bugfixes for
> bugs found recently).
>
>
> Anyway, it appears that clock-rate-wise QoS request may be dealt at
> OPP so that the OPPs meeting the QoS requests w/ frequency or voltage
> specifications are enabled and returned with opp_find_* functions.
> Maybe we will need to separate enable/disable by
> opp_enable()/opp_disable() from enable/disable by QoS requests so that
> the two may have different semantics. Then, QoS requests cannot
> override opp_disable and opp_enable cannot override QoS requests. This
> way, any clock-setting code properly based on OPP (including any
> customized devfreq governors) cannot violate QoS requests.

If devfreq used the QoS API in it's ->target() call then this would
not be an issue, and further illustrates the idea of devfreq simply
being a policy into a proper QoS API.

Regards,
Mike

> How about this concept of getting QoS requests associated with clock rate=
s?
>
>
>
> Cheers!
> MyungJoo.
> --
> MyungJoo Ham, Ph.D.
> Mobile Software Platform Lab,
> Digital Media and Communications (DMC) Business
> Samsung Electronics
> cell: 82-10-6714-2858
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
