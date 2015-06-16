From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH, DEBUG] x86/32: Add small delay after resume
Date: Tue, 16 Jun 2015 14:33:10 -0700
Message-ID: <55809616.80204@zytor.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>	 <20150612060747.GA25024@gmail.com>	 <1434125724.2353.19.camel@spandruv-DESK3.jf.intel.com>	 <20150613071547.GA27446@gmail.com> <1434384627.2353.47.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:35076 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757352AbbFPVdu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Jun 2015 17:33:50 -0400
In-Reply-To: <1434384627.2353.47.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
Cc: mingo@redhat.com, tglx@linutronix.de, pavel@ucw.cz, rjw@rjwysocki.net, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kleen, Andi" <andi.kleen@intel.com>

On 06/15/2015 09:10 AM, Srinivas Pandruvada wrote:
>>
>> So is it true that we always execute wakeup_pmode_return first after we return 
>> from the BIOS?
>>
>> If so then the BIOS touching DS cannot be an issue, as we re-initialize all 
>> segment selectors, which reloads the descriptors:
>>
>> ENTRY(wakeup_pmode_return)
>> wakeup_pmode_return:
>>         movw    $__KERNEL_DS, %ax
>>         movw    %ax, %ss
>>         movw    %ax, %ds
>>         movw    %ax, %es
>>         movw    %ax, %fs
>>         movw    %ax, %gs
>>
>>         # reload the gdt, as we need the full 32 bit address
>>         lidt    saved_idt
>>         lldt    saved_ldt
>>         ljmp    $(__KERNEL_CS), $1f
>>

Where does the GDT get initialized?

	-hpa


