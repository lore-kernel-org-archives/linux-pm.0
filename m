From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: make Intel/AMD MSR access, io port access static
Date: Wed, 23 Mar 2016 22:25:06 +0100
Message-ID: <22473178.Kee3EMUSMB@vostro.rjw.lan>
References: <1458657270-2440-1-git-send-email-jszhang@marvell.com> <20160322144353.GN5272@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60679 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756756AbcCWVWz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2016 17:22:55 -0400
In-Reply-To: <20160322144353.GN5272@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Jisheng Zhang <jszhang@marvell.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, March 22, 2016 08:13:53 PM Viresh Kumar wrote:
> On 22-03-16, 22:34, Jisheng Zhang wrote:
> > These frequency register read/write operations' implementations for the
> > given processor (Intel/AMD MSR access or I/O port access) are only used
> > internally in acpi-cpufreq, so make them static.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

