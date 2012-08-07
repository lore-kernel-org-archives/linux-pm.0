From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [linux-pm] [PATCH] ACPI: replace strlen("string") with sizeof("string")
 -1
Date: Tue, 07 Aug 2012 05:07:06 +0400
Message-ID: <50206A3A.8020706@pavlinux.ru>
References: <Pine.LNX.4.44L0.1208061556010.1649-100000@iolanthe.rowland.org>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1208061556010.1649-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

06.08.2012 23:59, Alan Stern =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Mon, 6 Aug 2012, Pavel Vasilyev wrote:
>
>>>> http://www.gossamer-threads.com/lists/engine?do=3Dpost_attachment;=
postatt_id=3D41157;list=3Dlinux
>>>
>>> Interestingly, many (all?) of the changes in that patch are wrong
>>> because they don't try to match the terminating '\0'.  As a result,
>>> they will match against extensions of the target string as well as =
the
>>> target string itself.
>>>
>>
>> strNcmp compare N bytes - http://lxr.linux.no/#linux+v3.5/lib/string=
=2Ec#L270
>> memcmp compare N bytes  - http://lxr.linux.no/#linux+v3.5/lib/string=
=2Ec#L651
>
> Yes.  So if s contains "abcde" then
>
> 	memcmp(s, "abc", 3) and strncmp(s, "abc", 3) will both return 0, and
> 	memcmp(s, "abc", 4) and strncmp(s, "abc", 4) will both return 1.

No matter what is contained in *s, "abcde" or "abcxxx",
are important first N bytes. The second example, you see,
a little bit stupid, and devoid of logic. :)


--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
