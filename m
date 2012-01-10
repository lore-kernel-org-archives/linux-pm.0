From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Tue, 10 Jan 2012 22:02:49 +0100
Message-ID: <CAORVsuUgL=5N1s7j3mHTzVgpq5sFO5nkotAZ1PeC=s0GfkWGwA@mail.gmail.com>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201092227.29857.rjw@sisk.pl>
	<20120110045042.GA14968@mgross-G62>
	<201201102146.23001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201201102146.23001.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Antti P Miettinen <amiettinen@nvidia.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

Hi Mark, Rafael,

On Tue, Jan 10, 2012 at 9:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, January 10, 2012, mark gross wrote:
>> On Mon, Jan 09, 2012 at 10:27:29PM +0100, Rafael J. Wysocki wrote:
>> > On Monday, January 09, 2012, mark gross wrote:
>> > > On Sun, Jan 08, 2012 at 11:59:24PM +0100, Rafael J. Wysocki wrote:
>> > > > On Friday, January 06, 2012, mark gross wrote:
>> > > > > On Fri, Jan 06, 2012 at 02:36:20AM +0200, Antti P Miettinen wrot=
e:
>> > > > > > The inspiration for this patch series is the N9 CPU frequency =
boost
>> > > > > > upon input events:
>> > > > > >
>> > > > > > http://www.spinics.net/lists/cpufreq/msg00667.html
>> > > > > >
>> > > > > > and the related changes in git://codeaurora.org/kernel/msm.git=
 tree.
>> > > > > > Those patches modify the ondemand cpufreq governor. This patch=
 series
>> > > > > > adds minimum and maximum CPU frequency as PM QoS parameters and
>> > > > > > modifies the cpufreq core to enforce the PM QoS limits. There =
is also
>> > > > > > an example module for boosting the frequency upon input events.
>> > > > > >
>> > > > > > I've been testing these changes against Ubuntu 3.2 kernel on a=
 Dell
>> > > > > > E6420 with the ACPI cpufreq driver. The patches are against
>> > > > > > linux-next/master, compile tested against it.
>> > > > > >
>> > > > > > =A0 =A0 --Antti
>> > > > > >
>> > > > > > Alex Frid (1):
>> > > > > > =A0 PM QoS: Simplify PM QoS expansion/merge
>> > > > > >
>> > > > > > Antti P Miettinen (5):
>> > > > > > =A0 PM QoS: Add CPU frequency min/max as PM QoS params
>> > > > > > =A0 cpufreq: Export user_policy min/max
>> > > > > > =A0 cpufreq: Preserve sysfs min/max request
>> > > > > > =A0 cpufreq: Enforce PM QoS min/max limits
>> > > > > > =A0 input: CPU frequency booster
>> > > > > >
>> > > > > > =A0drivers/cpufreq/cpufreq.c =A0 =A0 | =A0 57 +++++++++++++-
>> > > > > > =A0drivers/input/Kconfig =A0 =A0 =A0 =A0 | =A0 =A09 ++
>> > > > > > =A0drivers/input/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
>> > > > > > =A0drivers/input/input-cfboost.c | =A0174 ++++++++++++++++++++=
+++++++++++++++++++++
>> > > > > > =A0include/linux/pm_qos.h =A0 =A0 =A0 =A0| =A0 19 ++++-
>> > > > > > =A0kernel/power/qos.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 55 ++++++++=
++----
>> > > > > > =A06 files changed, 293 insertions(+), 22 deletions(-)
>> > > > > > =A0create mode 100644 drivers/input/input-cfboost.c
>> > > > > >
>> > > > >
>> > > > > The following is my version of part of this patch set I was tink=
ering
>> > > > > with. =A0Its missing the cpufreq notification this change has an=
d doesn't
>> > > > > do anything WRT cfboost.
>> > > > >
>> > > > > Would it be ok if we could consolidate our two implementations a=
nd
>> > > > > completely separate the cfboost stuff as a separate patch set?
>> > > > >
>> > > > > My code below is missing the cpufreq notification logic you have.
>> > > >
>> > > > Well, I have one substantial problem with this approach. =A0Namely=
, our
>> > > > current PM QoS infrastructure is not suitable for throughput const=
raints,
>> > > > because they should be additive, unlike the latency ones.
>> > > >
>> > > > Namely, if sombody requests throughput X and someone else Y, the r=
esulting
>> > > > combined throughput should be X+Y rather than max(X, Y).
>> > >
>> > > That can be done easy enough. =A0However; in practice I'm not convin=
ced
>> > > doing and additive aggregation of the requested QoS would be any bet=
ter
>> > > than just taking the max.
>> >
>> > Well, I'd say it's necessary for correctness, perhaps not for the CPU,=
 but in
>> > general. =A0If Y is the max, then the subsystem that requested X may e=
asily
>> > starve whoever requested the Y by using all of the bandwidth it asked =
for.
>>
>> I was thinking about this from the CPU point of view more over the day.
>> Given that there are many times more than one make the qos requests
>> additive will result in quickly requesting more cpu than is available
>> and waisting a lot of power. =A0 Also additive aggregation falls over a
>> bit on with multi-core.
>>
>> As the consumer of the cpu resources are tasks, and we can only run one
>> task at a time on a cpu, I'm talking myself into thinking that max
>> *is* the right way to go for cpu throughput (i.e. frequency).
There are case where the constraints values should be additive. The
best example is the main memory throughput and so the memory
controller frequency (or the L3 frequency on OMAP). The main problem
is to estimate the overhead of multiple simultaneous transfers.

What do you think?

>
> I agree, but I wonder what units of throughput should be used in that cas=
e?
>
> Rafael

Regards,
Jean

> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
