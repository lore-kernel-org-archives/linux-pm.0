From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: allow powersave governor as the default without expert mode
Date: Sat, 08 Nov 2014 02:38:39 +0100
Message-ID: <1667797.SQK8nKtRUn@vostro.rjw.lan>
References: <1413322689-6195-1-git-send-email-jgeboski@gmail.com> <1463060.7rHn3OIKry@vostro.rjw.lan> <545328ED.20900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56882 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752442AbaKHBRu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 20:17:50 -0500
In-Reply-To: <545328ED.20900@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: James Geboski <jgeboski@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, October 30, 2014 11:15:09 PM Dirk Brandewie wrote:
> On 10/30/2014 02:18 PM, Rafael J. Wysocki wrote:
> > On Thursday, October 16, 2014 07:37:11 AM James Geboski wrote:
> >> The intel_pstate driver only supports the performance and the powersave
> >> governors. With the performance governor ensuring the highest possible
> >> performance settings, userspace tools fail to make any lasting changes.
> >> In order to allow userspace tools to make modifications to the settings,
> >> the powersave governor must be in use. This makes having the powersave
> >> governor as the default convenient for systems where the intel_pstate
> >> driver is being employed. Having to enable expert mode in the kernel
> >> configuration is just a headache for such a trivial task.
> >>
> >> This patch applies to all kernel versions 2.6.38 or greater after the
> >> migration from CONFIG_EMBEDDED to CONFIG_EXPERT (6a108a14fa35). Most
> >> importantly, this applies to kernel versions 3.9 or greater when the
> >> intel_pstate driver was introduced.
> >>
> >> Signed-off-by: James Geboski <jgeboski@gmail.com>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Dirk, any objections?
> 
> No objection.

OK, patch queued up for 3.19-rc1, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
