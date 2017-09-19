From: Rajat Jain <rajatja@google.com>
Subject: Understanding suspend() vs suspend_late() for I2c devices
Date: Tue, 19 Sep 2017 10:35:18 -0700
Message-ID: <CACK8Z6EF+cHAh=7HQ2Z14wyRFTxRODYFZ-iV_MDp5=AqW=vNFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Furquan Shaikh <furquan@google.com>, Rajat Jain <rajatxjain@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello folks,

I'm trying to understand the valid expectations from i2c drivers
standpoint, from suspend() callback vs suspend_late() callback. The
Documentation/power/devices.txt states that:

==================================================
For a number of devices it is convenient to split suspend into the
"quiesce device" and "save device state" phases, in which cases
suspend_late is meant to do the latter.
==================================================

1) So it seems that it is fair expectation from a driver, to be able
to access its own device and its registers in
suspend_late()/resume_early() call backs?

2) For the drivers that provide a controller to a bus (e.g.
i2c_adapter drivers), is it correct that they should make sure that
bus operation continues to stay OK even after their suspend() callback
is executed?(This is because the drivers for the downstream devices -
eg i2c_client drivers may want to talk to their device in *their*
suspend_late() callbacks). So bus operations should be suspended by
the adapter drivers only in their suspend_late() callback routines,
and not suspend() routines?

Thanks,

Rajat
