From: Kevin Hilman <khilman@ti.com>
Subject: Re: [Update][PATCH 6/10] PM / Domains: System-wide
	transitions support for generic domains (v5)
Date: Fri, 08 Jul 2011 10:20:52 -0700
Message-ID: <87y6088z9n.fsf__21552.5364190855$1310145721$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1107081033000.2208-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107081033000.2208-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Fri, 8 Jul 2011 10:37:32 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 8 Jul 2011, Rafael J. Wysocki wrote:
>
>> On Friday, July 08, 2011, Kevin Hilman wrote:
>> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> > 
>> > > From: Rafael J. Wysocki <rjw@sisk.pl>
>> > >
>> > > Make generic PM domains support system-wide power transitions
>> > > (system suspend and hibernation).  Add suspend, resume, freeze, thaw,
>> > > poweroff and restore callbacks to be associated with struct
>> > > generic_pm_domain objects and make pm_genpd_init() use them as
>> > > appropriate.
>> > >
>> > > The new callbacks do nothing for devices belonging to power domains
>> > > that were powered down at run time (before the transition).  
>> > 
>> > Thinking about this some more, how is a driver supposed to reconfigure
>> > wakeups during suspend if it has already been runtime suspended?
>> 
>> If the device belongs to a PM domain that has been powered off, it
>> won't be notified.
>> 
>> > For example, assume a device where device_may_wakeup() == false.  This
>> > means wakeups during *suspend* are disabled, but wakeups wakeups are
>> > assumed to enabled when it is runtime suspended.
>> > 
>> > So now, assume this device is RPM_SUSPENDED, it has wakeups *enabled*,
>> > and then system suspend comes along.  
>> > 
>> > With this current patch, the driver will never receive any callbacks, so
>> > it can never disable its wakeups.  
>> >
>> > Am I missing something?
>> 
>> As I said above, this only happens with devices that belog to PM domains
>> that were powered off before system suspend has started, so the problem
>> is limited to devices that wakeup is signaled on behalf of even when they
>> have no power.

Which on OMAP, is *all* devices, so that's a pretty major limitation.  :)

>> So this is a limitation, but not affecting all platforms.
>> 
>> There are a few ways to avoid this limitation I can think of:
>> (1) Add a "make me operational during system suspend" flag to struct dev_pm_info
>>     and run pm_runtime_resume() on such devices from the core (either dpm_prepare()
>>     core, or pm_genpd_prepare()).
>
> What's to prevent the device from being runtime-suspended again before 
> the wakeup setting can be changed?
>
>> (2) Add a "my .prepare() is safe to run if device is not accessible" flag to
>>     struct dev_pm_info and make pm_genpd_prepare() execute .prepare() for such
>>     devices regardless of whether or not their PM domains are off.
>> (3) Call .prepare() from all drivers unconditionally during system suspend
>>     (and probably .complete() too) in the hope they won't access inaccessible
>>     devices.

Like Alan's comment above for (1), I think the same applies for (3)
since runtime PM transitions can still happen between .prepare() and
.suspend()

Kevin

>> Probably, there's more.
>
> In the PM domain's suspend code, do a runtime resume if the wakeup
> setting needs to be changed, rather than simply skipping over the
> device.
>
>> In any case I think it's material for future work.
>
> Alan Stern
