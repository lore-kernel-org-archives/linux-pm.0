From: Pavel Machek <pavel@ucw.cz>
Subject: Re: x86/.../trampoline_64.S racy?
Date: Fri, 1 Feb 2008 23:15:12 +0100
Message-ID: <20080201221512.GA13276@elf.ucw.cz>
References: <20080201220716.GA8597@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762980AbYBBAIB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080201220716.GA8597@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Fri 2008-02-01 23:07:16, Pavel Machek wrote:
> Hi!
> 
> I'm trying to reuse trampoline_64.S for wakeup from ACPI s3... but I'm
> getting some badness: If I insert delay loops into trampoline_64.S,
> machine fails to boot; but I already increased cpu bootup delay to 200
> seconds...
> 
> Is it possible that bootup is subtly racy somewhere?

No, I just missed another place with timeout:

                /*
                 * Wait 5s total for a response
                 */
                for (timeout = 0; timeout < 5000000; timeout++) {
                        if (cpu_isset(cpu, cpu_callin_map))
                                break;  /* It has booted */
                        udelay(100);
                }

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
