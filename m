From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 13:22:33 +0200
Message-ID: <1598695.llKRKEsWfA@vostro.rjw.lan>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <CAKohponfQ11Ak9Q-HmSK83g1XB5_KF0UDHaSQh_jiEZBNtSUMw@mail.gmail.com> <5192119B.4020009@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45675 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab3ENLOF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 May 2013 07:14:05 -0400
In-Reply-To: <5192119B.4020009@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, May 14, 2013 03:57:39 PM Srivatsa S. Bhat wrote:
> On 05/14/2013 03:52 PM, Viresh Kumar wrote:
> > On 14 May 2013 15:39, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> >> And losing permissions isn't specific to suspend-to-ram right?
> >> You said that yourself, that on regular cpu online/offline you lose
> >> the changed permissions. So just write a resume hook to restore whatever
> >> permissions you want after suspend-resume. See /usr/lib64/pm-utils/sleep.d
> >> for some sample resume scripts.
> > 
> > This is what i feel about losing chages on cpu hotplug/unplug:
> > - On normal online/offline, we aren't required to preserve earlier settings.
> 
> From Robert's descriptions, we _are_ required to preserve the settings. But
> this is somewhat acceptable because the user _knows_ he is doing hotplug.
> 
> > - But on suspend/resume, user shouldn't know that cpus have been
> >   removed/added and so permissions should stay as is.
> >
> 
> Hmm, you are right. It is wrong for us to expect the user to use custom scripts
> to preserve permissions across S3, since he is supposed to remain ignorant of
> CPU hotplug in this path.
> 
> > What do you say?
> > 
> 
> I agree, we should try to fix it for the S3/S4 case. Robert, I'm sorry, you were
> right - if S3 is supposed to hide CPU hotplug, it should hide it completely or
> not at all. And since we go with the former option, a fix for the permissions
> is in order, IMHO.

I agree.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
