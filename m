From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v4 0/3] DEVFREQ,
	DVFS framework for non-CPU devices
Date: Tue, 2 Aug 2011 16:17:20 +0900
Message-ID: <CAJ0PZbQnENwXevKzcW2J83gM0dVGNk8uA=ykV7ftW-vGFZkksQ@mail.gmail.com>
References: <1310717510-19002-1-git-send-email-myungjoo.ham@samsung.com>
	<201107290010.53788.rjw@sisk.pl>
	<CAJOA=zNpmQpCyh0ow2q6gUTxkLMcWDsoMOaQEGzV4Sw__BszHg@mail.gmail.com>
	<201107291110.41801.rjw@sisk.pl>
	<CAJOA=zPL_DUBb2miytFH6s3AKqroGDBsOPts=SdCb3p0c=cP=A@mail.gmail.com>
	<CAJ0PZbT0+ovjPAnVKaaJNVChG+kU3cgjC9sEU4ppnMGqGL+UoA@mail.gmail.com>
	<CAJOA=zPz6oqga=gM7bh7762Vr=43VjweDy30KUb4EcgaWZavNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJOA=zPz6oqga=gM7bh7762Vr=43VjweDy30KUb4EcgaWZavNg@mail.gmail.com>
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

On Tue, Aug 2, 2011 at 7:01 AM, Turquette, Mike <mturquette@ti.com> wrote:
>
> Maybe I'm not understanding how the devfreq requests would be made
> from drivers. =A0Can you explain an example where a single target device
> named X has constraints placed on it's clock rate from two different
> drivers Y & Z? =A0Imagine in this case that there are no performance
> counters or any way in hardware to monitor device saturation.

Ok, what you want to see is the case where X has a clock with OPP and
DEVFREQ and Y and Z are going to give constraints on that X's clock,
right?

In such a case, DEVFREQ has nothing to interfere directly with the
relation between X <--> Y/Z.

Y and Z can give constraints on X's clock with OPP interface (
opp_enable(dev, freq) and opp_disable(dev, freq) ) without the need
for DEVFREQ-aware.

DEVFREQ chooses frequencies from enabled OPPs regardless of the governor ch=
osen.

However, if your concern is about the inconsistency between Y and Z
caused by calling opp_enable to "cancel" opp_disable, DEVFREQ provides
no protection against it and writers of Y/Z will need to do some
bothersome work unless QoS request feature (or generalized tickle) is
added to DEVFREQ. Anyway, (as will be discussed below) I guess the QoS
request feature might wait for next version of DEVFREQ.

>
>>> Some examples include a MMC controller, which might change its clock
>>> rate depending on the class of card that the user has inserted. =A0Or
>>> even a "smartish" device like a GPU lacking performance counters; it's
>>> driver will ramp up frequency when there is work to be done and kick
>>> off a timeout. =A0If no new work comes in before the timeout then the
>>> driver will drop the frequency.
>>
>> In the "simple MMC controller w/o performance counter" case, there are
>> following ways to use devfreq even if using the number of requests or
>> functions calls is not possible.
>>
>> Method 1) use "userspace" governor and let user process choose
>> frequency based on the class
>
> I'm less interested in userspace control of MMC controller operating
> frequency and much more interested in how devfreq might arbitrate QoS
> requests from multiple "client" devices.
>
>> Method 2) use any "reasonable" governor and let the device driver set
>> only "valid" frequencies enabled.
>
> Can you elaborate on this? =A0I'm not sure I understand how this will
> look in driver code. =A0Maybe the example I requested above will shed
> some light.

If you are concerned about the consistency (between Y and Z's
enable/disable calls) problem in the previous X/Y/Z example, it'd be
addressed with "generalized tickle" or "QoS requests" unless those Y
and Z are aware of each other. I'd say such a feature is for the
"next" version of DEVFREQ as it is not going to affect the framework
itself significantly.

Anyway, the interface I'm thinking about are:
Method1:
   id =3D devfreq_qos_request(dev, freq); /* sets dev's frequency at
freq or higher */
   devfreq_qos_release(dev, id);
OR
   devfreq_qos_request(this_dev, target_dev, freq); /* this_dev sets
target_dev's frequency at freq or higher */
   devfreq_qos_release(this_dev, target_dev);

Method1 would be suitable for usual qos requests from related devices.
If there are multiple qos requests active, the highest requested freq
is used.
Internally, devfreq will manage a sorted (descending with freq) list
of "this_dev" or "id" per target_dev and enforce the target-freq to be
>=3D the highest freq in the list.

Method2:
   devfreq_tickle(dev, rate, duration); /* sets dev's frequency at its
maximum frequency * rate / 100 for duration in ms */

Method2 would be suitable for reacting to inputs (e,g, a user hitting
a key, clicking a mouse, touching a screen, ...).



>
>> =A0 For a rough example, we may do if class < 6, disable freq > 40MHz,
>> class < 10, disable freq > 80MHz, and so on. If we do not have
>> performance counters or any other mechanisms to monitor the
>> activities, "performance" governor along with clock-gated MMC driver
>> will save enough power.
>>
>> For GPUs without anything to monitor the activities, we may do the
>> same as the MMC case.
>>
>> However, with the H/W I've got now, (Exynos4210), we have performance
>> counters (PPMU) for many blocks: 3D(MALI GPU), ACP, CAMIF, CPU, DMC0,
>> DMC1 (memory controllers), FSYS, IMAGE, LCD0, LCD1, MFC_L, MFC_R, TV,
>> LEFT_BUS, and RIGHT_BUS. I don't think Exynos4 is an exceptionally
>> fancy SoC (already millions are sold for phones) and other mobile SoCs
>> (at least for flagship models) will have them very soon (or already
>> have them). Along with this patch, in the example with git branch
>> link, we control DMC0/DMC1 blocks. And,
>
> I agree devfreq is well-suited for such hardware.
>
>>> A governor is not required in these cases (as they are event driven)
>>> and devfreq is quite heavyweight for such applications. =A0What is
>>> needed is a QoS-style software layer that allows throughput requests
>>> to be made from an initiator device towards a target device. =A0This
>>> layer should aggregate requests since many initator devices may make
>>> requests to the same target device. =A0This layer I'm describing, which
>>> does not exist today, should be where the actual DVFS transition takes
>>> place. =A0That could take the form of a clk_set_rate call in the clock
>>> framework (as described by Colin in V1 of this series), or some other
>>> not-yet-realized dvfs_set_opp ,or something like Jean Pihet's
>>> per-device PM QoS patches or whatever. =A0For the purposes of this email
>>> I don't really care which framework implements the QoS request
>>> aggregation.
>>
>> Such aggregation could be also done with governors. If the
>> governor-device pair does not want to poll devfreq wouldn't loop
>> unless there is any governor-device pair that wants to do so. If it is
>> event-driven, users may just "allow/disallow" frequencies with OPP
>> framework and devfreq will choose proper frequency with the given
>> governor for the device. If every device uses "static" or
>> "event-driven" governors such as powersave/performance/userspace,
>> there will be no polling/looping.
>
> So drivers must disable OPPs, and then the non-polling devfreq
> governor will have to be notified by the OPP code and then run it's
> ->target code again? =A0This sounds backwards to me.

DEVFREQ (not its governors. governors only "recommend" proper
frequency to DEVFREQ framework when requested by DEVFREQ.) is already
being notified by any OPP changes (add/disable/enable) so that DEVFREQ
wouldn't choose disabled frequencies. That way, disabling and enabling
frequencies at OPP takes effects immediately with DEVFREQ.

More semantically sound approach may be to let OPP have a notifier
(per device) so that the changes in the opp availability go to the
"OPP consumers". However, at least for now, DEVFREQ is the only one
that needs such notification. Therefore, using such a notifier per
device only for DEVFREQ (moreover, not all of OPP'ed devices are using
DEVFREQ) could incur too much overhead as notifier is heavier than a
simple function call.

>
> devfreq seems like an ideal bit of code to understand the constraints
> needed by a device (via the workqueue/monitor loop) and then request
> those needs via the proper API. =A0It seems entirely wrong to me to have
> other device drivers send their QoS needs to devfreq.

Tickle is an approach for temporal QoS requests. And, I understand
that there are needs for non-tempoeral QoS requests. However, I guess
it might be ok to let QoS requests be "next TODO" subjects for
DEVFREQ. Besides, some engineers have already requested QoS request
feature for DEVFREQ in my side as well. :)

>
> I'm starting to sound like a broken record though, and I've rescinded
> my NAK in my reply to Rafael. =A0If you could explain how multiple
> drivers can request their performance needs to a devfreq governor
> (same question I asked above) then that would be really helpful.

Without QoS request feature (the Method1 up there), using
opp_enable/disable is the only feasible way unless tickle fits for the
need. (managing "canceling disable" could be bothersome without the
Method1 anyway...)

>
> Thanks,
> Mike
>
-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
