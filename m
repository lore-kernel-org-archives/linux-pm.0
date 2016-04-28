From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v3 0/4] Support INT3406 Display thermal device
Date: Thu, 28 Apr 2016 09:48:30 +0800
Message-ID: <56b0b394-4984-62b8-9d4c-efefe8fdae8d@intel.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
 <CAJZ5v0hjvMc98WgAUJG3MPNNZm8YiCBxP6OdmW-oP7MnH+69wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hjvMc98WgAUJG3MPNNZm8YiCBxP6OdmW-oP7MnH+69wA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Jingoo Han <jingoohan1@gmail.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

On 04/28/2016 03:38 AM, Rafael J. Wysocki wrote:
> On Wed, Apr 27, 2016 at 2:45 PM, Aaron Lu <aaron.lu@intel.com> wrote:
>> v3:
>> Split patch 3/3 in v2 into 2 patches: one makes changes to acpi_video
>> and one adds the int3406 driver as suggested by Rafael. There should
>> be no functionality change compared to v2.
>>
>> v2:
>> The display thermal device represents the LED/LCD display panel
>> that may or may not include touch support. The main function of
>> the display thermal device is to allow control of the display
>> brightness in order to address a thermal condition or to reduce
>> power consumed by display device.
>>
>> Due to the way this thermal device changes brightness level is said
>> to be deprecated so we are using the raw interface to do the actual
>> backlight change. This requires the backlight core support so two
>> new APIs are added and exported in patch 1/3. With this, the previous
>> API backlight_device_registered can be removed and this is done in
>> patch 2/3. Patch 3/3 adds the new int3406 thermal driver.
>>
>> The 1st version is here:
>> http://thread.gmane.org/gmane.linux.acpi.devel/72619
>>
>> This whole series should go through the thermal tree if applied.
>>
>> Aaron Lu (3):
>>   video / backlight: add two APIs for drivers to use
>>   video / backlight: remove the backlight_device_registered API
>>   Thermal: add INT3406 thermal driver
>>
>>  drivers/acpi/acpi_video.c                         |  83 ++++----
>>  drivers/acpi/video_detect.c                       |   2 +-
>>  drivers/thermal/Kconfig                           |  28 +--
>>  drivers/thermal/int340x_thermal/Kconfig           |  42 ++++
>>  drivers/thermal/int340x_thermal/Makefile          |   1 +
>>  drivers/thermal/int340x_thermal/int3406_thermal.c | 236 ++++++++++++++++++++++
>>  drivers/video/backlight/backlight.c               |  39 ++--
>>  include/acpi/video.h                              |  20 ++
>>  include/linux/backlight.h                         |   3 +-
>>  9 files changed, 374 insertions(+), 80 deletions(-)
>>  create mode 100644 drivers/thermal/int340x_thermal/Kconfig
>>  create mode 100644 drivers/thermal/int340x_thermal/int3406_thermal.c
> 
> The first three patches in this series look OK to me, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the [1-3/4].
> 
> That said it may be better if those three go in via ACPI.  I can put
> them into a separate branch for Rui to pull from.
> 
> Please let me know what you think.

I have no problem with that.

Regards,
Aaron
