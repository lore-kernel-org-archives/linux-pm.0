From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] idle, Honor Hardware Disabled States
Date: Thu, 24 Mar 2016 17:54:05 -0400
Message-ID: <CAJvTdKmi2pfE+fn5-MVd8T5_0j+EbASJ992AYmVKG2osk762yQ@mail.gmail.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>
	<CAJvTdKk0qsFsN7RPQGVQ7mWbd2N9jW7kZbH4htSnMBxvwo8M2w@mail.gmail.com>
	<56F32BDB.1010107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33679 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcCXVyI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 17:54:08 -0400
In-Reply-To: <56F32BDB.1010107@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, Mar 23, 2016 at 7:50 PM, Prarit Bhargava <prarit@redhat.com> wrote:
>
>
> On 03/23/2016 04:05 PM, Len Brown wrote:
>> This patch assumes that if a package state is disabled,
>> the corresponding core state must be disabled.
>> That assumption is false.
>> Indeed, that is a very popular and useful configuration.
>>
>> But even if that were not the case, this software is not necessary,
>> since the hardware handles demotion "c-state clipping" automatically.
>>
>> Yes, there is a case where a certain version of a certain processor
>> has broken demotion, but this isn't the right fix for that.
>> The right fix for that is here:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=109081
>
> Len, should I rebase on top of this?  Would that work for you?


I guess I wasn't clear.
I don't see the benefit of your patch.
Please explain it to me.

thanks,
-Len
