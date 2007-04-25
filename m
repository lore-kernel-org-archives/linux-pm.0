From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Thu, 26 Apr 2007 01:00:23 +0200
Message-ID: <20070425230023.GG3468__34006.7268968143$1177542074$gmane$org@stusta.de>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425113102.GU3468@stusta.de>
	<20070425130102.GA10141@redhat.com>
	<1177509014.29878.12.camel@daplas>
	<1177509136.29878.14.camel@daplas>
	<20070425143305.GB27215@redhat.com>
	<1177514682.4856.24.camel@daplas>
	<20070425163145.GA6630@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070425163145.GA6630@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>, "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz, linux-pm@lists.linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, James Simmons <jsimmons@infradead.org>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jeremy Fitzhardinge <jeremy@goop.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 25, 2007 at 12:31:45PM -0400, Dave Jones wrote:
> On Wed, Apr 25, 2007 at 11:24:42PM +0800, Antonino A. Daplas wrote:
>  > On Wed, 2007-04-25 at 10:33 -0400, Dave Jones wrote:
>  > > On Wed, Apr 25, 2007 at 09:52:16PM +0800, Antonino A. Daplas wrote:
>  > >  > > And have you tried the following settings:
>  > >  > > FB_BACKLIGHT=y
>  > >  > > ACPI_IBM=n
>  > >  > > ACPI_VIDEO=n
>  > > 
>  > 
>  > BTW, there was one report where resume from RAM resulted in a screen
>  > full of garbage.  It seems that the option acpi_sleep= (or s2ram -a3)
>  > did not work for him anymore.  But it worked with s2ram and other
>  > options. So if you have s2ram, try:
>  > 
>  > s2ram -f -s -a3
>  > s2ram -f -m -a3
>  > s2ram -f -p -m
>  > s2ram -f -p -s
> 
> I just did a pull of linus' tree, and it now works for me fine.
> Adrian, I think we can remove this from the list.
>...

Thanks, removed as "seems fixed in -rc8".

> 	Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
