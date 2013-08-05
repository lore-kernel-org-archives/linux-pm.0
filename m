From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: sysfs support for scaling_cur_freq in intel_pstate
Date: Tue, 06 Aug 2013 00:25:19 +0200
Message-ID: <12076019.aizTGtbSrF@vostro.rjw.lan>
References: <1375738663.6273.56.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57129 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280Ab3HEWPH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 Aug 2013 18:15:07 -0400
In-Reply-To: <1375738663.6273.56.camel@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Radu Rendec <radu.rendec@mindbit.ro>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>

[Adding CCs to linux-pm and Dirk.]

On Tuesday, August 06, 2013 12:37:43 AM Radu Rendec wrote:
> Hi!
> 
> After a recent kernel upgrade on my laptop I noticed that my cpu
> frequency desktop applet wasn't working anymore. I quickly tracked down
> the problem to the fact that the new scaling driver was intel_pstate,
> and it didn't expose scaling_cur_freq in sysfs.
> 
> On the other hand, cpuinfo_cur_freq is available, but it's only readable
> by root. Apparently there are good reasons for keeping it like this. I
> found an older post about this here:
> http://comments.gmane.org/gmane.linux.kernel.cpufreq/7005
> 
> However, looking at the code in intel_pstate.c, it seems that
> intel_pstate_get() (which is the implementation for cpuinfo_cur_freq in
> sysfs) simply extracts a value out of a larger structure. This seems
> really harmless and very far away from the reasons why cpuinfo_cur_freq
> was kept readable by root only.
> 
> Looking at cpufreq_add_dev_interface() in cpufreq.c, it seems that one
> needs to define the "target" field in struct cpufreq_driver in order to
> have scaling_cur_freq exposed in sysfs.
> 
> I think setting "target" to intel_pstate_get() in the definition of
> intel_pstate_driver would fix my problem, since scaling_cur_freq in
> sysfs is world readable. Is there any reason for not doing this?
> 
> If you reply, please cc my personal address - I'm not subscribed to the
> list.
> 
> Thanks,
> 
> Radu Rendec
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
