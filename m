From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 0/2] PM / sleep: Make it possible to check if suspend/resume goes via firmware
Date: Wed, 30 Sep 2015 02:46:10 +0200
Message-ID: <10641052.oOBhM6BU9G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

Patch [1/2] introduces a new mechanism that can be used to check whether or not
platform firmware is going to be involved in system suspend or was involved
in system resume.

Patch [2/2] modifies the PM core to use the mechanism added by [1/2].

Comments welcome.

Thanks,
Rafael

