From: Dave Jones <davej@redhat.com>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 12:31:45 -0400
Message-ID: <20070425163145.GA6630@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425113102.GU3468@stusta.de>
	<20070425130102.GA10141@redhat.com>
	<1177509014.29878.12.camel@daplas>
	<1177509136.29878.14.camel@daplas>
	<20070425143305.GB27215@redhat.com>
	<1177514682.4856.24.camel@daplas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177514682.4856.24.camel@daplas>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, James Simmons <jsimmons@infradead.org>, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 25, 2007 at 11:24:42PM +0800, Antonino A. Daplas wrote:
 > On Wed, 2007-04-25 at 10:33 -0400, Dave Jones wrote:
 > > On Wed, Apr 25, 2007 at 09:52:16PM +0800, Antonino A. Daplas wrote:
 > >  > > And have you tried the following settings:
 > >  > > FB_BACKLIGHT=y
 > >  > > ACPI_IBM=n
 > >  > > ACPI_VIDEO=n
 > > 
 > 
 > BTW, there was one report where resume from RAM resulted in a screen
 > full of garbage.  It seems that the option acpi_sleep= (or s2ram -a3)
 > did not work for him anymore.  But it worked with s2ram and other
 > options. So if you have s2ram, try:
 > 
 > s2ram -f -s -a3
 > s2ram -f -m -a3
 > s2ram -f -p -m
 > s2ram -f -p -s

I just did a pull of linus' tree, and it now works for me fine.
Adrian, I think we can remove this from the list.

I can't explain what fixed it (or even what caused it in the first place),
but it seems to be behaving itself.

	Dave

-- 
http://www.codemonkey.org.uk
