From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Acer 6592 TM, suspend to ram and resume freeze
Date: Tue, 3 Feb 2009 12:33:13 +0100
Message-ID: <20090203113313.GB1940@elf.ucw.cz>
References: <87r62tws65.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87r62tws65.fsf@free.fr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!
> 
> I have an issue with my laptop with suspend to ram.
> My laptop is an Acer Travelmate 6592g :
> 
> > [rj@velvet wireshark-1.0.5 (master)]$ sudo s2ram -i
> > This machine can be identified by:
> >     sys_vendor   = "Acer"
> >     sys_product  = "TravelMate 6592"
> >     sys_version  = "PSMBOU-1234567"
> >     bios_version = "V1.53   "
> 
> The kernel running is the last I have : 2.6.29-rc1, but the problem is the same
> whatever the kernel version I take (between 2.6.16 and 2.6.29-rc1).
> 
> The issue is that even if the laptop enters suspend correctly, it hangs on
> comming out of it. After some research, I cornered down the module which changes
> the behaviour : acpi_cpufreq.ko.

Cool. Can you report that on acpi lists + lkml?

> As this is not the part of the kernel I'm most at ease with, I'd like some help
> to investigate. I'll gladly make any test or apply patches to my own git tree.

Hmm, is there chance for serial console or something?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
