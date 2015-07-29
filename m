From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Wed, 29 Jul 2015 15:57:31 +0200
Message-ID: <CAJZ5v0iUn0rSVSqyXscCfGgujpM7r9o9xjQgDOk+JQ=y6seRgQ@mail.gmail.com>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
	<4080510.IQ60sVQvbL@vostro.rjw.lan>
	<20150727143935.GB18535@linux>
	<2112385.YuDJ7h1x56@vostro.rjw.lan>
	<20150729091136.GN7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37016 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbG2N5d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 09:57:33 -0400
In-Reply-To: <20150729091136.GN7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Russell,

On Wed, Jul 29, 2015 at 11:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 29, 2015 at 03:38:03AM +0200, Rafael J. Wysocki wrote:
>> On Monday, July 27, 2015 08:09:35 PM Viresh Kumar wrote:
>> > On 27-07-15, 15:45, Rafael J. Wysocki wrote:
>> > > Say the subsys add callback runs for a CPU and it doesn't have a policy.
>> > > If it is offline, we ignore it and the add callback won't be executed
>> > > for it again.
>> > >
>> > > In turn, if it is online, we create a policy for it and we should (right
>> > > away) link the policy to all of the CPUs that were offline when the subsys add
>> > > callback was called for them.  That's what we do today.
>> > >
>> > > Is there anything missing in that?
>> >
>> > So the code is working properly after your patch, but I was talking
>> > on the lines of what Russell suggested.
>> >
>> > We should play with the links only when we receive add-dev/remove-dev
>> > from subsys callbacks. The exception to that will be the offline CPUs
>> > for which add-dev is called before their policy existed.
>>
>> The rule is supposed to be "all of the present CPUs which do not own
>> a policy should point to one, unless it doesn't exist".  The right
>> approach is then to create links from them to a policy object as soon
>> as we create one for them.  Waiting for something else to happen is just
>> pointless and this approach covers both the offline and online CPUs, so
>> I don't think that changing it would improve things really.
>
> I'm not sure we disagree with that.  It's more about when the symlinks
> are created, and when you define that a CPU exists.
>
> If you're attaching to subsystem in sysfs, then the point that the
> subsystem interface gets to know about a sysfs node existing is when
> it's add_dev method is called - it should not assume that a node exists
> prior to that point, otherwise things are racy.
>
> Consider a policy initialisation in parallel with an update of the
> CPU present map and adding a CPU to sysfs.  The CPU present map will be
> updated first, and then it will be added to sysfs.  If you're initialising
> a cpufreq policy in the middle of that and creating symlinks for all
> present CPUs, there's a window where the CPU present map indicates that
> a CPU is present, but there is no sysfs directory for you to create a
> symlink in.

In practice, this means a cpufreq driver registration done in parallel
with CPU hotplug.

Indeed, there is a small race window in that case, but it can be
closed easily by making cpufreq driver registration and CPU hotplug
mutually exclusive (we do that already for cpufreq driver
unregistration in linux-next anyway).

Thanks,
Rafael
