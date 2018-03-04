From: Woody Suwalski <terraluna977@gmail.com>
Subject: Re: Fwd: Re: Hibernation on i386 failure...
Date: Sat, 3 Mar 2018 19:03:48 -0500
Message-ID: <f840d714-2a84-505f-35c4-3bf22c95e907@gmail.com>
References: <1cd7fdbb-3b3e-02b5-743b-2cc8c4d755b5@intel.com>
 <92900026-5110-bde7-fba2-89d545bca29a@gmail.com> <20180109223047.GA26431@amd>
 <cf0cf715-a8bb-9bc9-e308-223712498f31@gmail.com> <20180303210617.GA22392@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180303210617.GA22392@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>>> On Tue 2018-01-09 16:54:51, Woody Suwalski wrote:
>>>> Hey Pavel, so you have found that issue earlier... Do you have a patch to
>>>> try?
>>> Did I? I do not remember clearly.
>>>
>>> Anyway, here are my hibernation-related patches... Absolutely no
>>> guarantees.
>> Pavel, here is my attempt to convert your patch to 4.15 git, it builds
>> cleanly, and it does not work. If you have a moment to spare - could you
>> check if it is a classic case "everything is good, just does not
>> work"?
> Sorry for the delay.
>
> I've tested today's linux-next, and hibernation works for me, no
> patches needed.
>
> Best regards,
> 									Pavel
My January tests have showed that hibernation does work if I turn off 
the CONFIG_RELOCATABLE option.
So can you confirm that you have it enabled and it works again? I will 
try it on 4.16-rc4 tomorrow...

Thanks, Woody
