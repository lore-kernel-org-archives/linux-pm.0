From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Fri, 5 Aug 2011 15:18:42 +0900
Message-ID: <CAJ0PZbQx-T+36eX7MiZqWSMxD-achZ9Z7G_kDWNQ2n0h1NTWSQ@mail.gmail.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl> <87livba2w6.fsf@ti.com>
	<CAJ0PZbTMn_pzFBWbhtMrMo9ZGsnwMNKENgMSDa=oOZCrGh03Gg@mail.gmail.com>
	<87aabq5oqo.fsf@ti.com>
	<CAJ0PZbQQkAPHNwzh0tL9BiNAjjMtUOCoKV1JDzUqj0utx8COgg@mail.gmail.com>
	<CAJOA=zMNToQq=RVrRh2p+kko=n67BWwHjcWX3DGFuYCfAcksOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJOA=zMNToQq=RVrRh2p+kko=n67BWwHjcWX3DGFuYCfAcksOQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Turquette, Mike" <mturquette@ti.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 5, 2011 at 6:59 AM, Turquette, Mike <mturquette@ti.com> wrote:
> On Thu, Aug 4, 2011 at 1:15 AM, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
>>
>> Ok.. I see.
>>
>> Now, I can agree with you that tickle is subset of QoS request.
>>
>> As long as we have QoS request feature on devices with either OPP or
>> DEVFREQ, tickling is not needed.
>>
>> I'll remove tickle in the next revision (along with some bugfixes for
>> bugs found recently).
>>
>>
>> Anyway, it appears that clock-rate-wise QoS request may be dealt at
>> OPP so that the OPPs meeting the QoS requests w/ frequency or voltage
>> specifications are enabled and returned with opp_find_* functions.
>> Maybe we will need to separate enable/disable by
>> opp_enable()/opp_disable() from enable/disable by QoS requests so that
>> the two may have different semantics. Then, QoS requests cannot
>> override opp_disable and opp_enable cannot override QoS requests. This
>> way, any clock-setting code properly based on OPP (including any
>> customized devfreq governors) cannot violate QoS requests.
>
> If devfreq used the QoS API in it's ->target() call then this would
> not be an issue, and further illustrates the idea of devfreq simply
> being a policy into a proper QoS API.
>
> Regards,
> Mike
>

Yes, if we choose an OPP that meets the PM-QoS requests before calling
->target() in devfreq_do(), there wouldn't be an issue.

However, if a device is using DEVFREQ, it also means the device has
OPPs (mandatory for DEVFREQ). If the device is using PM QoS as well as
OPP, I guess the correctly implemented device driver needs to call
opp_enable() and opp_disable() according to PM QoS's update_target()
calls through the PM QoS notifier cb.

Then, for such drivers, DEVFREQ automatically meets PM QoS requests
without any modification; as long as QoS meeting OPPs are enabled at
the device driver's PM QoS callback, there is no QoS issue.

Therefore, now, it appears that neither OPP or DEVFREQ should be
allowed to directly touch PM QoS APIs, but, the device driver should
do so with notifier by simply calling opp-enable/disable if the
frequency is the key QoS "actuator".

If we are going to let DEVFREQ handle its corresponding devices' PM
QoS APIs, it would mean that both device driver and its DEVFREQ codes
will be handling PM QoS API duplicated (or worse, inconsistently).



Cheers,
MyungJoo

>> How about this concept of getting QoS requests associated with clock rates?
>>
>>
>>
>> Cheers!
>> MyungJoo.
>> --
>> MyungJoo Ham, Ph.D.
>> Mobile Software Platform Lab,
>> Digital Media and Communications (DMC) Business
>> Samsung Electronics
>> cell: 82-10-6714-2858
>> _______________________________________________
>> linux-pm mailing list
>> linux-pm@lists.linux-foundation.org
>> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>>
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
