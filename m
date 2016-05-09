From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/4] Support INT3406 Display thermal device
Date: Mon, 9 May 2016 14:23:30 +0200
Message-ID: <CAJZ5v0gR27r=Hvm8=y5puQYUj_Qw+uxKy-59aJ=F044Saab+Tg@mail.gmail.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
	<CAJZ5v0hjvMc98WgAUJG3MPNNZm8YiCBxP6OdmW-oP7MnH+69wA@mail.gmail.com>
	<56b0b394-4984-62b8-9d4c-efefe8fdae8d@intel.com>
	<7370640.WWc4AQ4034@vostro.rjw.lan>
	<d160a515-3e11-8faa-71a4-233ff1b7d70d@intel.com>
	<1462780173.10198.5.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35905 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbcEIMXd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 08:23:33 -0400
In-Reply-To: <1462780173.10198.5.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "Lu, Aaron" <aaron.lu@intel.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "rafael@kernel.org" <rafael@kernel.org>

On Mon, May 9, 2016 at 9:49 AM, Zhang, Rui <rui.zhang@intel.com> wrote:
> On Fri, 2016-05-06 at 14:45 +0800, Aaron Lu wrote:
>> On 05/05/2016 05:47 AM, Rafael J. Wysocki wrote:
>> > On Thursday, April 28, 2016 09:48:30 AM Aaron Lu wrote:
>> >> On 04/28/2016 03:38 AM, Rafael J. Wysocki wrote:
>> >>> On Wed, Apr 27, 2016 at 2:45 PM, Aaron Lu <aaron.lu@intel.com> wrote:
>> >>>> v3:
>> >>>> Split patch 3/3 in v2 into 2 patches: one makes changes to acpi_video
>> >>>> and one adds the int3406 driver as suggested by Rafael. There should
>> >>>> be no functionality change compared to v2.
>> >>>>
>> >>>> v2:
>> >>>> The display thermal device represents the LED/LCD display panel
>> >>>> that may or may not include touch support. The main function of
>> >>>> the display thermal device is to allow control of the display
>> >>>> brightness in order to address a thermal condition or to reduce
>> >>>> power consumed by display device.
>> >>>>
>> >>>> Due to the way this thermal device changes brightness level is said
>> >>>> to be deprecated so we are using the raw interface to do the actual
>> >>>> backlight change. This requires the backlight core support so two
>> >>>> new APIs are added and exported in patch 1/3. With this, the previous
>> >>>> API backlight_device_registered can be removed and this is done in
>> >>>> patch 2/3. Patch 3/3 adds the new int3406 thermal driver.
>> >>>>
>> >>>> The 1st version is here:
>> >>>> http://thread.gmane.org/gmane.linux.acpi.devel/72619
>> >>>>
>> >>>> This whole series should go through the thermal tree if applied.
>> >>>>
>> >>>> Aaron Lu (3):
>> >>>>   video / backlight: add two APIs for drivers to use
>> >>>>   video / backlight: remove the backlight_device_registered API
>> >>>>   Thermal: add INT3406 thermal driver
>> >>>>
>> >>>>  drivers/acpi/acpi_video.c                         |  83 ++++----
>> >>>>  drivers/acpi/video_detect.c                       |   2 +-
>> >>>>  drivers/thermal/Kconfig                           |  28 +--
>> >>>>  drivers/thermal/int340x_thermal/Kconfig           |  42 ++++
>> >>>>  drivers/thermal/int340x_thermal/Makefile          |   1 +
>> >>>>  drivers/thermal/int340x_thermal/int3406_thermal.c | 236 ++++++++++++++++++++++
>> >>>>  drivers/video/backlight/backlight.c               |  39 ++--
>> >>>>  include/acpi/video.h                              |  20 ++
>> >>>>  include/linux/backlight.h                         |   3 +-
>> >>>>  9 files changed, 374 insertions(+), 80 deletions(-)
>> >>>>  create mode 100644 drivers/thermal/int340x_thermal/Kconfig
>> >>>>  create mode 100644 drivers/thermal/int340x_thermal/int3406_thermal.c
>> >>>
>> >>> The first three patches in this series look OK to me, so
>> >>>
>> >>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>>
>> >>> for the [1-3/4].
>> >>>
>> >>> That said it may be better if those three go in via ACPI.  I can put
>> >>> them into a separate branch for Rui to pull from.
>> >>>
>> >>> Please let me know what you think.
>> >>
>> >> I have no problem with that.
>> >
>> > OK
>> >
>> > [1-3/4] have been queued up for 4.7 in my tree.  Please let me know if you
>> > want me to expose the branch containing them.
>>
>> Thanks a lot!
>>
>> Rui,
>>
>> Do you need a branch so that you can pull and merge 4/4 on top of that?
>>
> Rafael, can you please take patch 4/4 as well?
> It should not conflict with my other thermal material.

I can do that, but can you please ACK it for me?
