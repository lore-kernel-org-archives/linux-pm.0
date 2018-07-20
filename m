From: David Lechner <david@lechnology.com>
Subject: [PATCH 0/2] power: supply: lego_ev3_battery improvements
Date: Fri, 20 Jul 2018 15:19:42 -0500
Message-ID: <20180720201944.20503-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: David Lechner <david@lechnology.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series improves error handling and accuracy of the LEGO MINDSTORMS EV3
battery driver.

David Lechner (2):
  power: supply: lego_ev3_battery: Don't ignore
    iio_read_channel_processed() return value
  power: supply: lego_ev3_battery: fix Vce offset

 drivers/power/supply/lego_ev3_battery.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.17.1
