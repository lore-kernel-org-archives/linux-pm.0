From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Wed, 08 Oct 2014 00:36:59 +0300
Message-ID: <54345CFB.7070101@semaphore.gr>
References: <20141007114844.GT4609@sirena.org.uk> <20141007164643.GA3748@kroah.com> <20141007170800.GL4609@sirena.org.uk> <20141007200458.GA12028@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:45255 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753306AbaJGVmu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Oct 2014 17:42:50 -0400
In-Reply-To: <20141007200458.GA12028@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

On 07/10/2014 11:04 =CE=BC=CE=BC, Greg Kroah-Hartman wrote:
> On Tue, Oct 07, 2014 at 06:08:00PM +0100, Mark Brown wrote:
>> On Tue, Oct 07, 2014 at 09:46:43AM -0700, Greg Kroah-Hartman wrote:
>>> On Tue, Oct 07, 2014 at 12:48:44PM +0100, Mark Brown wrote:
>>
>>>> The power management team at Linaro has had a look at the cpufreq
>>>> updates since the v3.10 LTS and identified a few patches that look
>>>> like they should be in there.  The most recent of these is from v3=
=2E12 so
>>>> they won't apply to any of the more recent stable kernels.
>>
>>>>  - 59a6342203a7a cpufreq: Fix governor start/stop race condition
>>
>>>>    This looks like a straight race condition fix.
>>
>>> That is not a commit id in Linus's tree :(
>>
>> Interesting, I was able to cherry-pick it...  looks like the upstrea=
m
>> version is 95731eb.  In any case at roughly the same time you sent y=
our
>> mail it's been drawn to my attention off-list that this was subseque=
ntly
>> reverted so please ignore this one.  The others should be fine thoug=
h.
>=20
> Ok, I've queued the others up now.
>=20

=46or your information, commits:

- 61c63e5ed3b9 cpufreq: Remove unused APERF/MPERF support
- cffe4e0e7413 cpufreq: Remove unused function __cpufreq_driver_getavg(=
)

remove unused code (no other functional changes) as a result of
commit dfa5bb622555. They all were part of the same patch set.

I'm not familiar with the procedure of patch inclusion in stable trees,
so please forgive me if this mail is just noise.


Thanks,
Stratos

