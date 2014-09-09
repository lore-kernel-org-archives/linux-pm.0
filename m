From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v4 0/9] PM / Domains: Generic OF-based support
Date: Tue,  9 Sep 2014 13:36:01 +0200
Message-ID: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34764 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360AbaIILgf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 07:36:35 -0400
Received: by mail-la0-f47.google.com with SMTP id el20so10598226lab.20
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 04:36:33 -0700 (PDT)
In-Reply-To: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

Changes in v4:
	- Rebased patch "PM / Domains: Add generic OF-based PM domain look-up" -
	  and updated the author and the commit message.
	- Adopted review comments for "PM / Domains: Add APIs to attach/detach
	  a PM domain for a device".
	- Updated author and commit message for "ARM: exynos: Move to generic
	  PM domain DT bindings".
	- Added some acks and reviewed by tags.
	- Started to use the "--in-reply-to" option to git-send-email. It should
	  provide the option to show a better diffstat per patch.

Changes in v3:
	- Aligned on terminology, now using "PM domain" in comments and commit
	- messages/headers.
	- Improved English and grammar in comments and commit messages/headers.
	- Adopted proposal from Geert, to have compile-time-check wrapper
	  functions for the API that adds xlate_simple and xlate_onecell
	  providers.
 	- Renamed "domain_num" to "num_domains", in genpd_onecell_data struct.
	- Handle non-contiguous arrays for onecell PM domain providers.
	- Rebased the Exynos patch to follow the new genpd API changes.


Changes in v2:
	- Fix the ACPI patch, it didn't even compile for CONFIG_ACPI.
	- Updated some comments in code and in commit messages.
	- Fixed the dev_pm_domain_attach API to handle EPROBE_DEFER properly.
	- Rebased the ARM Exynos patch.
	- Added some Tested-by tags.


This patchset has a bit of a history and some parts of it has been posted
earlier.

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html

In the first revision I intentially didn't increase version number of the
patches, since I think it would have cause more confusion than clarity.

A summary of changes in V1 and since the last patchset, from the link above:
	- Instead of letting driver core handling the device to power domain
	binding/unbinding, follow the behavior of how the ACPI power domain
	is handled.


This is a summary of what these patches are intended to do:

1)
Add generic power domain OF-based support which also includes APIs to handle
attach/detach of generic power domains to devices.

2)
Adding a common API to attach/detach power domains and include support for the
ACPI and the generic power domain in there.

3)
>From subsystem level code, at probe/remove, convert from invoking the ACPI
specific power domain attach/detach functions to the new common attach/detach
APIs.

4)
Add support for the AMBA bus to attach/detach power domains, using the new
common APIs.

5)
Convert Exynos to use the new generic power domain OF support.

Obviously, there are dependencies througout this patchset, which means if they
get accepted the all need to go together. It might also be convenient to share
them through an immutable branch.


Tomasz Figa (2):
  PM / Domains: Add generic OF-based PM domain look-up
  ARM: exynos: Move to generic PM domain DT bindings

Ulf Hansson (7):
  ACPI / PM: Let acpi_dev_pm_detach() return an error code
  PM / Domains: Add APIs to attach/detach a PM domain for a device
  drivercore / platform: Convert to dev_pm_domain_attach|detach()
  i2c: core: Convert to dev_pm_domain_attach|detach()
  mmc: sdio: Convert to dev_pm_domain_attach|detach()
  spi: core: Convert to dev_pm_domain_attach|detach()
  amba: Add support for attach/detach of PM domains

 .../bindings/arm/exynos/power_domain.txt           |  13 +-
 .../devicetree/bindings/power/power_domain.txt     |  49 ++++
 arch/arm/mach-exynos/pm_domains.c                  |  78 +-----
 drivers/acpi/device_pm.c                           |   8 +-
 drivers/amba/bus.c                                 |  10 +-
 drivers/base/platform.c                            |  15 +-
 drivers/base/power/common.c                        |  60 +++++
 drivers/base/power/domain.c                        | 291 +++++++++++++++++++++
 drivers/i2c/i2c-core.c                             |  13 +-
 drivers/mmc/core/sdio_bus.c                        |   4 +-
 drivers/spi/spi.c                                  |  12 +-
 include/linux/acpi.h                               |   7 +-
 include/linux/pm.h                                 |  14 +
 include/linux/pm_domain.h                          |  57 ++++
 kernel/power/Kconfig                               |   4 +
 15 files changed, 528 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/power_domain.txt

-- 
1.9.1

