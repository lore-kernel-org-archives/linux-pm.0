From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v2 00/11] PM QoS: add a per-device wake-up
 latency constraint class
Date: Wed, 20 Jul 2011 11:26:13 +0200
Message-ID: <CAORVsuVt1cg04T7wKKTeaGHEDs-OEejs7+cuDXpVcCUv7r4_FQ__35520.2692597688$1311154114$gmane$org@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<201107022120.47221.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107022120.47221.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> This patch set is in an RFC state, for review and comments.
>
> First off, I'm sorry I couldn't review the patchset earlier.
Thank you very much for reviewing the patches!

>
>> In order to implement the new class in PM QoS the following changes have=
 been
>> made:
>>
>> 1. Add a new PM QoS class for device wake-up constraints
>> (PM_QOS_DEV_WAKEUP_LATENCY).
>> Due to the per-device nature of the new class the constraints lists are =
stored
>> inside the device dev_pm_info struct instead of the internal per-class
>> constraints lists.
>> The new class is only available from kernel drivers and so is not export=
ed to
>> user space.
>
> Have you considered a design in which multiple devices may use the same
> list of constraints? =A0It seems plausible that the constraints will be t=
he
> same, for example, for all Ethernet adapters in the system, in which case=
 it
> will be wasteful to duplicate the list of constraints for each of them.
How would the devices be grouped together? Today it looks like the
network throughput constraints from the device drivers are not used at
all but rather use the CPU_DMA latency API.

>
>> 2. Added a notification of device insertion/removal from the device PM f=
ramework
>> to PM QoS.
>> This allows to init/de-init the per-device constraints list upon device =
insertion
>> and removal.
>> RFC state for comments and review, barely tested
>
> I need to have a look at the details, but in principle this means that the
> per-device lists will be usable only after the devices have been register=
ed.
> In particular, this means that it will only be possible to add new constr=
aints
> after registering the device, which may be too late for some use cases.
Hmm I wonder how to solve this issue. How to manage constraints for a
non-present (not yet present or already removed) device? The CPU_DMA
latency constraint API might be used in those cases.

>
>> 3. Make the pm_qos_add_request API more generic by using a
>> struct pm_qos_parameters parameter. This allows easy extension in the fu=
ture.
>>
>> 4. Upon a change of the strongest constraint in the PM_QOS_DEV_WAKEUP_LA=
TENCY
>> class a notification chain mechanism is used to take action on the syste=
m.
>> This is the proposed way to have PM QoS and the platform dependant code =
to
>> interact with each other, cf. 4 below.
>
> I guess you mean 5.?
Yes

>
> I think we will need something in addition to the notifier here. =A0For e=
xample,
> I wouldn't like any core code, like runtime PM or cpuidle, to have to reg=
ister
> a notifier with PM QoS.
I am not following this. Can you elaborate a bit?

>
>> The notification mechanism now passes the constraint request struct ptr =
in
>> order for the notifier callback to have access to the full set of constr=
aint
>> data, e.g. the struct device ptr.
>>
>> 5. cpuidle interaction with the OMAP3 cpuidle handler
>> Since cpuidle is a CPU centric framework it decides the MPU next power s=
tate
>> based on the MPU exit_latency and target_residency figures.
>>
>> The rest of the power domains get their next power state programmed from
>> the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework, via the dev=
ice
>> wake-up latency constraints.
>>
>> Note: the exit_latency and target_residency figures of the MPU include t=
he MPU
>> itself and the peripherals needed for the MPU to execute instructions (e=
.g.
>> main memory, caches, IRQ controller, MMU etc).
>> Some of those peripherals can belong to other power domains than the MPU
>> subsystem and so the corresponding latencies must be included in those f=
igures.
>>
>> 6. Update the pm_qos_add_request callers to the generic API
>>
>> 7. Minor clean-ups and rename of struct fields
>>
>> Questions:
>> 1. How to retrieve the device ptr from a given device driver in order to=
 add
>> a constraint on it?
>> 2. The device struct has recently been extended with the power domain
>> information. Can this be used to apply the constraints on power domains?
>
> Yes, it can in principle, but that will require some work.
>
>> On-going developments, patches in preparation:
>> 1. write Documentation for the new PM QoS class
>
> I'd wait with that until the code has settled.
Ok that was the intention to write the doc once for good.

>
>> 2. validate the constraints framework on OMAP4 HW (done on OMAP3)
>> 3. refine the power domains wake-up latency and the cpuidle figures
>>
>> Based on the master branch of the linux-omap git tree (3.0.0-rc3). Compi=
le
>> tested using OMAP and x86 generic defconfigs.
>> Tested on OMAP3 Beagleboard (ES2.x) with full RETention and OFF modes.
>
> More detailed comments will follow.
>
> Thanks,
> Rafael
>

Thanks a lot,
Jean
