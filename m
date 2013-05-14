From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: S3, SMP non boot cpus and /sys/devices/system/cpu[1-9]/cpufreq/scaling_max_freq
Date: Tue, 14 May 2013 14:58:31 +0200
Message-ID: <2258179.54N0npf6HW@vostro.rjw.lan>
References: <65F5F98566038744B1B43C8FD3B7549F191101C4@IRSMSX104.ger.corp.intel.com> <4D68720C2E767A4AA6A8796D42C8EB59C8E7D8@BGSMSX101.gar.corp.intel.com> <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:45834 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377Ab3ENMuA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 May 2013 08:50:00 -0400
In-Reply-To: <65F5F98566038744B1B43C8FD3B7549F1911A240@IRSMSX104.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jarzmik, Robert" <robert.jarzmik@intel.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tuesday, May 14, 2013 11:54:23 AM Jarzmik, Robert wrote:
> > Okay, agreed after looking at this discussion ;) I am fine with the approach of kernel preserving permissions too.
> 
> Ok, that's great, yet I don't see a clean solution here.  This is
> the path I see and that bothers me in the S3 suspend path:
> cpufreq_sysfs_release
>   kobject_cleanup
>     kobject_release
>       kobject_put
>         __cpufreq_remove_dev
>           cpufreq_cpu_callback
>             notifier_call_chain
>               __raw_notifier_call_chain
>                 __cpu_notify
>                   _cpu_down
> 
> Here the sysfs attributes are destroyed. Cpu onlining will
> recreate them with root permissions. I don't see a good clean way
> to preserve permissions in sysfs across suspend/resume for
> deleted nodes. Do you ?

No, you can't preserve permissions for a deleted node.  [I suppose it's
generally true for all filesystems.]  You can only create a new node with the
same permissions as the old one had *or* you can avoid deleting the original
node in the first place.  Whichever is simpler to implement.

> And here we come to my actual worry : what is the technical clean
> way to solve this problem ?

Well, first, a fair question to ask is whether or not this is a real problem.
It is kind of ugly, but who honestly changes the ownership/permissions of
cpufreq directories in non-exotic usage scenarios? Is it needed for anything
actually useful?

> So far I have no idea (the cpufreq example is only a subset of
> the cases where it could happen). So if someone comes up with a
> good idea I'll volunteer to implement it :)

One can argue that we're doing too much during system suspend, because what
we really need is the _cpu_down() down the road.  That said we need to let
cpufreq (and other subsystems too) know that this CPU is gone temporarily and
it is good to have a clean state in case it doesn't come up later.

So I think that the cleanest way to address this issue would be to rearrange
the code so that the sysfs is not modified by suspend/resume at all, unless the
resume fails, but I don't think it's going to be easy to make that happen.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
