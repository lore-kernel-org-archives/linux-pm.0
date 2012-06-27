From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH -v4 6/6] fault-injection: add notifier error
 injection testing scripts
Date: Wed, 27 Jun 2012 20:42:51 +0900
Message-ID: <CAC5umygD5b3w1Fc6h5__cH-G6zrALZ4Ucvn-vazn+8yLXDw0JQ@mail.gmail.com>
References: <1340463502-15341-1-git-send-email-akinobu.mita@gmail.com>
	<1340463502-15341-7-git-send-email-akinobu.mita@gmail.com>
	<20120626163147.93181e21.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120626163147.93181e21.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>, linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

2012/6/27 Andrew Morton <akpm@linux-foundation.org>:
> On Sat, 23 Jun 2012 23:58:22 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
>> This adds two testing scripts with notifier error injection
>
> Can we move these into tools/testing/selftests/, so that a "make
> run_tests" runs these tests?
>
> Also, I don't think it's appropriate that "fault-injection" be in the
> path - that's an implementation detail. =A0What we're testing here is
> memory hotplug, pm, cpu hotplug, etc. =A0So each test would go into, say,
> tools/testing/selftests/cpu-hotplug.
>
> Now, your cpu-hotplug test only tests a tiny part of the cpu-hotplug
> code. =A0But it is a start, and creates the place where additional tests
> will be placed in the future.
>
>
> If the kernel configuration means that the tests cannot be run, the
> attempt should succeed so that other tests are not disrupted. =A0I guess
> that printing a warning in this case is useful.
>
> Probably the selftests will require root permissions - we haven't
> really thought about that much. =A0If these tests require root (I assume
> they do?) then a sensible approach would be to check for that and to
> emit a warning and return "success".

Thanks for your advice.

I'm going to make the following changes on these scripts

1. Change these paths to:
tools/testing/selftests/{cpu,memory}-hotplug/on-off-test.sh

2. Skip tests and exit(0) with a warning if no root or no sysfs
so that a "make run_tests" doesn't stop.

3. Add tests that simply online and offline cpus (or memory blocks)
and then tests with this notifier error injection features if the
kernel supports.

> My overall take on the fault-injection code is that there has been a
> disappointing amount of uptake: I don't see many developers using them
> for whitebox testing their stuff. =A0I guess this patchset addresses
> that, in a way.

I hope so. the impact of notifier error injection is restricted to
the particular kernel functionarity and these scripts are easy to run.

On the other hand, fault injection like failslab has a huge impact
on any kernel components and it often results catastrophe to userspace
even if no kernel bug.  I am confident that I can find a certain amount
of kernel bugs with failslab but it requires enough spare time.
