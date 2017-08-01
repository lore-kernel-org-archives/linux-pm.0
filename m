From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [RFC PATCH 0/5] Add formula for LiIon batteries to compute capacity
Date: Tue,  1 Aug 2017 22:55:21 +0200
Message-ID: <1501620926-22669-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35088 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdHAUza (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 16:55:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com, pavel@ucw.cz, Marek Belisko <marek.belisko@open-nandra.com>

This patches sitting in my repo for long time and would like to get feedback first before
submitting final series. This patches adding devicetree to generic-adc-battery driver
(we reuse it for gta04 board then and drop twl4030_madc_battery). Also add formula
for computing capacity of LiIon battery. This patches was tested on gta04 and
works fine. Thanks for comments.

Marek Belisko (5):
  dt-bindings: power: Add battery types
  power: generic-adc-battery: Parse more properties from DT
  power/generic-adc-battery: Add support for temperature and add check
    for charge from iio current channel
  power: Add formula for computing LiIon State of Charge from Voltage
  power: generic-adc-battery: Add capacity handling

 drivers/power/supply/generic-adc-battery.c | 100 ++++++++++++++++++++++++++++-
 include/dt-bindings/power/power.h          |  11 ++++
 include/linux/power/generic-fuel-gauge.h   |  38 +++++++++++
 3 files changed, 146 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/power/power.h
 create mode 100644 include/linux/power/generic-fuel-gauge.h

-- 
2.7.4
