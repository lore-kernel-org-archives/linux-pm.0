From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Wed, 25 Feb 2015 12:25:14 +0000
Message-ID: <9hhbnki6uvp.fsf@e105922-lin.cambridge.arm.com>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
	<20150216151432.GB8648@developer.hsd1.ca.comcast.net>
	<9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
	<20150224195201.GB353@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:39935 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752646AbbBYMYo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 07:24:44 -0500
In-Reply-To: <20150224195201.GB353@developer.amazonguestwifi.org> (Eduardo
	Valentin's message of "Tue, 24 Feb 2015 15:52:02 -0400")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org

Eduardo Valentin <edubezval@gmail.com> writes:

> On Tue, Feb 17, 2015 at 11:12:22AM +0000, Punit Agrawal wrote:
>> Eduardo Valentin <edubezval@gmail.com> writes:
>> 
>> > Hey Punit,
>> >
>> > On Tue, Feb 10, 2015 at 06:21:46PM +0000, Punit Agrawal wrote:
>> >> When registering a thermal zone from device tree, default the trip
>> >> points to writable. By default, only the root user can change these.
>> >> 
>> >> This allows the trip points to be tweaked after the system has
>> >> booted.
>> >
>> > Can you please elaborate more on why having default writable makes sense
>> > against having default read only? The purpose of this patch seams to be
>> > targeted to development/debugging systems, not productions systems. The
>> > default has to make sense for production systems.
>> 
>> Agreed about the default making sense for production systems.
>> 
>> We've seen deployments in the field where the default value of the trip
>> temperatures are modulated by a userspace component that has contextual
>> knowledge about workloads and device margins. Using OF for thermal
>> setup, it is not possible to get this functionality.
>> 
>> I guess you are worried about safety - as you still need root privileges
>> to be able to change the trip temperatures so it's not by-passing the
>> security setup of the system.
>> 
>> >
>> >> 
>> >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> >> ---
>> >> Hi Eduardo,
>> >> 
>> >> We've been using this patch internally and haven't run into any
>> >>  issues. Without these changes there is no way to change trip points
>> >>  from a running system.
>> >
>> > Ok. I see.
>> >
>> > So, the problem statement here is to be able to change the trip points
>> > from a running system. What is the purpose? Do you have something in
>> > userland that is benefiting of having these trips writable? Or is it
>> > just for development fun?
>> 
>> Sure it helps with development too. In a workflow where the development
>> of the drivers and the tuning are separate activities, and not
>> necessarily done by the same people, it is very helpful to be able to
>> evaluate different parameters for power-performance-thermal tuning
>> without having to rebuild the dtb and reboot the system.
>> 
>> I think it makes it easier for folks to get up and running with OF and
>> thermals. But I'll defer to your judgement here.
>
>
> Punit,
>
> I understand your concerns and thoughts. Let me make a counterproposal.
> Instead of making the trip points populated by of-thermal writable by default,
> how about if we do the following?
>
> (1) - Change thermal core to have a Kconfig option to allow system
> integrator to choose if trip points are writable or not. So, on top of
> the mask index flags for each trip, the Kconfig must be enabled at
> compilation time. If the Kconfig option is disable, no trip points will
> get write access, regardless the mask provided by the thermal drivers.
> Here, I would prefer to have the default behavior as readonly.
>
> (2) - Change of-thermal to provide writable trip points by default
> (essentially, this present patch).
>
> Although no changes in this patch are required, I would prefer to merge
> first number (1) above.
>
> In this way, we allow an option to system engineers that do not want user
> space to mess with their kernel thermal policy. And we also allow people
> who has userspace thermal policy to work properly. And, by grant, we
> have an option to make development easier.
>
> What is your optionion?

Although I understand your motivation for suggesting (1), I am not sure
this will work in practice. As soon as one platform enables the option
in the defconfig (arm64) or multi_v7_defconfig (arm), all platforms will
have it enabled.

But if you think it's worth merging, something like below should do it.

>
> I am copying Srinivas here too. Srinivas, do you think that option (1)
> above will break things in userspace on your side?
>
>> 
>> Cheers,
>> Punit
>> 
>> >
>> >
>> > BR,
>> >
>> > Eduardo Valentin
>> >
>> >> 
>> >> Comments welcome.
>> >> 
>> >> Cheers,
>> >> Punit
>> >> 

-- >8 --

Subject: [PATCH] thermal: core: Add Kconfig option to enable writable trips

Add a Kconfig option to allow system integrators to control whether
userspace tools can change trip temperatures. This option overrides
the thermal zone setup in the driver code and must be enabled for
platform specified writable trips to come into effect.

The original behaviour of requiring root privileges to change trip
temperatures remains unchanged.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 drivers/thermal/Kconfig        | 11 +++++++++++
 drivers/thermal/thermal_core.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index af40db0..5d2d39b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -42,6 +42,17 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_WRITABLE_TRIPS
+	bool "Enable writable trip points"
+	help
+	  This option allows the system integrator to choose whether
+	  trip temperatures can be changed from userspace. The
+	  writable trips need to be specified when setting up the
+	  thermal zone but the choice here takes precedence.
+
+	  Say 'Y' here if you would like to allow userspace tools to
+	  change trip temperatures.
+
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 48491d1..15111c1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1378,7 +1378,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
-		if (mask & (1 << indx)) {
+		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
+		    mask & (1 << indx)) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
-- 
2.1.4
