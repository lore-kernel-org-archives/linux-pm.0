From: <trekker.dk@centrum.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 14 May 2009 00:07:58 +0200
Message-ID: <200905140007.4324__48032.3952077471$1242252561$gmane$org@centrum.cz>
References: <20090507120948.GA1531@ucw.cz> <200905080037.19722@centrum.cz>
	<20090510053840.GG1363@ucw.cz> <200905112319.8749@centrum.cz>
	<20090511212350.GA3397@elf.ucw.cz> <200905132219.19216@centrum.cz>
	<20090513202429.GA3680@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090513202429.GA3680@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pavel@ucw.cz
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


>> >> >Which kernels you tried, what hw it is? Can you do s2ram?
>> >> 
>> >> Regarding hardware - 
>> >> 
>> >> 1. AMD Athlon 1700+, VIA KT333 chipset based MB, nVidia GeForce 2
>> >> 2. AMD X2 Athlon, AMD690V chipset based MB, nVidia 7600GT
>> >> 3. (current) AMD X4 Phenom II,  AMD780G chipset and nVidia 9600GT 
>> >> (binary driver for video card every time)
>> >
>> >Ok, binary drivers may be a problem. Will it work without that? Should
>> >be easy to test with init=/bin/bash.
>> 
>> Yes, that works - and after complete boot w/o loading binary driver resume works too.
>> 
>
>Cool. I'm afraid you have to ask nvidia for help here. (Or maybe you
>can just unload nvidia.ko before suspend/reload it after
>resume). Anyway problem is with nvidia here..

And that's where we get to the advantage of TOI again: with TOI I don't have to do that, 
suspend works with X.org running. (IMO there's no point in suspending if I have 
to start all X apps again)

Anyway, I think this thread is a bit off-topic in -devel list, so if there isn't anything 
important to add, this will be the last post from me.

Regards 
JB
