From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] powercap/rapl: Do not load in virtualized environments
Date: Thu, 19 May 2016 01:06:53 +0200
Message-ID: <CAJZ5v0i2h=WtdfRTmTDkLcpp3p9sqBBfO72dVCFb7EfECUQh8w@mail.gmail.com>
References: <1463484845-9839-1-git-send-email-prarit@redhat.com>
	<CAJZ5v0g59CvQVePgCbEsXvw5UqOcqvn-Snh3=0Jcnj=mhT_mfg@mail.gmail.com>
	<573C6247.3000605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33255 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcERXGz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 19:06:55 -0400
In-Reply-To: <573C6247.3000605@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, May 18, 2016 at 2:38 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>
>
> On 05/17/2016 08:50 PM, Rafael J. Wysocki wrote:
>> On Tue, May 17, 2016 at 1:34 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>>> intel_rapl is currently not supported in virtualized environments.  When
>>> booting the warning message
>>>
>>> intel_rapl: no valid rapl domains found in package 0
>>
>> You seem to be saying that this message is problematic for some
>> reason, so why is it?
>>
>
> I thought about my previous answer and after thinking about it realized I didn't
> give you enough background Rafael.  Virtual environments won't use this feature
> as this is meant for restricting power consumption at the HW level.
>
> So ... here's the situation.  Most CPU features from Intel have a CPU feature
> bit (also known in some circles as cpuflags) set for them.  For example MCE has
> an mce bit that is exposed in /proc/cpuinfo.  Unfortunately, for Intel RAPL
> there is no bit (I don't know if someone dropped the ball or if Intel
> intentionally left this feature off ... I've heard both explanations :)).
>
> In any case the Intel RAPL driver is one of the few cpu based drivers in the
> kernel that still does a x86_match_cpu() against supported CPUs.  This means for
> virtual cpus which export the host cpu's cpu model number, the intel_rapl driver
> will attempt to load for each cpu.
>
> As a result the message
>
> intel_rapl: no valid rapl domains found in package 0
>
> is output as a *visible* error to the user for each virtual core.
>
> The error is valid for native cpus (although over 100s of systems I can say I've
> never seen the warning output on a native cpu) but it is clearly not valid for
> virtual cpus *because virtualized systems don't use this feature*.
>
> The driver shouldn't load on virt systems.  That's the bottom line here, and the
> patch prevents that from happening.  Would I prefer that there were some other
> mechanism to detect RAPL?  Yep.  I really really would.  But beyond mucking with
> MSRs (which is definitely more complicated and awful than this simple check) I
> don't see any easier method than the one I've proposed.
>
> I really don't want to be the one who sets the precedent of abusing x86_hyper in
> this way.  I know it isn't the "right" thing to do -- but I honestly do not see
> a better or cleaner way out of this.

One quite obvious alternative might be to reduce the log level of the
message in question, say to pr_debug.
