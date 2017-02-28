From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 0/3] cpufreq: intel_pstate: Fixes related to limis
Date: Wed, 01 Mar 2017 00:00:05 +0100
Message-ID: <2326598.n0dkg1GrdM@aspire.rjw.lan>
References: <2694426.SgxlQuL17D@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2694426.SgxlQuL17D@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, February 28, 2017 02:13:30 PM Rafael J. Wysocki wrote:
> Hi,
> 
> Both fix some utter confusion in the sysfs interface.
> 
> The first one makes intel_pstate_update_policies() end up with limits set to
> the same value that it was set to initially.
> 
> The second one avoids reinitializing limits in intel_pstate_set_policy() when
> the moon phase is right and the wind blows from a specific direction.

Resending an updated series, because patch [1/3] required a rework and I found
one more problem (addressed by patch [3/3]).

Thanks,
Rafael
