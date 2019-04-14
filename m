From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
Date: Mon, 15 Apr 2019 01:34:29 +0530
Message-ID: <32cdf163-32b7-1011-16aa-8b40332832db@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0h+jyPQ=NofwV4ha6zBqk7E1gF1xE9CoBfKYfb3jBTbig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h+jyPQ=NofwV4ha6zBqk7E1gF1xE9CoBfKYfb3jBTbig@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for the Review. Few inline replies below.


On 04/09/2019 03:31 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 5, 2019 at 11:17 AM Abhishek Goel
> <huntbag@linux.vnet.ibm.com> wrote:
>> Currently, the cpuidle governors (menu /ladder) determine what idle state
> There are three governors in 5.1-rc.
>
>> an idling CPU should enter into based on heuristics that depend on the
>> idle history on that CPU. Given that no predictive heuristic is perfect,
>> there are cases where the governor predicts a shallow idle state, hoping
>> that the CPU will be busy soon. However, if no new workload is scheduled
>> on that CPU in the near future, the CPU will end up in the shallow state.
>>
>> In case of POWER, this is problematic, when the predicted state in the
>> aforementioned scenario is a lite stop state, as such lite states will
>> inhibit SMT folding, thereby depriving the other threads in the core from
>> using the core resources.
>>
>> To address this, such lite states need to be autopromoted.
> I don't quite agree with this statement and it doesn't even match what
> the patch does AFAICS.  "Autopromotion" would be going from the given
> state to a deeper one without running state selection in between, but
> that's not what's going on here.
Thinking to call it "timed-exit". Is that good?
>> The cpuidle-core can queue timer to correspond with the residency value of the next
>> available state. Thus leading to auto-promotion to a deeper idle state as
>> soon as possible.
> No, it doesn't automatically cause a deeper state to be used next
> time.  It simply kicks the CPU out of the idle state and one more
> iteration of the idle loop runs on it.  Whether or not a deeper state
> will be selected in that iteration depends on the governor
> computations carried out in it.
I did not mean that next state is chosen automatically. I should have been
more descriptive here instead of just using "as soon as possible"
> Now, this appears to be almost analogous to the "polling" state used
> on x86 which uses the next idle state's target residency as a timeout.
>
> While generally I'm not a big fan of setting up timers in the idle
> loop (it sort of feels like pulling your own hair in order to get
> yourself out of a swamp), if idle states like these are there in your
> platform, setting up a timer to get out of them in the driver's
> ->enter() routine might not be particularly objectionable.  Doing that
> in the core is a whole different story, though.
>
> Generally, this adds quite a bit of complexity (on the "ugly" side of
> things IMO) to the core to cover a corner case present in one
> platform, while IMO it can be covered in the driver for that platform
> directly.
As of now, since this code doesn't add any benefit to the other platform,
I will post a patch with this implementation covered in platform-specific
driver code.
You are right that all the information needed for this implementation 
are also
available there in platform driver code, so we should be good to go.
