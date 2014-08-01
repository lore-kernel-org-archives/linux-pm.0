From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC] [PATCH 0/3] IRQ affinity notifier and per-cpu PM QoS
Date: Fri, 01 Aug 2014 13:54:26 +0200
Message-ID: <53DB7FF2.3040203@linaro.org>
References: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45100 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaHALya (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 07:54:30 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so4243905wes.33
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 04:54:27 -0700 (PDT)
In-Reply-To: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, linux-pm@vger.kernel.org
Cc: linus.walleij@linaro.org, arnd.bergmann@linaro.org, rjw@rjwysocki.net, tglx@linutronix.de

On 07/25/2014 06:55 PM, Lina Iyer wrote:
> This series of patches adds a new feature to allow per-cpu PM QoS.

Hi Lina,

this description lacks in the reason of why allowing per cpu PM QoS is=20
needed. Could you give the context of the proposed feature ?

> The first of the patch, modifies the irq manager to allow multiple cl=
ients for
> IRQ SMP affinity change notification. Today, only one client can regi=
ster a
> notification per IRQ. The PM QoS framework is also now interested in =
knowing
> when the SMP affinity changes for an IRQ.

Why ?

> With the current implementation, a
> second registration on the change notification releases the current
> notification callbacks and registers the new one. Modify the notifica=
tion
> mechanism to use a list for notification instead of single data struc=
ture.

May be this is not necessary if the notification is always needed. Even=
=20
if that breaks the code encapsulation, invoking directly a pm_qos=20
function when the irq is changed, in addition of the notification,=20
should suffice instead of adding a list of notifications with all the=20
races that implies.

> Also, a client that wants to de-register from the notification will n=
ow need to
> call a separate API instead of the overloaded function call with a NU=
LL
> argument.
>
> The next two patches re-organize PM QoS framework to allow QoS and th=
e Dev PM
> QoS frameworks to specify a request type. Most requestors of PM QoS d=
o not know
> or care about the CPU(s) the QoS needs to be effected. In many cases,=
 it is
> still desirable to have the QoS apply on all available cpus. However,=
 in
> conjunction with an IRQ balancer or a driver that has specific cpu(s)
> requirement for its use, can specify a QoS request only for that set =
of cpus.
> For example in a case, where a certain IRQ might need a performance Q=
oS, but
> does not want to affect the general power consumption of all the cpus=
 in the
> system, can specify an QoS request thats affine only to that cpu(s), =
where the
> IRQ can be triggered.
>
> The change adds ability to specify the PM QoS request types and two n=
ew PM QoS
> request types in addition to the default that applies to all cpus.
>
> PM_QOS_REQ_AFFINE_CORES: This allows drivers to specify a certain set=
 of cpus
> that the request should be applied on.
>
> PM_QOS_REQ_AFFINE_IRQ: This allows drivers to specify an IRQ to which=
 the QoS
> request can be tracked with. This uses the IRQ SMP affinity notificat=
ion to set
> the cpumask of the affected cpus internally.
>
> The request defaults to PM_QOS_REQ_ALL_CORES when not explicitly spec=
ified and
> applies the request to all cpus.
>
> There is also a provision to read the QoS request value for a constra=
int, for a
> constraint for a set of cpus or just a cpu. CPUIdle governors can use=
 this
> feature to get a QoS request for the cpu(s) they are interested in.

IMHO, it would be desirable first to implement a per cpu pm_qos without=
=20
adding any extra new request or features, so we can comment it focused=20
on how to do that.

> Lina Iyer (3):
>    irq: Allow multiple clients to register for irq affinity notificat=
ion
>    QoS: Modify data structures and function arguments for scalability=
=2E
>    QoS: Enhance framework to support cpu/irq specific QoS requests
>
>   Documentation/power/pm_qos_interface.txt |  18 +++
>   drivers/base/power/qos.c                 |  14 +--
>   drivers/infiniband/hw/qib/qib_iba7322.c  |   4 +-
>   include/linux/interrupt.h                |  12 +-
>   include/linux/irq.h                      |   1 +
>   include/linux/irqdesc.h                  |   6 +-
>   include/linux/pm_qos.h                   |  23 +++-
>   kernel/irq/irqdesc.c                     |   1 +
>   kernel/irq/manage.c                      |  77 ++++++++-----
>   kernel/power/qos.c                       | 184 ++++++++++++++++++++=
++++++++++-
>   lib/cpu_rmap.c                           |   2 +-
>   11 files changed, 289 insertions(+), 53 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

