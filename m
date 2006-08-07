From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Mon, 07 Aug 2006 23:08:59 +0159
Message-ID: <44D7AC02.7060307@gmail.com>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20060807162322.GA17564@knob.reflex>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Lunz <lunz@gehennom.net>
Cc: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Jason Lunz wrote:
> In gmane.linux.kernel, you wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>> I tried it and guess what :)... swsusp doesn't work :@.
>>
>> This time I was able to dump process states with sysrq-t:
>> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>>
>> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
>> suspending device 2.0
> 
> Does it go away if you revert this?
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch

No change.

> That should only affect resume, not suspend, but it does mess around
> with ide power management. Is this maybe happening on the *second*
> suspend?

Nope, the first one.

>> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
> 
> This looks suspicious. -mm does have several ide-fix-hpt3xx patches.

But hdc is not on the hpt3xx controller.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
