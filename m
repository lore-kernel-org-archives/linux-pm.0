From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH, DEBUG] x86/32: Add small delay after resume
Date: Wed, 17 Jun 2015 10:22:49 -0700
Message-ID: <5581ACE9.1010005@zytor.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20150612060747.GA25024@gmail.com> <1434125724.2353.19.camel@spandruv-DESK3.jf.intel.com> <20150613071547.GA27446@gmail.com> <1434384627.2353.47.camel@spandruv-DESK3.jf.intel.com> <55809616.80204@zytor.com> <20150617163350.GA7250@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47970 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757560AbbFQRXe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Jun 2015 13:23:34 -0400
In-Reply-To: <20150617163350.GA7250@l.oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, mingo@redhat.com, tglx@linutronix.de, pavel@ucw.cz, rjw@rjwysocki.net, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kleen, Andi" <andi.kleen@intel.com>

On 06/17/2015 09:33 AM, Konrad Rzeszutek Wilk wrote:
>>>>
>>
>> Where does the GDT get initialized?
>>
>> 	-hpa
> 
> mit 84e70971e67d97bc2db18a4e76d42846272a54bd
> Author: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Date:   Fri Apr 5 16:42:22 2013 -0400
> 
>     x86-32, gdt: Store/load GDT for ACPI S3 or hibernation/resume path is not needed
> 

Store, no.  LOAD?

	-hpa


