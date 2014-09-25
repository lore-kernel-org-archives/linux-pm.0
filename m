From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: powernv: Set the cpus to nominal frequency during reboot/kexec
Date: Fri, 26 Sep 2014 01:52:09 +0200
Message-ID: <4913652.kENFQcqa9E@vostro.rjw.lan>
References: <1410430423-1246-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <CAKohpo=uB252XLfx3tHPA8uk5RPkWB0SPQ_UxzVw70c-DWuHWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52013 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751875AbaIYXcT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 19:32:19 -0400
In-Reply-To: <CAKohpo=uB252XLfx3tHPA8uk5RPkWB0SPQ_UxzVw70c-DWuHWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, David Laight <David.Laight@aculab.com>

On Thursday, September 11, 2014 05:03:22 PM Viresh Kumar wrote:
> On 11 September 2014 15:43, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
> > This patch ensures the cpus to kexec/reboot at nominal frequency.
> > Nominal frequency is the highest cpu frequency on PowerPC at
> > which the cores can run without getting throttled.
> >
> > If the host kernel had set the cpus to a low pstate and then it
> > kexecs/reboots to a cpufreq disabled kernel it would cause the target
> > kernel to perform poorly. It will also increase the boot up time of
> > the target kernel. So set the cpus to high pstate, in this case to
> > nominal frequency before rebooting to avoid such scenarios.
> >
> > The reboot notifier will set the cpus to nominal frequncy.
> >
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> > ---
> > Changes v2->v3:
> > We return EBUSY when cpufreq governor tries to change the frequency
> > after rebooting is set to true. This results in console being flushed
> > with error messages indicating failed attempts to change the
> > frequency. So instead of returning EBUSY we return 0 to stop the
> > governor from changing the frequency without alerting a failure to
> > do the same on reboot, as this  is not an errorneaos condition.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
