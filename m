From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Wed, 9 Feb 2011 15:09:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102091507550.2050-100000__15632.5371507139$1297282391$gmane$org@iolanthe.rowland.org>
References: <20110209195918.GD23747@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110209195918.GD23747@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, Frank Rowand <frank.rowand@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "Rowand,
	Frank" <Frank_Rowand@sonyusa.com>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Feb 2011, Mark Brown wrote:

> On Wed, Feb 09, 2011 at 11:53:52AM -0800, Tim Bird wrote:

> > I'm confused.  Do you plan to retain the option to
> > turn off PM features completely, or not?  I thought that's
> > what CONFIG_PM did today.
> 
> Raphael's patches do that in a much better way than my original patch,
> my original patch would have force CONFIG_PM on but still allowed all
> the PM features that it controls to be turned on and off individually.

Or to put it another way, if you enable any of CONFIG_PM_SUSPEND, 
CONFIG_PM_HIBERNATION, or CONFIG_PM_RUNTIME, then CONFIG_PM will 
automatically be turned on.  Otherwise it will automatically be turned 
off.

Alan Stern
