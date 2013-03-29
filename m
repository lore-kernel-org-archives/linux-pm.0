From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 0/3] Thermal: build all thermal framework code into thermal_sys module
Date: Fri, 29 Mar 2013 22:26:33 +0800
Message-ID: <1364567196-3560-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: amit.daniel@samsung.com, durgadoss.r@intel.com, andi@lisas.de, eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

A regression introduced by thermal governor feature
is reported in http://marc.info/?l=linux-kernel&m=136085598604095&w=2

And the root cause is that all the thermal governors can not be registered
successfully when the thermal framework is built as a module.

Thus I made this patch set to build all the thermal framework component,
including governors and cpu_cooling feature into one module so that all the
thermal features are loaded/unloaded altogether.

any comments?

thanks,
rui
