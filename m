From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/4] Support INT3406 Display thermal device
Date: Wed, 27 Apr 2016 21:38:40 +0200
Message-ID: <CAJZ5v0hjvMc98WgAUJG3MPNNZm8YiCBxP6OdmW-oP7MnH+69wA@mail.gmail.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36167 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbcD0Tin (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 15:38:43 -0400
In-Reply-To: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Jingoo Han <jingoohan1@gmail.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

On Wed, Apr 27, 2016 at 2:45 PM, Aaron Lu <aaron.lu@intel.com> wrote:
> v3:
> Split patch 3/3 in v2 into 2 patches: one makes changes to acpi_video
> and one adds the int3406 driver as suggested by Rafael. There should
> be no functionality change compared to v2.
>
> v2:
> The display thermal device represents the LED/LCD display panel
> that may or may not include touch support. The main function of
> the display thermal device is to allow control of the display
> brightness in order to address a thermal condition or to reduce
> power consumed by display device.
>
> Due to the way this thermal device changes brightness level is said
> to be deprecated so we are using the raw interface to do the actual
> backlight change. This requires the backlight core support so two
> new APIs are added and exported in patch 1/3. With this, the previous
> API backlight_device_registered can be removed and this is done in
> patch 2/3. Patch 3/3 adds the new int3406 thermal driver.
>
> The 1st version is here:
> http://thread.gmane.org/gmane.linux.acpi.devel/72619
>
> This whole series should go through the thermal tree if applied.
>
> Aaron Lu (3):
>   video / backlight: add two APIs for drivers to use
>   video / backlight: remove the backlight_device_registered API
>   Thermal: add INT3406 thermal driver
>
>  drivers/acpi/acpi_video.c                         |  83 ++++----
>  drivers/acpi/video_detect.c                       |   2 +-
>  drivers/thermal/Kconfig                           |  28 +--
>  drivers/thermal/int340x_thermal/Kconfig           |  42 ++++
>  drivers/thermal/int340x_thermal/Makefile          |   1 +
>  drivers/thermal/int340x_thermal/int3406_thermal.c | 236 ++++++++++++++++++++++
>  drivers/video/backlight/backlight.c               |  39 ++--
>  include/acpi/video.h                              |  20 ++
>  include/linux/backlight.h                         |   3 +-
>  9 files changed, 374 insertions(+), 80 deletions(-)
>  create mode 100644 drivers/thermal/int340x_thermal/Kconfig
>  create mode 100644 drivers/thermal/int340x_thermal/int3406_thermal.c

The first three patches in this series look OK to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the [1-3/4].

That said it may be better if those three go in via ACPI.  I can put
them into a separate branch for Rui to pull from.

Please let me know what you think.
