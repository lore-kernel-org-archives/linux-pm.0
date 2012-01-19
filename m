From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] input: CPU frequency booster
Date: Fri, 20 Jan 2012 00:10:17 +0100
Message-ID: <201201200010.18680.trenn@suse.de>
References: <1326977615-4387-1-git-send-email-amiettinen@nvidia.com> <201201192353.00761.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <201201192353.00761.trenn@suse.de>
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 19 January 2012 23:52:59 Thomas Renninger wrote:
> Hi,
...
> I'd also put this into drivers/cpufreq/cpufreq_input_boost.c.
> 
> Find below a re-written version of the booster.
> Instead of pm_qos, it simply uses cpufreq interface:
> /sys/devices/system/cpu/cpufreq/input_boost_freq
> /sys/devices/system/cpu/cpufreq/input_boost_time

There was the same problem that scaling_max_freq showed a limit,
but one did not know whether it comes from:
  - thermal
  - PPC/BIOS
restrictions.

This got solved by introducing:
/sys/.../cpuX/cpufreq/bios_limit
which shows the PPC limitation

A file:
/sys/.../cpuX/cpufreq/input_boost_limit
could show the currently raised min_freq, caused by
the input booster.

    Thomas
