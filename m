From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: Better separation of device addition/removal and online/offline paths
Date: Thu, 23 Jul 2015 02:00:23 +0200
Message-ID: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi,

As per the recent discussion (http://marc.info/?l=linux-pm&m=143758336123670&w=4),
separete CPU device addition/removal code paths from the CPU online/offline code
paths in the cpufreq core a bit better.

Both on top of http://marc.info/?l=linux-pm&m=143760250929586&w=4.

Thanks,
Rafael
