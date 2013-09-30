From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 19/21] cpuidle: create list of registered drivers
Date: Mon, 30 Sep 2013 20:37:47 +0200
Message-ID: <5249C4FB.1060705@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org> <5243641B.6050604@linaro.org> <CAKohpo=3qFQ+gD+3u__NtZEL4xu51FBN+og+_UE7aTR26XvRng@mail.gmail.com> <5243EE02.9020207@linaro.org> <20130928213343.GA19582@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130928213343.GA19582@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/28/2013 11:33 PM, Paul E. McKenney wrote:
> On Thu, Sep 26, 2013 at 10:19:14AM +0200, Daniel Lezcano wrote:
>> On 09/26/2013 08:17 AM, Viresh Kumar wrote:
>>> On 26 September 2013 04:00, Daniel Lezcano <daniel.lezcano@linaro.o=
rg> wrote:
>>>> If you introduce a list, you will have to introduce a lock to prot=
ect
>>>> it.
>>>
>>> I missed it, should have added that :)
>>>
>>>> This lock will be in the fast path cpuidle_idle_call with the
>>>> get_driver function and conforming to the comment: "NOTE: no locks=
 or
>>>> semaphores should be used here".
>>>>
>>>> A lock has been introduced in this function already and the system=
 hangs
>>>> with 1024 cpus.
>>>
>>> Hmm... I see.. I didn't knew about this expectation.. What about a =
rcu
>>> read/write lock? As far as I know its too lightweight... Can we hav=
e that
>>> in fast path?
>>
>> Nope, we can't use rcu in the idle path :)
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/=
083054.html
>
> But you should be able to use SRCU in the idle path, if that helps.

Interesting, thanks for the pointer.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
