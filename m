From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [11/11] system 1: Saving energy using DVFS
Date: Fri, 20 Dec 2013 16:45:51 +0000
Message-ID: <1387557951-21750-12-git-send-email-morten.rasmussen@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59554 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab3LTQpk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 11:45:40 -0500
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org

Most modern systems use DVFS to save power by slowing down computation
throughput when less performance is necessary. The power/performance
relation is platform specific. Some platforms may have better energy
savings (energy per instruction) than others at low frequencies.

To have something to relate to, here is an anonymized example based on
a modern ARM platform:

Performance=09Energy/instruction
1.0=09=091.0
1.3=09=091.6
1.7=09=091.8
2.0=09=091.9
2.3=09=092.1
2.7=09=092.4
3.0=09=092.7

Performance is frequency (~instruction issue rate) and
energy/instruction is the energy cost of executing one (or a fixed
number of instructions) at that level of performance (frequency). For
this example, it costs 2.7x more energy per instruction to increase the
performance from 1.0 to 3.0 (3x). That is, the amount of work
(instructions) that can be done on one battery charge is reduced by 2.7x
(~63%) if you run as fast as possible (3.0) compared to running at
slowest frequency (1.0).

A lot of things haven't been accounted for in this simplified example.
There is a number of factors that influence the energy efficiency
including whether the cpu is the only one awake in its frequency/power
domain or not. The numbers shown above won't be accurate for all
workloads. They are meant as a ballpark figures.

To save energy, the higher frequencies should be avoided and only used
when the application performance requirements can not be satisfied
otherwise (e.g. spread tasks across more cpus if possible).

When considering the total system power it may save energy in some
scenarios by running the cpu faster to allow other power hungry parts of
the system to be shut down faster. However, this is highly platform and
application dependent.

