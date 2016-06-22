From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86: fix rdmsr MSR_PLATFORM_INFO unsafe warning in kvm
 guest
Date: Wed, 22 Jun 2016 19:43:15 +0200
Message-ID: <aab33eba-e2d7-ff60-6a63-abee2a47cac8@redhat.com>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32907 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcFVRnU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2016 13:43:20 -0400
In-Reply-To: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, lkp@01.org, x86@kernel.org
Cc: Wanpeng Li <wanpeng.li@hotmail.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Chen Yu <y.c.chen@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, jacob.jun.pan@intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>



On 22/06/2016 03:28, Wanpeng Li wrote:
>  
>  get_ratio:
> -	rdmsr(MSR_PLATFORM_INFO, lo, hi);
> -	ratio = (lo >> 8) & 0xff;
> +	if (!rdmsr_safe(MSR_PLATFORM_INFO, &lo, &hi))
> +		ratio = (lo >> 8) & 0xff;

This looks good, thanks.

Paolo
