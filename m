From: Dave Jones <davej@redhat.com>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 10:33:05 -0400
Message-ID: <20070425143305.GB27215@redhat.com>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425113102.GU3468@stusta.de>
	<20070425130102.GA10141@redhat.com>
	<1177509014.29878.12.camel@daplas>
	<1177509136.29878.14.camel@daplas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177509136.29878.14.camel@daplas>
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

On Wed, Apr 25, 2007 at 09:52:16PM +0800, Antonino A. Daplas wrote:
 > > This is really weird, as CONFIG_FB_BACKLIGHT just selects
 > > BACKLIGHT_CLASS and LCD_CLASS, and adds an entry (bl_curve)
 > > under /sys/class/backlight/*/.

Yeah, it's puzzling to me too.

 > > ACPI_IBM which is set (presumably) in
 > > Dave's kconfig, also selects the BACKLIGHT_CLASS. And the only possible
 > > framebuffer drivers in the thinkpad are vesafb and intelfb, none of
 > > which has a backlight driver.
 > > 
 > > I'm still at a loss how this happens.  Dave, can you post your config?

http://people.redhat.com/davej/config-x60

 > > And have you tried the following settings:
 > > FB_BACKLIGHT=y
 > > ACPI_IBM=n
 > > ACPI_VIDEO=n

I think I've tried that yes.

	Dave

-- 
http://www.codemonkey.org.uk
