From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] PM / Domains: Handle errors from ->attach_dev() callback
Date: Tue, 28 Oct 2014 15:38:06 +0100
Message-ID: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patchset enabled the recently added ->attach_dev() callback to return an
error code.

Typically these callbacks will fetch some PM resourses, like clocks through a
clk_get() which may fail. To be able to handle the errors we need to return an
error code.

Do note, the buses which invokes dev_pm_domain_attach() are already handling
-EPROBE_DEFER, which means the ->attach_dev() callbacks may also return this
if needed.


Ulf Hansson (4):
  PM / Domains: Remove reference counting for the generic_pm_domain_data
  PM / Domains: Don't allow an existing generic PM domain data
  PM / Domains: Improve error handling while adding/removing devices
  PM / Domains: Let the ->attach_dev() callback return an error code

 drivers/base/power/domain.c | 143 +++++++++++++++++++++++---------------------
 include/linux/pm_domain.h   |   3 +-
 2 files changed, 77 insertions(+), 69 deletions(-)

-- 
1.9.1
