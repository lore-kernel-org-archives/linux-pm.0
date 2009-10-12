From: Ondrej Hujnak <hujnak.ondrej@gmail.com>
Subject: Re: Suspend to RAM on MSI PR200YA - do not recover,
	system 	immediately turns down
Date: Mon, 12 Oct 2009 17:49:03 +0200
Message-ID: <37b436160910120849o6aae596w50e450b4838ed233__46521.5212003843$1255371586$gmane$org@mail.gmail.com>
References: <37b436160910101054t7765c253ta98b983f226b57c3@mail.gmail.com>
	<200910102334.42399.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910102334.42399.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, mschmidt@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2009/10/10 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday 10 October 2009, Ondrej Hujnak wrote:
>> Hello,
>>
>> I am trying to make work "Suspend to RAM".
>> My laptop is MSI PR200YA, linux
>> kernel 2.6.30.8-64.fc11.i586 (fedora 11, 32bit),
>> the same is with 2.6.31.1-56.fc12.i686.
>> Motherboard - MSI 1221, graphics:
>> Mobile GM965/GL960 Integrated Graphics Controller
>>
>> When I do suspend to RAM it seem to work ok, it sleeps.
>> But when I want to wake it, it only switches off (the power
>> LED stops blinking). =A0If I'm having my notebook connected
>> to electricity, after start it don't =A0start screen and keyboard.
>> Notebook is running, but there is no HDD activity according
>> to the LED indicator. When it is on battery, it normally starts,
>> as if I had switched it normally off. Every time after trying to
>> suspend it to RAM, on the next start I have
>> "last write to superblock in future".
>>
>> I tried:
>> =A0- suspend from "single" mode
>> =A0- suspend from "single" mode with as many modules as possible rmmod'ed
>> =A0- using "nomodeset"
>> =A0- early suspend-to-RAM at boot test with "test_suspend=3Dmem"
>> All with the same result.
>>
>> I also tried using pm_trace, but this gave no useful results in dmesg
>> in the next boot. The clock was not changed by it (the documentation
>> said it would be).
>>
>> I have attached printout of "lspci -vv" and "dmesg" after switching
>> pm_trace on.
>>
>> I'd welcome any ideas how to debug this further.
>> I'm looking forward to your reply.
>
> Does the pm_test 'core' test work (please see
> Documentation/power/basic-pm-debugging.txt)?
>
> Rafael
>

Ok, i tried all kinds of pm_test including core several times
and everything seemed ok. I got no error, failure..

And i tried all possibilities of /sys/power/disk under
 "init=3D/bin/bash" and same result as above.

Ondrej
