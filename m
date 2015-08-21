From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Fri, 21 Aug 2015 16:24:44 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB0067B@SHSMSX101.ccr.corp.intel.com>
References: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
 <55D71ADD.2000601@nigelcunningham.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27332 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbbHUQY4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2015 12:24:56 -0400
In-Reply-To: <55D71ADD.2000601@nigelcunningham.com.au>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nigel Cunningham <nigel@nigelcunningham.com.au>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Nigel

> -----Original Message-----
> From: Nigel Cunningham [mailto:nigel@nigelcunningham.com.au]
> Sent: Friday, August 21, 2015 8:35 PM
> To: Chen, Yu C; rjw@rjwysocki.net; pavel@ucw.cz; tglx@linutronix.de;
> mingo@redhat.com; hpa@zytor.com
> Cc: Zhang, Rui; lenb@kernel.org; x86@kernel.org; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for
> suspend
> 
> Hi Chen.
> 
> Is there any issue with saving and restoring MSRs unconditionally? That
> would simplify the patch and make things 'just work'.
Saving/restoring unconditionally might take BIOS legal action into account,
for example, BIOS itself is willing to modify the MSR.  And Pavel suggests
using quirk to workaround in V1 patch:
https://patchwork.kernel.org/patch/7023891/

So I'm considering a common framework to save/restore these MSRs,
because user might need to protect more than one MSR during 
suspend, so..

I can modify this patch to a simpler version, for example,
Introducing two variables in struct saved_context , like
MSR_IA32_MISC_ENABLE does.

Thanks for your review

Best Regards,
Yu
> 
> Regards,
> 
> Nigel
