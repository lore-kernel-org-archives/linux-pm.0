From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date: Tue, 02 Oct 2018 23:41:00 +0200
Message-ID: <3510260.hvypppS8Bs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi All,

This series fixes a couple of issues with the menu governor, optimizes it
somewhat and makes a couple of cleanups in it.  Please refer to the
patch changelogs for details.

All of the changes in the series are straightforward in my view.  The
first two patches are fixes, the rest is optimizations and cleanups.

Thanks,
Rafael
