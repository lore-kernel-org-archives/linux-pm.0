From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Wed, 9 Feb 2011 20:10:55 +0000
Message-ID: <20110209201054.GE23747__16549.3978340693$1297282784$gmane$org@opensource.wolfsonmicro.com>
References: <20110209195918.GD23747@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1102091507550.2050-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1102091507550.2050-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, Frank Rowand <frank.rowand@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "Rowand,
	Frank" <Frank_Rowand@sonyusa.com>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 09, 2011 at 03:09:42PM -0500, Alan Stern wrote:
> On Wed, 9 Feb 2011, Mark Brown wrote:

> > Raphael's patches do that in a much better way than my original patch,
> > my original patch would have force CONFIG_PM on but still allowed all
> > the PM features that it controls to be turned on and off individually.

> Or to put it another way, if you enable any of CONFIG_PM_SUSPEND, 
> CONFIG_PM_HIBERNATION, or CONFIG_PM_RUNTIME, then CONFIG_PM will 
> automatically be turned on.  Otherwise it will automatically be turned 
> off.

Plus everything controlled by the old CONFIG_PM_OPS is now controlled
directly by CONFIG_PM.
