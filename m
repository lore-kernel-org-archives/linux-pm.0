From: "Rodolfo (kix)" <kix@kix.es>
Subject: Re: [Suspend-devel] Help
Date: Tue, 29 Sep 2009 00:13:33 +0200
Message-ID: <3096bd910909281513h134e505cy6631f998cd1cba5b__4881.6927861937$1254176242$gmane$org@mail.gmail.com>
References: <E1McOLX-0003Lq-BN@665xhf1.ch3.sourceforge.com>
	<200909240028.03305.rjw@sisk.pl>
	<20090924145128.26e758df@strolchi.home.s3e.de>
	<200909241953.46519.rjw@sisk.pl>
	<5B7CD99A-A3B3-44EC-A073-31C0A5B7286B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5B7CD99A-A3B3-44EC-A073-31C0A5B7286B@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: suspend-devel List <suspend-devel@lists.sourceforge.net>, kix <kixdotes@users.sourceforge.net>, "Rodolfo (kix)" <kix@kix.es>, pm list <linux-pm@lists.linux-foundation.org>, Stefan Seyfried <stefan.seyfried@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Hi!!

1. A new database file, comma separated, has been created (it was
terrible, I am very tired)
2. A little script to search in the database (using the "match"
function) is implemented
3. Other script to convert the database file to whitelist.c has been
created too.

The scripts has been created using perl. Why? because is fast, good
and is only for the database maintaning, not for the code
distribution.

Please, test it, the code is in http://www.kix.es/20090929/

Any comments are welcome.

-kix-

On Thu, Sep 24, 2009 at 8:20 PM, Kix <rodolfogarciap@gmail.com> wrote:
> Ok, I will write some lines to manage the whitelist. I will use your
> comments :-)
>
> Thanks!
>
>
>
> El 24/09/2009, a las 19:53, "Rafael J. Wysocki" <rjw@sisk.pl> escribi=F3:
>
>> On Thursday 24 September 2009, Stefan Seyfried wrote:
>>>
>>> On Thu, 24 Sep 2009 00:28:03 +0200
>>> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>>>
>>>> On Wednesday 23 September 2009, Rodolfo (kix) wrote:
>>>>>
>>>>> Hi Rafael,
>>>>
>>>> Hi,
>>>>
>>>>> I am thinking about the maintaining ...
>>>
>>> Good luck! I know that you'll need it ;)
>>>
>>> Let me throw my 2 cents into the bowl.
>>>
>>>>> 1. The users sends the hardware info to be added to the database
>>>>> (now by mail). Then:
>>>>>
>>>>> 1. Probably we need a little script (or web script? or post directly
>>>>> form the s2ram -i?):
>>>>> =A01.a The script checks if the machine is previously added to the
>>>>> database (in a text file). Probably this script can read from the
>>>>> mailing list format
>>>>>
>>>>> xxxx:% sudo /root/s2ram -i
>>>>> This machine can be identified by:
>>>>> =A0 sys_vendor =A0 =3D "TOSHIBA"
>>>>> =A0 sys_product =A0=3D "Satellite U305"
>>>>> =A0 sys_version =A0=3D "PSU34U-00L003"
>>>>> =A0 bios_version =3D "V1.70 =A0 "
>>>>> See http://en.opensuse.org/S2ram for details.
>>>>>
>>>>> =A01.b If is not added, the script add the machine to a text file.
>>>>
>>>> However you arrange that is up to you. =A0My experience is that the
>>>> users generally send whitelist information by email.
>>>>
>>>>> 2. The text file can be processed using a little script to convert
>>>>> it to the "whitelist.[c,h]" files and converted to web page
>>>>> (s2whitelist and s2web :-))
>>>>> 3. The script can do a git update if needed.
>>>>
>>>> Well, I'm surely not going to allow the script to update the master
>>>> git tree at kernel.org directly.
>>>
>>> There's also the issue that some sanity checking should be done before
>>> adding an entry. Pretty often, users send some hilarious option
>>> combinations, on machines that should nowadays just work without any
>>> options (e.g. intel-based).
>>
>> Agreed.
>>
>>> The next thing is, that I, personally, would reject any machines that
>>> should work out of the box nowadays with in-kernel drivers (means:
>>> intel, nvidia- and ATI binary-module driven). You can only make things
>>> worse on such machines with userspace workarounds, and they should be
>>> recognized automatically by recent (means: newer than 2 years)
>>> pm-utils, so that no hack is needed. IMHO the whitelist should not be
>>> cluttered with them.
>>
>> Agreed in general, maybe except for the binary driver part. =A0I certain=
ly
>> prefer
>> people using s2ram's workarounds to people installing binary graphics
>> drivers
>> just to make suspend work.
>>
>>>>> In my opinion, the file should have this format:
>>>>>
>>>>> <author info for the comment's
>>>>> line>=B7<sys_vendor>=B7<sys_product>=B7<sys_version>=B7<bios_version>=
=B7<flags>
>>>>>
>>>>> I am using the "=B7" separator because probably is not used in any
>>>>> field.
>>>>
>>>> What's the code of this character?
>>>
>>> Something strange ;-)
>>>
>>> I'd use the pipe character: '|'. I have not yet encountered it in
>>> s2ram-relevant DMI data. It still is readable and not subject to
>>> encoding issues AFAICT.
>>
>> Yes, it is an ASCII character (officially called "vertical bar" BTW).
>>
>>> I'd put the author info / comment at the end, since then you can
>>> sort/grep for sys_vendor easily, which is probably most useful.
>>
>> Agreed.
>>
>>> And I still think that nowadays s2ram is the wrong tool for the
>>> whitelist, but well... :-)
>>
>> Oh, you know my opinion. ;-)
>>
>> Still, if Rodolfo is willing to maintain the whitelist, I won't object.
>>
>> Thanks,
>> Rafael
>



-- =

Rodolfo Garc=EDa "kix"
EA4ERH - IN80ER
