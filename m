From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 13:31:02 +0200
Message-ID: <20070425113102.GU3468@stusta.de>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070425040605.6d6b4a82.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 25, 2007 at 04:06:05AM -0700, Andrew Morton wrote:
> On Mon, 23 Apr 2007 23:49:09 +0200 Adrian Bunk <bunk@stusta.de> wrote:
>...
> > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
> >              workaround: CONFIG_FB_BACKLIGHT=n
> > References : http://lkml.org/lkml/2007/3/13/3
> > Submitter  : Dave Jones <davej@redhat.com>
> > Caused-By  : PCI merge
> >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
> > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
> >              Rafael J. Wysocki <rjw@sisk.pl>
> >              Antonino A. Daplas <adaplas@gmail.com>
> > Status     : unknown
> 
> Is this related to the problems Jeremy has been looking at?
>...

Dave and Jeremy hran into similar looking but most likely different 
problems.

For Jeremy -rc7 is working fine, but for Dave it doesn't.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
