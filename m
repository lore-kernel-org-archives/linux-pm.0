From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-users] Shutdown troubles (probably
	about	nvidia)
Date: Sat, 3 Jan 2009 14:26:05 +0100
Message-ID: <20090103132604.GB1531__7045.31339365548$1231013727$gmane$org@ucw.cz>
References: <20081231084723.GA13285@laptop.local>
	<20081231162819.GA8802@laptop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081231162819.GA8802@laptop.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Nezhevenko <dion@inhex.net>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-users@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Wed 2008-12-31 18:28:19, Dmitry Nezhevenko wrote:
> On Wed, Dec 31, 2008 at 10:47:23AM +0200, Dmitry Nezhevenko wrote:
> > Hi guys. It looks like recent NVIDIA proprietary drivers (and now more
> > often than usually) sometimes don't allow my laptop to shutdown after
> > hibernate.
> > 
> > I've tried both S4 and S5. Just after writing RAM content to disk kernel
> > prints "Power down." message and freezes. Something like old AT cases
> > where power should be turned off by hands. So I need to press power button
> > for 4-5 seconds to shutdown machine. During next boot it resumes
> > correctly. 
> > 
> > Currently I configured xorg to use "nv" driver. Looks like it works
> > correctly. Maybe anybody have some idea and/or workaround?
> > 
> > PS. Kernel 2.6.28, latest TuxOnIce, downloaded as patch, nvidia driver
> > v180.18.
> > 
>  
> I've spent a bit more with debugging this issue. Currently I know
> followed:
> 
> 1. Same happens without ToI using mainline hibernation
> 
> 2. I've reproduced it once without nvidia proprietary module (using nv),
> however it happens too rarely.
> 
> 3. It hangs in infinite loop at drivers/acpi/hardware/hwsleep.c:
> 
>         do {
>                 status = acpi_get_register(ACPI_BITREG_WAKE_STATUS, &in_value);
>                 if (ACPI_FAILURE(status)) {
>                         return_ACPI_STATUS(status);
>                 }
>         } while (!in_value);
> 
> (verified by adding printk())
> 
> This looks like hardware/bios bug, however there was no such problem in
> times of 2.6.25 kernel (with and without nvidia proprietary module)

Yes, that looks bad.

If it is hard to reproduce w/o nvidia, maybe it is present in 2.6.25
but hard to reproduce...?

Look for updated bios, and maybe ask nvidia for help...
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
