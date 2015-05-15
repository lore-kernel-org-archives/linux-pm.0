From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] PM: Avoid building suspend-to-idle code when it is not necessary
Date: Sat, 16 May 2015 01:37:15 +0200
Message-ID: <7138791.PFSSF2gqXk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

As per the subject.  Suspend-to-idle code is only used for CONFIG_SUSPEND set
and it should not be built otherwise.

Thanks!
