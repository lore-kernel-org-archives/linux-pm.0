From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Date: Wed, 21 Feb 2018 14:25:10 +0100
Message-ID: <CAJZ5v0gVUO5OMfHUrQKd0T1EKo2c9iJ+zb-v9i2tkkS0MJbntA@mail.gmail.com>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7>
 <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
 <87vaeqqye8.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <87vaeqqye8.fsf@concordia.ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 21, 2018 at 2:13 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
>> On Wed, Feb 21, 2018 at 6:54 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> On 21-02-18, 16:39, Michael Ellerman wrote:
>>>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>>
>>>> > AFAICT, you will get -1 here only if the freq table had no valid
>>>> > frequencies (or the freq table is empty). Why would that happen ?
>>>>
>>>> Bugs?
>>>
>>> The cupfreq driver shouldn't have registered itself in that case (i.e.
>>> if the cpufreq table is empty).
>>
>> To be precise, ->init() should fail as that's where the table is
>> created.  The registration fails as a result then.
>>
>> But what if the bug is that ->init() doesn't fail when it should?
>>
>> I guess the core could double check the frequency table after ->init()
>> if ->target_index is not NULL.
>>
>> The overall point here is that if you get a negative index in
>> ->fast_switch(), that's way too late anyway and we should be able to
>> catch that error much earlier.
>
> OK.
>
> Still it's one thing for the driver to print a warning and bail out,
> it's another to access off the front of an array and keep running using
> some junk values, or oops (though not in this case because the array
> happens to be static).

Well, let me rephrase.  If ->fast_switch() runs, then it must not be
possible to get a negative index in it.  That has to be guaranteed by
the core.
