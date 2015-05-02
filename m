From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Subject: Re: [PATCH 0/1] speeding up cpu_up()
Date: Fri, 1 May 2015 19:42:52 -0500
Message-ID: <55441D8C.2080509@amd.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <20150420071556.GB14315@gmail.com>
 <CAJvTdKnYbJbun_UJXbGgKuh7DEBXoQdD6Unbm=Jopuw_C_U4ng@mail.gmail.com>
 <20150501224729.GN10239@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150501224729.GN10239@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org


On 5/1/15 5:47 PM, Borislav Petkov wrote:
> On Fri, May 01, 2015 at 02:42:39PM -0700, Len Brown wrote:
>> On Mon, Apr 20, 2015 at 12:15 AM, Ingo Molnar <mingo@kernel.org> wrote:
>>
>>> So instead of playing games with an ancient delay, I'd suggest we
>>> install the 10 msec INIT assertion wait as a platform quirk instead,
>>> and activate it for all CPUs/systems that we think might need it, with
>>> a sufficiently robust and future-proof quirk cutoff condition.
>>>
>>> New systems won't have the quirk active and thus won't have to have
>>> this delay configurable either.
>> Okay, at this time, I think the quirk would apply to:
>>
>> 1. Intel family 5 (original pentium) -- some may actually need the quirk
>> 2. Intel family F (pentium4) -- mostly b/c I don't want to bother
>> finding/testing p4
>> 3. All AMD (happy to narrow down, if somebody can speak for AMD)
> Aravind and I could probably test on a couple of AMD boxes to narrow down.
>
> @Aravind, see here:
>
> https://lkml.kernel.org/r/87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com
>
> You could ask around whether a timeout is needed between the assertion
> and deassertion of INIT done by the BSP when booting other cores.

Sure, I'll ask around and try mdelay(0) on some systems as well.
I can gather Fam15h, Fam16h but don't have K8's or older.

Will let you know how it goes.

-Aravind.

> If not, we probably should convert, at least modern AMD machines, to the
> no-delay default.
>
