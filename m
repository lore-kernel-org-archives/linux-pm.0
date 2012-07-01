From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] acpi: intel_idle : break dependency
	between modules
Date: Sun, 01 Jul 2012 21:36:37 +0200
Message-ID: <4FF0A6C5.5080509@linaro.org>
References: <201206271506.29034.trenn@suse.de>
	<201206282124.09857.rjw@sisk.pl> <4FED69BE.20707@linaro.org>
	<201206300027.05175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201206300027.05175.rjw@sisk.pl>
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
Cc: linaro-dev@lists.linaro.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 06/30/2012 12:27 AM, Rafael J. Wysocki wrote:
> On Friday, June 29, 2012, Daniel Lezcano wrote:
>> On 06/28/2012 09:24 PM, Rafael J. Wysocki wrote:
>>> On Thursday, June 28, 2012, Daniel Lezcano wrote:
>>>> When the system is booted with some cpus offline, the idle
>>>> driver is not initialized. When a cpu is set online, the
>>>> acpi code call the intel idle init function. Unfortunately
>>>> this code introduce a dependency between intel_idle and acpi.
>>>>
>>>> This patch is intended to remove this dependency by using the
>>>> notifier of intel_idle. This patch has the benefit of
>>>> encapsulating the intel_idle driver and remove some exported
>>>> functions.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> This one looks good to me too.
>>>
>>> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>>
>> Thanks for the review Rafael.
>>
>>> Len, are you going to take it?
>>
>> Rafael, Len,
>>
>> After the discussion [1], I put in place a tree at:
>>
>> ssh://git.linaro.org/srv/git.linaro.org/git/people/dlezcano/cpuidle-ne=
xt.git
>> #cpuidle-next
>>
>> I proposed this tree to group the cpuidle modifications and prevent th=
e
>> last minutes conflict when Len will apply them.
>>
>> I also included the tree into linux-next for wider testing.
>=20
> I can't speak for Len, but I'm not sure he'll like this.

I sent the proposition a week ago and Len was Cc'ed. I guess he is very
busy but the problem we are facing is there are a lot of pending
modifications for cpuidle because of some new architecture (like the
big.LITTLE and tegra3). Colin's patchset is one of them.

> Anyway, you seem to have the same material as Len in that tree, won't t=
here
> be any conflicts in linux-next?

At the first glance no, until he merge the patches we sent. As I already
said the purpose is to help to consolidate the patches sent for cpuidle
by acting as a proxy.

I hope that helps.

Thanks
  -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
