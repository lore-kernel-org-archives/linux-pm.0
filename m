From: Gleb Natapov <gleb@kernel.org>
Subject: Re: intel_pstate divide error with v3.13-rc4-256-gb7000ad
Date: Tue, 7 Jan 2014 18:11:10 +0200
Message-ID: <20140107161109.GM10961@minantech.com>
References: <CA+5PVA6YpKc6kYK5UiTnGLZpB8uts=-QPtyhotAyZ2kuoG8PPQ@mail.gmail.com>
 <4794554.Hmd2RUNYDT@vostro.rjw.lan>
 <52C18A23.10703@redhat.com>
 <3710588.K8glfx1cYs@vostro.rjw.lan>
 <52C6F3B4.3050904@gmail.com>
 <20140103180435.GK10961@minantech.com>
 <52C716C1.6070704@gmail.com>
 <52C7345D.30603@redhat.com>
 <52CAE574.3010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:63053 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaAGQLQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 11:11:16 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so302761bkz.28
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2014 08:11:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52CAE574.3010304@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kashyap Chamarthy <kchamart@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "Richard W.M. Jones" <rjones@redhat.com>

On Mon, Jan 06, 2014 at 09:18:44AM -0800, Dirk Brandewie wrote:
> On 01/03/2014 02:06 PM, Paolo Bonzini wrote:
> >Il 03/01/2014 21:00, Dirk Brandewie ha scritto:
> >>+    case MSR_IA32_MPERF:
> >>+    case MSR_IA32_APERF:
> >
> OK I will spin the patch to only add MSR_PLATFORM_INFO.
> 
> >These should never be accessed.  A KVM VM will always have
> >CPUID[06H].ECX = 0, and the Intel manual says that the MSRs are only
> >present if CPUID returns that value with bit 0 set.
> >
> >I think the actual bug is that intel_pstate_init does not check the
> >feature bits in CPUID (either manually or via x86_match_cpu).
> 
> I will add the feature check.
> 
> What are the differences between the first and the nested KVM's?
There shouldn't be any. There is a bug in nested emulation probably.

> At load time intel_pstate checks that APERF and MPERF are incrementing
> and that PLATFORM_INFO has some value.  Somehow these checks pass
> in the nested environment and we fall over when the CPU is being added
> by cpufreq.
> 
KVM does not emulate either of those and inject #GP if one is accessed. Linux
catches those #GPs and fixs up rdmsr to return zero. It would be interesting to
see ftrace for nested kvm run.

--
			Gleb.
