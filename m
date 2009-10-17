From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Freeze the FUSE on Wubi
Date: Sun, 18 Oct 2009 08:02:49 +1100
Message-ID: <4ADA30F9.2060400@crca.org.au>
References: <814979.58291.qm@web112806.mail.gq1.yahoo.com>	<20091016115854.1e476da8@strolchi.home.s3e.de>	<4AD85889.9010206@crca.org.au>	<493410.12916.qm@web112815.mail.gq1.yahoo.com>	<4AD99794.2090507@crca.org.au>
	<588347.1826.qm@web112813.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <588347.1826.qm@web112813.mail.gq1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nick Davies <nickavies@yahoo.com>
Cc: linux-pm@lists.linux-foundation.org, Stefan Seyfried <stefan.seyfried@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

Nick Davies wrote:
>> Nick Davies wrote:
>>>> Stefan Seyfried wrote:
>>>>> On Fri, 16 Oct 2009 01:54:10 -0700 (PDT)
>>>>> Nick Davies wrote:
>>>>>
>>>>>> Dear all,
>>>>>>
>>>>>>    I am trying to debug the suspend/hibernate on Wubi(The Ubuntu
>>>>>> installer for Windows) these day. Since Ubuntu sits on top of NTFS
>>>>>> partition with the help of ntfs-3g via FUSE, I think it should not
>>>>>> pass the file system freezing stage, but in fact, the suspend works
>>>>>> well on my machine. So  I am curious that how can they achieve that?
>>>>>> Just keep the FUSE alive to the end of the suspend? Any ideas are
>>>>>> welcome.
>>>>> (Disclaimer: all below is AFAIK and it might be slightly wrong)
>>>>> On swapon(), a block map of the file / partition is made by the kernel
>>>>> and later I/O to the swap area are not going through the filesystem
>>>>> layer. So FUSE is not involved in the suspend process at the stage of
>>>>> image writing.
>>>> It's exactly right.
>>> Hi,
>>>
>>>   Thanks for all your quick response. That is to say, the suspend itself has 
>> no conflict with the FUSE when do the freezing?
>>>  
>>> To Nigel,
>>>   I've tried the TuxOnIce project, unfortunately I can't do suspend now. 
>> According to the dmesg log, it hangs at the freezing file system. 
>>>   I check some codes of your patch. You've patched freeze_filesystems() to the 
>> fs/buffer.c file, so I guess there may be something wrong with the freeze order 
>> in that subroutine with my situation(OS sits on top of NTFS using ntfs-3g via 
>> FUSE). How your opinions?
>>
>> Hmm. That's interesting - I'd expect things to be the other way around.
>>
>> Can you provide the dmesg?
> 
> Actually, my test machine hangs, I just write down some debug info on screen by hands:
> "...
>  ...
>  [  364.413692] Considering devpts.: (root f6c03750, bdev 0)<6>Nope.
>  [  364.413700] Considering inotifyfs.: (root f6c04900, bdev 0)<6>Nope.
>  [  364.413707] Considering tmpfs.: (root f6c04240, bdev 0)<6>Nope.
>  [  364.413714] Considering anon_inodefs.: (root f6c03090, bdev 0)<6>Nope.
>  [  364.413722] Considering pipefs.: (root f6c03000, bdev 0)<6>Nope.
>  [  364.413729] Considering debugfs.: (root f6c02480, bdev 0)<6>Nope.
>  [  364.413737] Considering sockfs.: (root f6c02360, bdev 0)<6>Nope.
> "
>  So I guess the freezing filesystem has met some troubles.
> 
>  If you want me to do more tests, please let me know.

TuxOnIce definitely doesn't support hibernating to a fuse filesystem,
and I don't believe swsusp does either.

When you say "I can't do suspend now", do you mean suspend to RAM?

For suspend to RAM, I'd expect it to fail and back out nicely in the
worst case. From what you write, it sounds like that's not happening. If
I'm right in thinking that you're talking about suspend to ram and this
is what is happening, would you be able to get more lines of dmesg than
the above? (Something like vga=2 on the boot commandline IIRC)? Don't
worry about writing down timings - just the stuff after "Considering..."
would do - or a digital camera picture if it's clear enough.

Thanks!

Nigel
