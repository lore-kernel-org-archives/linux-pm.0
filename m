From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: intel_pstate: Change the calculation of next
 pstate
Date: Tue, 29 Apr 2014 19:34:46 +0300
Message-ID: <535FD4A6.3050905@semaphore.gr>
References: <535D80C8.9090906@semaphore.gr> <CAKohpomhUk7RQ3YL3=wpVKSbK_oSkyYBRUZiqnHzWqrZ2DjRRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomhUk7RQ3YL3=wpVKSbK_oSkyYBRUZiqnHzWqrZ2DjRRA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29/04/2014 07:58 =CF=80=CE=BC, Viresh Kumar wrote:
> Cc'd Dirk,
>=20
> On 28 April 2014 03:42, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>> Currently the driver calculates the next pstate proportional to
>> core_busy factor and reverse proportional to current pstate.
>>
>> Change the above method and calculate the next pstate independently
>> of current pstate.
>=20
> We must mention why the change is required.
>=20

Hi Viresh,

Actually, I can't say that it's required. :)
I just believe that calculation of next p-state should be independent
from current one. In my opinion we can't scale the load across differen=
t
p-states, because it's not always equivalent.

=46or example suppose a load of 100% because of a tight for loop in the
current p-state. It will be also a 100% load in any other p-state.
It will be wrong if we scale the load in the calculation formula
according to the current p-state.

I included the test results in the change log to point out an improveme=
nt
because of this patch.

I will enrich more the change log as you suggested.

Thanks,
Stratos Karafotis

