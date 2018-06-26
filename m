From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/2] power: generic-adc-battery: fix out of bounds write
Date: Tue, 26 Jun 2018 15:28:28 +0200
Message-ID: <cover.1530019688.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, anish kumar <anish198519851985@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

This patch set addresses two bugs in the gab_probe() function which are
there since the first commit in 3.7-rc1:

1. there is an out of bounds write access by a miscalculated destination
   address for the memcpy()
2. if iio channels are already represented by default properties, they
   appear as duplicates in uevent


H. Nikolaus Schaller (2):
  power: generic-adc-battery: fix out-of-bounds write when copying
    channel properties
  power: generic-adc-battery: check for duplicate properties copied from
    iio channels

 drivers/power/supply/generic-adc-battery.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.12.2
