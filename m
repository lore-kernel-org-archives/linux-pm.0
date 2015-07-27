From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/7] cpufreq: Better separation of device addition/removal and online/offline paths
Date: Mon, 27 Jul 2015 16:01:12 +0200
Message-ID: <3874727.Jpay9zgokc@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7868353.pEStq1MJ2a@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, July 23, 2015 02:00:23 AM Rafael J. Wysocki wrote:
> Hi,
> 
> As per the recent discussion (http://marc.info/?l=linux-pm&m=143758336123670&w=4),
> separete CPU device addition/removal code paths from the CPU online/offline code
> paths in the cpufreq core a bit better.

A new version of this, with more cleanups included, on top of the linux-next
branch of the linux-pm.git tree (from today).

Thanks,
Rafael
