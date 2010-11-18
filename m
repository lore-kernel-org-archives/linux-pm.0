From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.37-rc1+: hibernate regression,
	claims not enough swap space
Date: Thu, 18 Nov 2010 13:43:00 +0100
Message-ID: <201011181343.00978.rjw__45847.7869433866$1290084326$gmane$org@sisk.pl>
References: <20101114052138.GB2189@elf.ucw.cz> <201011180018.42858.rjw@sisk.pl>
	<20101117233859.GA23086@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101117233859.GA23086@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 18, 2010, Pavel Machek wrote:
> Hi!
> 
> > > > This is not how it works now.  We preallocate memory to create memory pressure,
> > > > so if image_size is 0, we need to preallocate until we run out of pages that
> > > > can be freed, which means OOM.
> > > 
> > > That's bad, right? Instead of killing 
> > 
> > I'm not sure what you mean.
> 
> I meant "instead of failing hibernation, you get OOM -- killing random
> processes".

That's not the case.  The OOM _killer_ is disabled during hibernation, but
there's some more OOM code that's trying very hard to free whatever pages
it can get without killing any processes.

> > > Anyway, it does not work at all.
> > > 
> > > root@amd:~# echo 300000000 > /sys/power/image_size
> > > root@amd:~# echo disk > /sys/power/state 
> > > -su: echo: write error: No space left on device
> > > 
> > > (And dmesg full of failed allocations).
> > > 
> > > I can write 400M there, and it fails, too.
> > 
> > Well, in that case your swap is smaller than the requested image size, isn't it?
> 
> No, swap is 
> 
> pavel@amd:~/misc$ cat /proc/swaps 
> Filename				Type		Size	Used
> Priority
> /dev/sda1                               partition	779148	0
> -1
> 
> ... 700M.
> 
> > There's a check in there that should catch that and it apparently doesn't work.
> > 
> > Do you have that dmesg by chance?
> 
> dmesg is useless -- it is full of backtraces :-(. ACPI allocations
> fail.

What about:

# echo core > /sys/power/pm_test
# echo disk > /sys/power/state

Then the messages should be there in the logs.

Thanks,
Rafael
