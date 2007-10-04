From: Pavel Machek <pavel@ucw.cz>
Subject: Re: khibernation and ACPI
Date: Thu, 4 Oct 2007 12:12:06 +0200
Message-ID: <20071004101206.GI22940@elf.ucw.cz>
References: <1190970219.11480.5.camel@caritas-dev.intel.com>
	<200709281728.44401.rjw@sisk.pl>
	<1191033857.11480.47.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1191033857.11480.47.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The root filesystem is initramfs, so that, the only devices needed by kernel
> > > B is timer.
> > > e. In kernel B, put needed devices back to normal state. 
> > > f. Write memory image of kernel A out
> > > g. Put all devices in quiescent and low power state
> > > h. Execute acpi_enter_sleep_state(ACPI_STATE_S4)
> > 
> > Yes, apart from d. this looks doable.
> > 
> 
> To deal with the issue of d, the following scheme can be used:
> 
> a. Boot kernel A with ACPI on
> b. In kernel A, load the image of a new kernel B with sys_kexec_load
> c. In kernel A, put all devices in quiescent and low power state
> d. In kernel A, kexec kernel B with ACPI on (some devices may be put in
> normal state during boot)
> e. In kernel B, put all devices in quiescent and low power state
> f. In kernel B, Jump back to kernel A
> g. In kernel A, put all devices in normal state
> h. In kernel A, put all devices in low power state
> i. In kernel A, execute _PTS of ACPI
> j. In kernel A, jump to kernel B again
> k. In kernel B, put needed devices back to normal state.
> l. In kernel B, write memory image of kernel A out
> m. In kernel B, put all devices in quiescent and low power state
> n. In kernel B, Execute acpi_enter_sleep_state(ACPI_STATE_S4)

That starts looking pretty complex.

Maybe we should solve the !ACPI case first (should be useful for live
crashdumping, etc)?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
