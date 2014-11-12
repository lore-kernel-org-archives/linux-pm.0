From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Wed, 12 Nov 2014 20:01:56 +0200
Message-ID: <5463A094.7020005@ti.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>	<2024276.CFr3nVUAlA@vostro.rjw.lan>	<CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>	<17707586.6KbjDf5Kep@vostro.rjw.lan>	<CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>	<545D0074.7060205@ti.com>
 <CAPDyKFpgYiRuW0cbpW_ZnZU-bRqvuqzfW+QfkbUTiYVEpE1ZLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpgYiRuW0cbpW_ZnZU-bRqvuqzfW+QfkbUTiYVEpE1ZLA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Tomasz Figa <tomasz.figa@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Jack Dai <jack.dai@rock-chips.com>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jinkun Hong <jinkun.hong@rock-chips.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaron Lu <aaron.lu@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 11/11/2014 01:05 PM, Ulf Hansson wrote:
> [...]
> 
>> 2) There are no requirements for arch/platforms/drivers to work in both cases
>> CONFIG_PM_RUNTIME=y/n. But they must be built without errors/warning for both
>> cases.
> 
> For cross SoC drivers this statement is not correct! Driver _must_
> support the various combinations of CONFIG_PM*.
> 
> Therefore, I think it's better to strive towards a common solution and
> to get the building blocks in place.

There are no common solution ;), because CONFIG_PM_GENERIC_DOMAINS can be "n" too :)
and number of combinations of config options to handle will grow. Right?
What if voltage or clocks domains will be added?

So, everything is about the decision made for arch/platform/soc/driver
and such problems should be solved individually.

Look, once you'll add in core code smth. like in this series - the driver's
code will partially lose ability to control PM. This, in turn, may lead
to the fact that PM management for some drivers or even SoC will be impossible
to add (assume you know that HW engineers can do absolutely crazy things to
reach power savings targets).

> 
>>
>> For example, for Keystone 2 only CONFIG_PM_RUNTIME=y is going to be supported
>> and if some one decided to disable it - it can be perfectly done from sys_fs/
>> user space.
> 
> I can't see why the sysfs option to disable runtime PM should affect
> this discussion. That's done at runtime and after the device has been
> probed.
> 
>>
>> 3) pm_runtime_get_sync()(or similar) is good not only because i's waking up device, but also
>> because:
>> - it can wake up chain of devices (dev->parent->parent->...)
> 
> That's right. But that's not what this patchset aims to do.
> 
> I realize that the header of the cover letter isn't describing the
> problem I am trying to solve very well. I guess the below header would
> have been better:
> 
> "PM / Domains: Power up PM domains prior drivers starts to probe their devices"

Yep. ;) You've mixed a lot of things together in your comments (.
And if i understand right - first of all you are fixing the issue for the case
CONFIG_PM_RUNTIME=y and, in my opinion, the root cause of such issues is 
exactly the usage of pm_runtime_set_active(), because it breaks
symmetry of Runtime PM.

As for me It much more simple to deal with well known limitation of Runtime PM:
"calling of driver's own ->runtime_resume() when pm_runtime_resume() called from probe"
and still benefit from all features provided by pm_runtime_get/put() than playing with pm_runtime_set_active() and:
- fixing unbalanced get/put calls (good example is http://marc.info/?l=linux-pm&m=141580289601886&w=2
  where unexpected (as for me) call of pm_runtime_get_noresume() is added in .remove() callback);
- fixing PD
- fixing enabling of parent devices (it will happen, believe me;).

> 
>> - it can wake up power domain
> 
> Yes, but it requires CONFIG_PM_RUNTIME to be set.
> 
> Thus, to solve the problem during driver ->probe() we need another
> solution which don't require CONFIG_PM_RUNTIME to be set. As this
> patchset proposes.
> 
>> - it connects device to domain/class/type/bus and so allow to add additional PM layer on top
>>    of Platform bus (for example arch/arm/mach-omap2/omap_device.c).
>>
>> So, it will do all needed things, and if it doesn't that problem is in platfrom/bus/driver
>> code and not in Runtime PM.
>> if pm_runtime_get_sync() will be dropped - than all above will need to be implemented
>> around the ->probe().
> 
> I am not sure what you mean about dropping pm_runtime_get_sync()? All
> I am saying is that we can't use it to power on PM domains during the
> probe sequence.

What I'm saying is that it should work with pm_runtime_get_sync
for the case CONFIG_PM_RUNTIME=y ;) and It might be better to power on PD once the
first device is attached to it if CONFIG_PM_RUNTIME=n and do this inside GPD code.
(^ it could even make your patch smaller)

> 
> Of course, you may still use pm_runtime_get_sync() from anywhere it's
> needed, to for example handle device's parent/child relationships.
> 
>>
>> 4) I've copied here comment from Rafael:
>>   >>>> Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
>>   >>>> it must take the fact that the driver's own ->runtime_resume() may be called
>>   >>>> as a result of this into account.
>>   Agree, that's a little bit annoying, but we are living with that for more then
>>   5 years already (I'm 3 years) - so, I am, as driver developer, expecting above behavior
>>   (just walk through the drivers and you will see how many drivers expecting the same).
>>
>> So, any volunteers to check and fix ~500 drivers.
> 
> We don't have to change these drivers. An certainly they are not 500. :-)

+- 10% - I've calculated number of occurrences of pm_runtime_enable()  :)

> 
> They will still work as is!
> 
> Though we need this fix to comply with them, which is supposed to go
> in for 3.18 rc[n].
> "PM / Domains: Fix initial default state of the need_restore flag"

Ok. Looks like we both still hold one's ground :) I give up (found at about ~70 
drivers which use set_active() in probe - and it's at about of 20% of all 
Runtime PM enabled drivers).

But could you, at least, consider my proposition to enable PD from
dev_pm_domain_attach/detach once first device is attached to it, pls?

regards,
-grygorii

	
