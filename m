From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 21:52:16 +0800
Message-ID: <1177509136.29878.14.camel__20300.9167955772$1177509210$gmane$org@daplas>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425113102.GU3468@stusta.de> <20070425130102.GA10141@redhat.com>
	<1177509014.29878.12.camel@daplas>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177509014.29878.12.camel@daplas>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dave Jones <davej@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, James Simmons <jsimmons@infradead.org>, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Forgot to add Richard, sorry for the double post.

On Wed, 2007-04-25 at 21:50 +0800, Antonino A. Daplas wrote:
> On Wed, 2007-04-25 at 09:01 -0400, Dave Jones wrote:
> > On Wed, Apr 25, 2007 at 01:31:02PM +0200, Adrian Bunk wrote:
> >  > On Wed, Apr 25, 2007 at 04:06:05AM -0700, Andrew Morton wrote:
> >  > > On Mon, 23 Apr 2007 23:49:09 +0200 Adrian Bunk <bunk@stusta.de> wrote:
> >  > >...
> >  > > > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
> >  > > >              workaround: CONFIG_FB_BACKLIGHT=n
> >  > > > References : http://lkml.org/lkml/2007/3/13/3
> >  > > > Submitter  : Dave Jones <davej@redhat.com>
> >  > > > Caused-By  : PCI merge
> >  > > >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
> >  > > > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
> >  > > >              Rafael J. Wysocki <rjw@sisk.pl>
> >  > > >              Antonino A. Daplas <adaplas@gmail.com>
> >  > > > Status     : unknown
> >  > > 
> >  > > Is this related to the problems Jeremy has been looking at?
> >  > >...
> >  > 
> >  > Dave and Jeremy hran into similar looking but most likely different 
> >  > problems.
> >  > 
> >  > For Jeremy -rc7 is working fine, but for Dave it doesn't.
> > 
> > I think this was due to Jeremy not having CONFIG_FB_BACKLIGHT=y in his config.
> 
> This is really weird, as CONFIG_FB_BACKLIGHT just selects
> BACKLIGHT_CLASS and LCD_CLASS, and adds an entry (bl_curve)
> under /sys/class/backlight/*/. ACPI_IBM which is set (presumably) in
> Dave's kconfig, also selects the BACKLIGHT_CLASS. And the only possible
> framebuffer drivers in the thinkpad are vesafb and intelfb, none of
> which has a backlight driver.
> 
> I'm still at a loss how this happens.  Dave, can you post your config?
> And have you tried the following settings:
> 
> FB_BACKLIGHT=y
> ACPI_IBM=n
> ACPI_VIDEO=n
> 
> I'm also adding Richard Purdie to the CC list.
> 
> Tony 
> 
> PS: I also get a blank display on resume with a Toshiba laptop.  But
> cycling through the Fn keys brings it back.  I don't know if this is a
> regression, I will have to try older kernels.
> 
