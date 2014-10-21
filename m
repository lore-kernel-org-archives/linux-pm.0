From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/5] cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers
Date: Tue, 21 Oct 2014 15:31:23 +0200
Message-ID: <2045399.WTWsQZusZR@vostro.rjw.lan>
References: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: stable-owner@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, October 13, 2014 08:37:40 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> Currently the core does not expose scaling_cur_freq for set_policy()
> drivers this breaks some userspace monitoring tools.
> Change the core to expose this file for all drivers and if the
> set_policy() driver supports the get() callback use it to retrieve the
> current frequency.
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=73741
> Cc: stable@vger.kernel.org
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

Whole series applied, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
