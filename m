From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Mon, 06 Jan 2014 12:20:32 +0100
Message-ID: <52CA9180.1020106@redhat.com>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com> <52C84733.1090507@redhat.com> <20140104174813.GL10961@minantech.com> <4410803.FiVxaMNxvJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:61308 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbaAFLUg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2014 06:20:36 -0500
In-Reply-To: <4410803.FiVxaMNxvJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Gleb Natapov <gleb@minantech.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, Kashyap Chamarthy <kchamart@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "Richard W.M. Jones" <rjones@redhat.com>

Il 04/01/2014 22:38, Rafael J. Wysocki ha scritto:
> On Saturday, January 04, 2014 07:48:13 PM Gleb Natapov wrote:
>> On Sat, Jan 04, 2014 at 06:38:59PM +0100, Paolo Bonzini wrote:
>>> Il 04/01/2014 15:38, Rafael J. Wysocki ha scritto:
>>>> Well, it's just a sanity check and it makes the problem go away for the reporter.
>>>>
>>>>>> Your patch is welcome but perhaps it should have a WARN_ON too.
>>>> It has been pulled in already, so the WARN_ON() can only be added via a separate
>>>> patch now.  Would you like to prepare that patch?
>>>
>>> Yes, I'll add it together with the CPUID check.  I'll send the patch so
>>> that it can get into 3.14.
>>>
>> CPUID check, while correct, will sweep the problem under the rug. Current
>> Linux logic should detect non working pstate in KVM. We should look into
>> why this is not happening for nested.
> 
> I agree.  It's better not to use CPUID for that in my opinion.

Among hypervisors, RHEL5's Xen is probably one of the oldest in actual
use with new hardware and new kernels, and the CPUID bit has been fixed
in 2011.  Older versions wouldn't run new kernels due to other CPUID
bits not being cleared properly in VMs.

Is there real hardware that has the CPUID bit set and non-working
pstate?  If there's no such real hardware, CPUID is what the SDM says
you should use to detect presence of the APERF/MPERF msrs.

Having extra safety checks is fine on top of what the SDM says, but IMO
they should be WARN_ONs.  Otherwise you are sweeping bugs under the rug
just as much.

Paolo
