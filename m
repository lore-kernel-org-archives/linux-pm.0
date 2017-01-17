From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC updates for v4.10-rc5
Date: Mon, 16 Jan 2017 21:07:02 -0800
Message-ID: <20170117050700.GA24653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rui,

Please consider pulling the following fixes on rockchip driver.

There are more fixes on TI SoC in the mailing list which I am still
testing. So, I decided to send you only these 6 patches on
rockchip, as they have been in my tree for some time. Please pull.

The following changes since commit cdb98c2698b4af287925abcba4d77d92af82a0c3:

  Revert "nvme: add support for the Write Zeroes command" (2016-12-13 19:53:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to db8318865e2c04dbe3d95089c7215b94a5b879b7:

  thermal: rockchip: fixes the conversion table (2017-01-16 20:30:49 -0800)

----------------------------------------------------------------
Brian Norris (2):
      thermal: rockchip: improve conversion error messages
      thermal: rockchip: don't pass table structs by value

Caesar Wang (4):
      thermal: rockchip: fixes invalid temperature case
      thermal: rockchip: optimize the conversion table
      thermal: rockchip: handle set_trips without the trip points
      thermal: rockchip: fixes the conversion table

 drivers/thermal/rockchip_thermal.c | 153 ++++++++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 53 deletions(-)
