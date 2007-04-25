From: Dave Jones <davej@redhat.com>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 09:01:02 -0400
Message-ID: <20070425130102.GA10141@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425113102.GU3468@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070425113102.GU3468@stusta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 25, 2007 at 01:31:02PM +0200, Adrian Bunk wrote:
 > On Wed, Apr 25, 2007 at 04:06:05AM -0700, Andrew Morton wrote:
 > > On Mon, 23 Apr 2007 23:49:09 +0200 Adrian Bunk <bunk@stusta.de> wrote:
 > >...
 > > > Subject    : ThinkPad X60: resume no longer works  (PCI related?)
 > > >              workaround: CONFIG_FB_BACKLIGHT=n
 > > > References : http://lkml.org/lkml/2007/3/13/3
 > > > Submitter  : Dave Jones <davej@redhat.com>
 > > > Caused-By  : PCI merge
 > > >              commit 78149df6d565c36675463352d0bfe0000b02b7a7
 > > > Handled-By : Eric W. Biederman <ebiederm@xmission.com>
 > > >              Rafael J. Wysocki <rjw@sisk.pl>
 > > >              Antonino A. Daplas <adaplas@gmail.com>
 > > > Status     : unknown
 > > 
 > > Is this related to the problems Jeremy has been looking at?
 > >...
 > 
 > Dave and Jeremy hran into similar looking but most likely different 
 > problems.
 > 
 > For Jeremy -rc7 is working fine, but for Dave it doesn't.

I think this was due to Jeremy not having CONFIG_FB_BACKLIGHT=y in his config.

	Dave

-- 
http://www.codemonkey.org.uk
