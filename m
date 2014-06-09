From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 7/7] cpufreq: intel_pstate: Make intel_pstate_kobject
 local
Date: Tue, 10 Jun 2014 00:24:25 +0300
Message-ID: <53962609.6080102@semaphore.gr>
References: <53962096.1060202@semaphore.gr> <alpine.DEB.2.02.1406091405540.30620@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:55456 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754500AbaFIVYa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 17:24:30 -0400
In-Reply-To: <alpine.DEB.2.02.1406091405540.30620@chino.kir.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Rientjes <rientjes@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 10/06/2014 12:07 =CF=80=CE=BC, David Rientjes wrote:
> On Tue, 10 Jun 2014, Stratos Karafotis wrote:
>=20
>> Since we never remove sysfs entry, we can make the intel_pstate_kobj=
ect
>> local.
>>
>=20
> For even more savings, this function and=20
> intel_pstate_debug_expose_params() can be annotated with __init and f=
reed=20
> after bootstrap.

Thanks for your comment, David!
I will do this in v2.


Stratos

