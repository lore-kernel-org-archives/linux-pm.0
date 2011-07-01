From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 7/10 v6] PM / Domains: Don't stop wakeup
	devices during system sleep transitions
Date: Fri, 01 Jul 2011 07:34:16 -0700
Message-ID: <87tyb66pef.fsf__11005.0000170761$1309530933$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <201107010128.03732.rjw@sisk.pl>
	<8762nmc1hs.fsf@ti.com> <201107010224.37609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107010224.37609.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri, 1 Jul 2011 02:24:37 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, July 01, 2011, Kevin Hilman wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> ...
>> > So the only way forward I can see is to add a special PM domain callback,
>> > say .active_wakeup(), that will return "true" if the device is to be left
>> > active when wakeup-enabled.  So the check you don't like will become
>> > something like:
>> >
>> > if (device_may_wakeup(dev) && genpd->active_wakeup
>> >     && genpd->active_wakeup(dev))
>> >         return 0;
>> >
>> > Would that be better?
>> 
>> Yes, much better.  And I like the default behavior if no hooks are provided.
>
> So, what about the appended patch instead of the $subject one?
>
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Domains: Wakeup devices support for system sleep transitions
>
> There is the problem how to handle devices set up to wake up the
> system from sleep states during system-wide power transitions.
> In some cases, those devices can be turned off entirely, because the
> wakeup signals will be generated on their behalf anyway.  In some
> other cases, they will generate wakeup signals if their clocks are
> stopped, but only if power is not removed from them.  Finally, in
> some cases, they can only generate wakeup signals if power is not
> removed from them and their clocks are enabled.
>
> To allow platform-specific code to decide whether or not to put
> wakeup devices (and their PM domains) into low-power state during
> system-wide transitions, such as system suspend, introduce a new
> generic PM domain callback, .active_wakeup(), that will be used
> during the "noirq" phase of system suspend and hibernation (after
> image creation) to decide what to do with wakeup devices.
> Specifically, if this callback is present and returns "true", the
> generic PM domain code will not execute .stop_device() for the
> given wakeup device and its PM domain won't be powered off.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks,

Kevin
