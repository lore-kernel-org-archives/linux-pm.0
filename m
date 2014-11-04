From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 03/12] PM / Domains: Add notifier support for power domain
 transitions
Date: Tue, 04 Nov 2014 13:08:33 +0100
Message-ID: <5458C1C1.1040307@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
 <5457C791.1000904@samsung.com>
 <CADGdYn6TiXmric5Jzm-38KSmU0iV=9Zxg2wWKL-Ydy1bwxxfDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CADGdYn6TiXmric5Jzm-38KSmU0iV=9Zxg2wWKL-Ydy1bwxxfDA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, pankaj.dubey@samsung.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Beata Michalska <b.michalska@samsung.com>, LAK <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 04/11/14 07:16, amit daniel kachhap wrote:
> On Mon, Nov 3, 2014 at 11:51 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> On 03/11/14 04:53, Amit Daniel Kachhap wrote:
[...]
>>> 4 type of notifications are added,
>>> GPD_OFF_PRE     - GPD state before power off
>>> GPD_OFF_POST    - GPD state after power off
>>> GPD_ON_PRE      - GPD state before power off
>>> GPD_ON_POST     - GPD state after power off
>>>
>>> 3 notfication API's are exported.
>>> 1) int genpd_register_notifier(struct notifier_block *nb, char *pd_name);
>>> 2) int genpd_unregister_notifier(struct notifier_block *nb, char *pd_name);
>>> 3) void genpd_invoke_transition_notifier(struct generic_pm_domain *genpd,
>>>                       enum gpd_on_off_state state);
>>>
>>> In this approach the notifiers are registered/unregistered with pd name.
>>> The actual invoking of the notfiers will be done by the platform implementing
>>> power domain enable/disable low level handlers according to the above
>>> defined notification types. This approach will considerably reduce the
>>> number of call to notifiers as compared to calling always from core
>>> powerdomain subsystem.
>>>
>>> Also the registered domain's will be managed inside a cache list and not
>>> part of the genpd structure. This will help in registration of notifiers from
>>> subsystems (such as clock) even when the PD subsystem is still not initialised.
>>> This list also filters out the unregistered pd's requesting notification.
>>
>> This patch is somewhat similar my patch adding power domain state change
>> notifications [1].  I have already a reworked version of that patch, with the
>> notifier list moved to struct generic_pm_domain and using genpd->lock instead
> 
> Yes this will be correct as others also suggested to make per genpd
> notifier block.
> 
>> of dev->power.lock.  Anyway, while I'd leave the decision about the location
>> from where the notifier chains are supposed to be called to the subsystem's
>> maintainers preference, I'm rather reluctant to having one global notifiers
>> list for all possible power domains and all the notification clients.
>> The possibly long list needs to be traversed at each notifier call and it
>> seems in your implementation any registered user of the notification gets
>> notifications for all possible power domains.
>>
>> [1] https://lkml.org/lkml/2014/8/5/182
>
> My fault, I somehow missed this link earlier. After going through
> this, I found it registers genpd from the platform driver, so the
> function signature is
> int pm_genpd_register_notifier(struct device *dev, struct notifier_block *nb);
> I suggest to make the function signature to be like,
> int pm_genpd_register_notifier(struct device_node *np, struct
> notifier_block *nb)
> 
> In this way this function should should be able to support both
> platform devices and non platform devices like clk.
> 
> The function may work like,
> 
> pdev = of_find_device_by_node(np);
> if (pdev) {
>          //  get genpd from device and go ahead with notfier registration.
>          // blocking_notifier_chain_register(genpd->pd_notifier, nb)
> } else
> {
>         // get pd_handle from np
>         // get the pd_name from phandle and try registering this gen pd
>         // if the genpd subsystem is not initialised then add this in
> a temporary list and register the notifier later
> }
> 
> Can you post your implementation with 1st part ? Later I can post the
> else part with my changes.

Hmm, I doubt making the first argument of the notifier registration
function 'struct device_node *' is a good idea. AFAIK we shouldn't be
introducing and requiring device tree in generic interfaces.

We already tried an approach with pending notifier registration list.
I.e. when the power domain is not yet available we put the notification
registration request onto a separate list, which is then traversed
right before the power domain is registered with PM core.
Then we had a separate notification type for the notification client,
to let it know if his registration request has finally failed
permanently (invoked at some late initcall).

It all works, but it's not something we're really happy with. I hope
we can work out some reasonable solution for mainline. I will post
my PD transition notification patch, however it's mostly to demonstrate
the problem. In v2 PD can be also referred to by name, beside allowing
to just pass a struct device * to a device which belongs to a power
domain.

--
Thanks,
Sylwester
