From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and Power? due for the v4.19
 merge window
Date: Wed, 4 Jul 2018 07:12:46 +0100
Message-ID: <20180704061246.GV20176@dell>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502154418.2153-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Apologies for the delay -- these two patches dropped from my radar.

Enjoy!

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-v4.19

for you to fetch changes up to 3144dce72b7c53a0ca9f054c8187925c40381caa:

  mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice. (2018-07-04 07:10:05 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Power? due for the v4.19 merge window

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.

Sameer Nanda (1):
      mfd: cros_ec: Add USBPD charger commands and struct definitions.

 drivers/mfd/cros_ec_dev.c            |  16 +++++
 include/linux/mfd/cros_ec_commands.h | 132 +++++++++++++++++++++++++++++++++--
 2 files changed, 144 insertions(+), 4 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
