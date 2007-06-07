From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Thu, 7 Jun 2007 23:15:23 +0200
Message-ID: <20070607211523.GB8611__3204.11782381616$1181250992$gmane$org@elf.ucw.cz>
References: <878xb35sje.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl>
	<87hcpr2ubl.fsf@goat.bogus.local> <200706020037.16615.rjw@sisk.pl>
	<87wsykpweu.fsf@goat.bogus.local> <20070607122303.GA8938@ucw.cz>
	<87tztjo7zo.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87tztjo7zo.fsf@goat.bogus.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Olaf Dietsche <olaf.dietsche@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2007-06-07 21:54:51, Olaf Dietsche wrote:
> Pavel Machek <pavel@ucw.cz> writes:
> 
> >> But either way the script never reaches "shutdown -rn now". So, it
> >> seems, that my laptop does a full resume every other reboot, but it
> >> never returns to userspace.
> >
> > But it returns to kernel... can you use more trace points to figure
> > out where it hangs?
> 
> I haven't looked, but I guess this is somewhere in sysfs.
> 
> I made some small progress. With the nvidia.ko kernel module loaded,
> my laptop returns to userspace. I'll investigate this further.

So it _was_ video card related :-). With working console, it should be
easy to debug with printk.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
