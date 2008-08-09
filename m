From: florent.chabaud@m4x.org
Subject: Re: Vulnerability in Software Suspend 2 (all versions)
Date: Sat, 9 Aug 2008 15:49:32 +0200 (CEST)
Message-ID: <tkrat.cd3adb290ff8b8ed@m4x.org>
References: <488D821D.5060603@iviztechnosolutions.com>
	<488D8449.2010006@iviztechnosolutions.com>
	<1217234901.8430.115.camel@nigel-laptop>
	<488D8853.7080907@iviztechnosolutions.com>
	<1217235481.8430.124.camel@nigel-laptop>
	<488D8A8C.7090101@iviztechnosolutions.com>
Reply-To: florent.chabaud@m4x.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <488D8A8C.7090101@iviztechnosolutions.com>
Content-Disposition: INLINE
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jonathan Brossard <jonathan@iviztechnosolutions.com>
Cc: ncunningham@users.sourceforge.net, Nigel Cunningham <ncunningham@crca.org.au>, chabaud@users.sourceforge.net, bernardb@users.sourceforge.net, seasons@users.sourceforge.net, techteam@ivizindia.com, "CERT(R) Coordination Center" <cert@cert.org>, mhfl@users.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Jonathan Brossard <jonathan@ivizindia.com>
List-Id: linux-pm@vger.kernel.org

Dear Jonathan,

Sorry for intervening so lately, but Nigel is right : those adresses are
really out of date ;-)

Le 28 jui, Jonathan Brossard a =E9crit :
> Dear Nigel,
> =

> Feel free to put me in my place if I am wrong here :
> =

> When you try to boot a tuxonice capable computer and
> restore the state of the computer using a hibernation file...
> =

> you are asked for a password, which is not the standard userland
> login prompt (for a imple reason : there is no kernel in memory at that =

> time).
> That password is part of tux on ice, right ?

AFAIK this is not part of swsusp nor tuxonice. I'm still using swsusp,
although not contributing any more, and I don't have any password to
type in my configuration.

xxd -l 32 -s 0x041e  /dev/mem
000041e: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000042e: 0000 0000 0000 0000 0000 0000 0000 0000  ................

> =

> Well, that password can be retreived from RAM !

Password retrieved from RAM is a well known issue :) From your
description, you seem to say that the kernel is not running at the time
you seize the password. This indicates for sure that tuxonice is not
involved, since it is part of kernel. The way tuxonice works is
launching the kernel as usual and interrupt normal boot as soon as
possible if a frozen image is detected. =


What you may have in your case is either a hardware password, managed by
the BIOS, or a password used to encrypt swap (and swsusp image) as
described in swsusp-dmcrypt.txt. Now, I agree with Nigel that this is
not part of swsusp, but it may be a bug in the configuration of dmcrypt.

You should also note that from a security point of view, the security
model is not at all circumvented. You need to have a root access to
/dev/mem from a resumed session, to obtain the password, and even if the
password was erased (which should be done anyway, it's a good practice)
you still have the ciphering key of the swap somewhere in memory. =


Anyway, thank you for the report. Please feel free to exchange more
information in order to identify more precisely the problem, and
specially the configuration you use.

Sincerely yours,

Florent Chabaud =


> =

> Best regards,
> =

> Jonathan-
> =

> Nigel Cunningham wrote:
>> Hi again.
>>
>> On Mon, 2008-07-28 at 14:20 +0530, Jonathan Brossard wrote:
>>   =

>>> Dear Nigel,
>>>
>>>     =

>>>> This is not a bug in TuxOnIce (or for that matter other Linux
>>>> hibernation implementations, which would have the same issue).
>>>>       =

>>> Yes it is.
>>>
>>>     =

>>>> TuxOnIce has no way to know what running applications have passwords
>>>> stored in memory or whether they are storing them in an encrypted form=
at
>>>> or not. Bugs should be filed against applications that are storing
>>>> passwords in plain text.
>>>>       =

>>> We are talking about the password of tuxonice itself here...
>>>     =

>>
>> TuxOnIce itself doesn't have any password support. Do you mean a
>> password for encrypted swap or such like?
>>
>>   =

>>> Please boot a computer using tuxonice, go for hibernation,
>>> reboot, and then type this (as root) :
>>>
>>> xxd -l 32 -s 0x041e  /dev/mem
>>>
>>>
>>>     =

>>>> By the way, these contact email addresses are grossly out of date. For
>>>> TuxOnIce, the contact is nigel@tuxonice.net. For swsusp and uswsusp
>>>> (which would have the same problem), refer to linux-pm@lists.osdl.org.
>>>>       =

>>> I did my best to find one on the site's website and ended up
>>> taking those of sourceforge.
>>>     =

>>
>> Hmm, you're right there. I'll address that shortly.
>>
>> Regards,
>>
>> Nigel
>>
>>
>>   =

> =

> =

> -- =

>     Jonathan Brossard
>     Security Research Engineer
>     iViZ Techno Solutions Pvt. Ltd.
>     Mobile: +91-9748772994
> =

>     Kolkata:
>     iViZ Technolgy Solutions(P) Ltd
>     c/o Erevmax Technologies (P) Ltd
>     DLF IT Park,
>     Tower-1, 12th Floor
>     08 Major Arterial Road
>     New Town, Rajarhat
>     Kolkata- 700 156
> =

>     Kharagpur:
>     iViZ Techno Solutions Pvt Ltd,
>     School of Information Technology,
>     Indian Institute of Technology,
>     2nd Floor, Takshashila,
>     Kharagpur 721302 West Bengal, India.
>     Phone: +91-3222-282300 ext 4324
> =

>     Web page: http://www.ivizindia.com
> =



Florent Chabaud
gpg: 28C9 9E1A 5507 5574 EDE6  2E8F 2B37 D83F 95C8 1C3C
http://www.carva.org/florent.chabaud | florent.chabaud@m4x.org
