From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC] [PATCH 0/3] IRQ affinity notifier and per-cpu PM QoS
Date: Fri, 25 Jul 2014 10:55:31 -0600
Message-ID: <1406307334-8288-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56145 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbaGYQzq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 12:55:46 -0400
Received: by mail-ie0-f181.google.com with SMTP id rp18so3826601iec.26
        for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2014 09:55:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: daniel.lezcano@linaro.org, linus.walleij@linaro.org, arnd.bergmann@linaro.org, rjw@rjwysocki.net, tglx@linutronix.de, Lina Iyer <lina.iyer@linaro.org>

This series of patches adds a new feature to allow per-cpu PM QoS.

The first of the patch, modifies the irq manager to allow multiple clients for
IRQ SMP affinity change notification. Today, only one client can register a
notification per IRQ. The PM QoS framework is also now interested in knowing
when the SMP affinity changes for an IRQ. With the current implementation, a
second registration on the change notification releases the current
notification callbacks and registers the new one. Modify the notification
mechanism to use a list for notification instead of single data structure.
Also, a client that wants to de-register from the notification will now need to
call a separate API instead of the overloaded function call with a NULL
argument.

The next two patches re-organize PM QoS framework to allow QoS and the Dev PM
QoS frameworks to specify a request type. Most requestors of PM QoS do not know
or care about the CPU(s) the QoS needs to be effected. In many cases, it is
still desirable to have the QoS apply on all available cpus. However, in
conjunction with an IRQ balancer or a driver that has specific cpu(s)
requirement for its use, can specify a QoS request only for that set of cpus.
For example in a case, where a certain IRQ might need a performance QoS, but
does not want to affect the general power consumption of all the cpus in the
system, can specify an QoS request thats affine only to that cpu(s), where the
IRQ can be triggered.

The change adds ability to specify the PM QoS request types and two new PM QoS
request types in addition to the default that applies to all cpus.

PM_QOS_REQ_AFFINE_CORES: This allows drivers to specify a certain set of cpus
that the request should be applied on.

PM_QOS_REQ_AFFINE_IRQ: This allows drivers to specify an IRQ to which the QoS
request can be tracked with. This uses the IRQ SMP affinity notification to set
the cpumask of the affected cpus internally.

The request defaults to PM_QOS_REQ_ALL_CORES when not explicitly specified and
applies the request to all cpus.

There is also a provision to read the QoS request value for a constraint, for a
constraint for a set of cpus or just a cpu. CPUIdle governors can use this
feature to get a QoS request for the cpu(s) they are interested in.



Lina Iyer (3):
  irq: Allow multiple clients to register for irq affinity notification
  QoS: Modify data structures and function arguments for scalability.
  QoS: Enhance framework to support cpu/irq specific QoS requests

 Documentation/power/pm_qos_interface.txt |  18 +++
 drivers/base/power/qos.c                 |  14 +--
 drivers/infiniband/hw/qib/qib_iba7322.c  |   4 +-
 include/linux/interrupt.h                |  12 +-
 include/linux/irq.h                      |   1 +
 include/linux/irqdesc.h                  |   6 +-
 include/linux/pm_qos.h                   |  23 +++-
 kernel/irq/irqdesc.c                     |   1 +
 kernel/irq/manage.c                      |  77 ++++++++-----
 kernel/power/qos.c                       | 184 ++++++++++++++++++++++++++++++-
 lib/cpu_rmap.c                           |   2 +-
 11 files changed, 289 insertions(+), 53 deletions(-)

-- 
1.9.1

