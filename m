From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Tue, 08 Aug 2006 12:07:20 +0159
Message-ID: <44D8626F.4020101@gmail.com>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com> <20060807162322.GA17564@knob.reflex> <200608072247.59184.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200608072247.59184.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jason Lunz <lunz@gehennom.net>, Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday 07 August 2006 18:23, Jason Lunz wrote:
>> In gmane.linux.kernel, you wrote:
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>>> I tried it and guess what :)... swsusp doesn't work :@.
>>>
>>> This time I was able to dump process states with sysrq-t:
>>> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>>>
>>> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
>>> suspending device 2.0
>> Does it go away if you revert this?
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch
>>
>> That should only affect resume, not suspend, but it does mess around
>> with ide power management. Is this maybe happening on the *second*
>> suspend?
>>
>>> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
>>> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)
>> This looks suspicious. -mm does have several ide-fix-hpt3xx patches.
> 
> I found that git-block.patch broke the suspend for me.  Still have no idea
> what's up with it.

I suspect elevator changes. The wait_for_completion is not woken in ide-io by 
ll_rw_blk. But I don't understand block layer too much. Where the 
blk_end_sync_rq should be called from (why is not called at all)?

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
