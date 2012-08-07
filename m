From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [linux-pm] [PATCH] ACPI: replace strlen("string") with sizeof("string")
 -1
Date: Wed, 08 Aug 2012 03:23:30 +0400
Message-ID: <5021A372.8030409@pavlinux.ru>
References: <Pine.LNX.4.44L0.1208071322070.2400-100000@iolanthe.rowland.org>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1208071322070.2400-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

07.08.2012 21:24, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Tue, 7 Aug 2012, Pavel Vasilyev wrote:
>
>> 06.08.2012 23:59, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Mon, 6 Aug 2012, Pavel Vasilyev wrote:
>>>
>>>>>> http://www.gossamer-threads.com/lists/engine?do=3Dpost_attachmen=
t;postatt_id=3D41157;list=3Dlinux
>>>>>
>>>>> Interestingly, many (all?) of the changes in that patch are wrong
>>>>> because they don't try to match the terminating '\0'.  As a resul=
t,
>>>>> they will match against extensions of the target string as well a=
s the
>>>>> target string itself.
>>>>>
>>>>
>>>> strNcmp compare N bytes - http://lxr.linux.no/#linux+v3.5/lib/stri=
ng.c#L270
>>>> memcmp compare N bytes  - http://lxr.linux.no/#linux+v3.5/lib/stri=
ng.c#L651
>>>
>>> Yes.  So if s contains "abcde" then
>>>
>>> 	memcmp(s, "abc", 3) and strncmp(s, "abc", 3) will both return 0, a=
nd
>>> 	memcmp(s, "abc", 4) and strncmp(s, "abc", 4) will both return 1.
>>
>> No matter what is contained in *s, "abcde" or "abcxxx",
>> are important first N bytes. The second example, you see,
>> a little bit stupid, and devoid of logic. :)
>
> Maybe yes, maybe no.  It all depends on what you want.
>
> For example, if you're looking for "on" or "off", what should you do
> when the user writes "onoff"?  You could accept it as meaning the sam=
e
> as "on", but if you were being careful then you would want to reject =
it
> as a meaningless value.


The users should't be allowed to think!
There is "on" - the size of 2 bytes, or "off" - 3 bytes,
other variations - user error.

We do not create a kernel with artificial intelligence? ;)

--=20
                                                          Pavel.
