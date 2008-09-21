From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: I need some serious help to debug suspend to ram
	problem
Date: Sun, 21 Sep 2008 19:00:28 +0300
Message-ID: <48D66F9C.4000204__10995.5930653543$1222013015$gmane$org@gmail.com>
References: <48D4E685.8030801@gmail.com> <200809201810.45057.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809201810.45057.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Saturday, 20 of September 2008, Maxim Levitsky wrote:
>> Hi,
>>
>> I hit a dead end when trying to understand 
>> why my notebook can't resume from suspend to ram
>> if this is done two times a row.
>>
>> Single suspend/resume cycle works almost perfectly 
>> (beep that goes through the sound card is muted... 
>> no morse code for me... :-(
>>
>> )
>>
>> I compiled a minimal kernel (absolutely nothing but disk drivers, all experimental option like nohz
>> turned off)
>>
>> But I had to turn SMP, since without it system won't resume first time I suspend it.
>> (How could this affect suspend?)
> 
> It could if the system is 64-bit.  In which case please have a look at
> http://bugzilla.kernel.org/show_bug.cgi?id=11237
> 
>> With SMP and minimal kernel (of course  no closed drivers), I get same behavior,
>> first resume works second hangs.
>>
>> I then added some debug code to real mode wakeup code, I put there in first
>> place instructions, that will save some magic value to rtc (to alarm
>> registers that I know are preserved during boot cycle), and I discovered   
>> sad thing that first time bios does pass control to linux, but second time
>> (when it hangs), it doesn't. 
>>
>>
>> I tried to update bios, and I got same results.
>>
>> Of course it does work with that @#$%^& OS
> 
> So we're doing something wrong.  Please try the appended patch.
> 
>> I then proceeded to test recently posted low memory corruption patch, and
>> it did show that that @#$%^& BIOS does corrupt low memory 
>> I then reserved all low memory, but system began to hand after first suspend,
>> in exactly same way, but as expected I soon discovered, that that forces real
>> mode page to be above 1M, ok, then I reserved almost all low memory except
>> 100K window in the middle, so low allocations will work, but be placed in
>> region bios less likely to corrupt, and still that didn't help, still same hang.   
>>  

More information, I compiled kernels back to 2.6.19, and they all have exactly the same issue.


Any ideas?

Best regards,
	Maxim Levitsky
