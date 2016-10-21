From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] cpuidle: governors: Move the files to the upper directory
Date: Fri, 21 Oct 2016 15:22:18 +0200
Message-ID: <CAJZ5v0hiQSXQ8XZkHWVCwD33cymTQ9kQ9nPotw1RxRgHg-9zrQ@mail.gmail.com>
References: <1475652794-4486-1-git-send-email-daniel.lezcano@linaro.org>
 <1475652794-4486-2-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0jSqucMXyM7d9K2V0XA_i3kX=cF8ir-41bLgJYKJ27UGQ@mail.gmail.com> <20161021130953.GB1636@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021130953.GB1636@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 21, 2016 at 3:09 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Fri, Oct 21, 2016 at 02:47:22PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Oct 5, 2016 at 9:33 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>> > Currently the different governors are stored in the subdir
>> > 'governors'. That is not a problem.
>> >
>> > However, that forces to declare some private structure in the
>> > include/linux/cpuidle.h header because these governor files
>> > don't have access to the private 'cpuidle.h' located in
>> > drivers/cpuidle.
>> >
>> > Instead of having the governors in the separate directory, move
>> > them along with the drivers and prefix them with 'governor-',
>> > that allows to do a proper cleanup in the cpuidle headers.
>>
>> While I'm not particularly against this change, I'm sort of wondering
>> about the reason.
>>
>> What in particular would be wrong with doing
>>
>> #include "../cpuidle.h"
>>
>> in a governor .c file?
>
> Hi Rafael,
>
> there is nothing wrong by doing this relative inclusion. It is an alternative
> to the proposed patch. I personally don't like relative inclusion but it is
> a matter of taste and I am perfectly fine to resend the patch by just moving
> the structure to the private header and change the inclusion.
>
> On the other side, the cpufreq susbsytem has all the governors along with the
> drivers in the same directory, so perhaps it makes sense to have a similar files
> organization.
>
> Actually, I'm fine with both approaches. Up to you to decide.

I'm thinking let's keep the code where it is in case people depend on
the current location somehow (ie. have patches out of the tree or
similar).  We can still move it later if need be.

Thanks,
Rafael
