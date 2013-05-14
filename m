From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 13:33:01 +0200
Message-ID: <2172262.yzQn9gFeOZ@vostro.rjw.lan>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <1598695.llKRKEsWfA@vostro.rjw.lan> <4D68720C2E767A4AA6A8796D42C8EB59C8E7AD@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45702 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3ENLY1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 May 2013 07:24:27 -0400
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59C8E7AD@BGSMSX101.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, May 14, 2013 11:20:30 AM R, Durgadoss wrote:
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Tuesday, May 14, 2013 4:53 PM
> > To: Srivatsa S. Bhat
> > Cc: Viresh Kumar; Jarzmik, Robert; linux-pm@vger.kernel.org
> > Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-
> > 9]/cpufreq/scaling_max_freq
> > 
> > On Tuesday, May 14, 2013 03:57:39 PM Srivatsa S. Bhat wrote:
> > > On 05/14/2013 03:52 PM, Viresh Kumar wrote:
> > > > On 14 May 2013 15:39, Srivatsa S. Bhat
> > <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> > > >> And losing permissions isn't specific to suspend-to-ram right?
> > > >> You said that yourself, that on regular cpu online/offline you lose
> > > >> the changed permissions. So just write a resume hook to restore
> > whatever
> > > >> permissions you want after suspend-resume. See /usr/lib64/pm-
> > utils/sleep.d
> > > >> for some sample resume scripts.
> > > >
> > > > This is what i feel about losing chages on cpu hotplug/unplug:
> > > > - On normal online/offline, we aren't required to preserve earlier
> > settings.
> > >
> > > From Robert's descriptions, we _are_ required to preserve the settings.
> > But
> > > this is somewhat acceptable because the user _knows_ he is doing
> > hotplug.
> > >
> > > > - But on suspend/resume, user shouldn't know that cpus have been
> > > >   removed/added and so permissions should stay as is.
> > > >
> > >
> > > Hmm, you are right. It is wrong for us to expect the user to use custom
> > scripts
> > > to preserve permissions across S3, since he is supposed to remain ignorant
> > of
> > > CPU hotplug in this path.
> > >
> > > > What do you say?
> > > >
> > >
> > > I agree, we should try to fix it for the S3/S4 case. Robert, I'm sorry, you
> > were
> > > right - if S3 is supposed to hide CPU hotplug, it should hide it completely or
> > > not at all. And since we go with the former option, a fix for the permissions
> > > is in order, IMHO.
> > 
> > I agree.
> 
> Now that we agree on this, how should go about the fix ?
> I was debugging this to an extent, and asked a question on [1].

This wasn't the right question to ask.  We need the permissions to be preserved
by the kernel, not to be restored by user space.

Thanks,
Rafael


> Thanks,
> Durga
> [1] https://lkml.org/lkml/2013/5/13/190

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
