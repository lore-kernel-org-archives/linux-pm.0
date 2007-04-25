From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [3/3] 2.6.21-rc7: known regressions (v2)
Date: Wed, 25 Apr 2007 23:24:42 +0800
Message-ID: <1177514682.4856.24.camel__3346.17880075729$1177514769$gmane$org@daplas>
References: <Pine.LNX.4.64.0704151659570.5473@woody.linux-foundation.org>
	<20070423214909.GD3468@stusta.de>
	<20070425040605.6d6b4a82.akpm@linux-foundation.org>
	<20070425113102.GU3468@stusta.de> <20070425130102.GA10141@redhat.com>
	<1177509014.29878.12.camel@daplas> <1177509136.29878.14.camel@daplas>
	<20070425143305.GB27215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070425143305.GB27215@redhat.com>
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

On Wed, 2007-04-25 at 10:33 -0400, Dave Jones wrote:
> On Wed, Apr 25, 2007 at 09:52:16PM +0800, Antonino A. Daplas wrote:
>  > > And have you tried the following settings:
>  > > FB_BACKLIGHT=y
>  > > ACPI_IBM=n
>  > > ACPI_VIDEO=n
> 

BTW, there was one report where resume from RAM resulted in a screen
full of garbage.  It seems that the option acpi_sleep= (or s2ram -a3)
did not work for him anymore.  But it worked with s2ram and other
options. So if you have s2ram, try:

s2ram -f -s -a3
s2ram -f -m -a3
s2ram -f -p -m
s2ram -f -p -s

Tony 
