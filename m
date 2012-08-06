From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [linux-pm] [PATCH] ACPI: replace strlen("string") with sizeof("string")
 -1
Date: Mon, 06 Aug 2012 22:47:50 +0400
Message-ID: <50201156.30704@pavlinux.ru>
References: <Pine.LNX.4.44L0.1208061226460.1649-100000@iolanthe.rowland.org>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1208061226460.1649-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

06.08.2012 20:28, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, 6 Aug 2012, Pavel Vasilyev wrote:
>
>> 06.08.2012 18:36, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Mon, 6 Aug 2012, Pavel Machek wrote:
>>>
>>>> On Thu 2012-07-26 21:39:38, Len Brown wrote:
>>>>> ...both give the number of chars in the string
>>>>> without the '\0', as strncmp() wants,
>>>>> but sizeof() is compile-time.
>>>>
>>>> What about introducing something like streq() to do this
>>>> automatically? This is ugly....
>>>>
>>>> #define streq(a, b) ... if (_buildin_constant(b)) ...
>>>>
>>>> ?
>>>>
>>>>> -	if (!strncmp(val, "enable", strlen("enable"))) {
>>>>> +	if (!strncmp(val, "enable", sizeof("enable") - 1)) {
>>>
>>> While you're at it, there's no point using strncmp when you know th=
e
>>> length of one of the strings beforehand.  Just use memcmp, and don'=
t
>>> subtract 1 from the sizeof value.
>>
>> http://www.gossamer-threads.com/lists/engine?do=3Dpost_attachment;po=
statt_id=3D41157;list=3Dlinux
>
> Interestingly, many (all?) of the changes in that patch are wrong
> because they don't try to match the terminating '\0'.  As a result,
> they will match against extensions of the target string as well as th=
e
> target string itself.
>

strNcmp compare N bytes - http://lxr.linux.no/#linux+v3.5/lib/string.c#=
L270
memcmp compare N bytes  - http://lxr.linux.no/#linux+v3.5/lib/string.c#=
L651

--=20

                                                          Pavel.
