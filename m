From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH] x86, suspend: Save/restore THERM_CONTROL register for
 suspend
Date: Tue, 18 Aug 2015 10:02:38 +0800
Message-ID: <55D2923E.7030202@intel.com>
References: <1439800192-3034-1-git-send-email-yu.c.chen@intel.com> <20150817101115.GA27204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40641 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbHRB7N (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 21:59:13 -0400
In-Reply-To: <20150817101115.GA27204@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rui.zhang@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

=EF=BC=88not sure if previous reply has been sent out)
Hi, Ingo, thanks for your review,
On 08/17/2015 06:11 PM, Ingo Molnar wrote:
>
> * Chen Yu <yu.c.chen@intel.com> wrote:
>
>
> So what your changelog fails to mention:
>
>   - You only add this code to the 64-bit kernel. Are 32-bit kernels n=
ot affected?
>
I missed the 32-bit case, I'll adjust them to 32/64-bit common path.
>   - the MSR read is done unconditionally. Is MSR_IA32_THERM_CONTROL a=
vailable
>     architecturally and readable (and has sensible values) on all 64-=
bit capable
>     x86 CPUs that run this code path?
>
MSR_IA32_THERM_CONTROL is avaliable on Intel Pentium 4, Xeon, Pentium M
and later processors, so I think not all of the 32/64-bit x86 CPUs have
this regiser. Maybe codes like this would be more reasonable?
save:
ctx->clock_modulation_saved =3D !rdmsrl_safe(MSR_IA32_THERM_CONTROL,
	&ctxt->clock_modulation);
retore:
if (ctxt->clock_modulation_saved)
	wrmsrl(MSR_IA32_THERM_CONTROL, ctxt->clock_modulation);


Best Regards,
Yu
> Thanks,
>
> 	Ingo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

