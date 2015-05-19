From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v3 0/2] PM: direct_complete_default and pm_runtime_enable_recursive
Date: Tue, 19 May 2015 16:11:14 +0200
Message-ID: <1432044679-10256-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

this is v3 of a series that adds API to make it more convenient for drivers to
opt into remaining runtime suspended when the system goes to sleep.

in this version I have replaced force_direct_complete with
direct_complete_default as suggested by Rafael and thus have had to add a
pm_runtime_enable_recursive() function call to make sure that all descendants
have runtime PM enabled.

Inheritance of the direct_complete_default flag has to be done in
device_pm_add instead of in pm_runtime_init because sometimes the parent won't
have been set yet by then.

Thanks,

Tomeu

Tomeu Vizoso (2):
  PM / sleep: Add power.direct_complete_default flag
  PM / Runtime: Add pm_runtime_enable_recursive

 Documentation/power/runtime_pm.txt |  8 +++++++-
 drivers/base/power/main.c          |  5 +++++
 drivers/base/power/runtime.c       | 15 +++++++++++++++
 include/linux/pm.h                 |  1 +
 include/linux/pm_runtime.h         |  1 +
 5 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.4.1
