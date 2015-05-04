From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Subject: Re: [PATCH 0/1] speeding up cpu_up()
Date: Mon, 4 May 2015 17:45:17 -0500
Message-ID: <5547F67D.2080307@amd.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <20150420071556.GB14315@gmail.com>
 <CAJvTdKnYbJbun_UJXbGgKuh7DEBXoQdD6Unbm=Jopuw_C_U4ng@mail.gmail.com>
 <20150501224729.GN10239@pd.tnic> <55441D8C.2080509@amd.com>
 <55464925.5050600@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0116.outbound.protection.outlook.com ([157.56.111.116]:12288
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750887AbbEDWpY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 May 2015 18:45:24 -0400
In-Reply-To: <55464925.5050600@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On 5/3/2015 11:13 AM, Aravind Gopalakrishnan wrote:
>
> On 5/1/15 7:42 PM, Aravind Gopalakrishnan wrote:
>>
>> On 5/1/15 5:47 PM, Borislav Petkov wrote:
>>> Aravind and I could probably test on a couple of AMD boxes to narrow 
>>> down.
>>>
>>> @Aravind, see here:
>>>
>>> https://lkml.kernel.org/r/87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com 
>>>
>>>
>>> You could ask around whether a timeout is needed between the assertion
>>> and deassertion of INIT done by the BSP when booting other cores.
>>
>> Sure, I'll ask around and try mdelay(0) on some systems as well.
>> I can gather Fam15h, Fam16h but don't have K8's or older.
>>
>> Will let you know how it goes.
> Update:
> Fam15h Model00h-0fh, Fam15hModel60h and Fam16h Model 00h-0fh 
> processors boot fine with mdelay(0) and BSP brings up all secondary 
> cpus correctly. I don't have Fam15hModel30h system currently up, but 
> I'll try that too tomorrow.
>
> I am yet to get feedback from HW folks regarding this though.

Tested a delay of 0 on Fam10h and Fam15h Model 30h-3fh and both work fine.

Feedback from asking internally about this is that we should be OK to 
move to a no-delay default from K8 onwards.

Thanks,
-Aravind.
