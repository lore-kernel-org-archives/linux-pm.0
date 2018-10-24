From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/3] PM: Renesas: Remove dummy runtime PM callbacks
Date: Wed, 24 Oct 2018 16:51:31 +0300
Message-ID: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

I noticed these independent Renesas drivers have needless dummy runtime
PM callbacks. I don't have the HW so only build tested.

Patches can be applied independently to their own subsystems. I wanted to
send them together if some of them gets Tested-by or sees a regression.

Jarkko Nikula (3):
  i2c: sh_mobile: Remove dummy runtime PM callbacks
  net: ethernet: Remove dummy runtime PM callbacks from Renesas drivers
  usb: renesas_usbhs: Remove dummy runtime PM callbacks

 drivers/i2c/busses/i2c-sh_mobile.c       | 18 ------------------
 drivers/net/ethernet/renesas/ravb_main.c | 13 -------------
 drivers/net/ethernet/renesas/sh_eth.c    | 13 -------------
 drivers/usb/renesas_usbhs/common.c       | 14 --------------
 4 files changed, 58 deletions(-)

-- 
2.19.1
