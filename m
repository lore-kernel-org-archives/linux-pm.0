From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.37-rc1+: hibernate regression,
	claims not enough swap space
Date: Thu, 18 Nov 2010 00:38:59 +0100
Message-ID: <20101117233859.GA23086__9004.5933532112$1290037075$gmane$org@elf.ucw.cz>
References: <20101114052138.GB2189@elf.ucw.cz> <201011162327.27454.rjw@sisk.pl>
	<20101117211917.GA394@elf.ucw.cz> <201011180018.42858.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201011180018.42858.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > This is not how it works now.  We preallocate memory to create memory pressure,
> > > so if image_size is 0, we need to preallocate until we run out of pages that
> > > can be freed, which means OOM.
> > 
> > That's bad, right? Instead of killing 
> 
> I'm not sure what you mean.

I meant "instead of failing hibernation, you get OOM -- killing random
processes".

> > Anyway, it does not work at all.
> > 
> > root@amd:~# echo 300000000 > /sys/power/image_size
> > root@amd:~# echo disk > /sys/power/state 
> > -su: echo: write error: No space left on device
> > 
> > (And dmesg full of failed allocations).
> > 
> > I can write 400M there, and it fails, too.
> 
> Well, in that case your swap is smaller than the requested image size, isn't it?

No, swap is 

pavel@amd:~/misc$ cat /proc/swaps 
Filename				Type		Size	Used
Priority
/dev/sda1                               partition	779148	0
-1

... 700M.

> There's a check in there that should catch that and it apparently doesn't work.
> 
> Do you have that dmesg by chance?

dmesg is useless -- it is full of backtraces :-(. ACPI allocations
fail.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
