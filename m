From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Tue, 20 Jan 2009 13:43:16 -0800
Message-ID: <200901201343.17628.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0901210703530.2892@localhost.localdomain>
	<200901201240.53719.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901201240.53719.jbarnes@virtuousgeek.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Keith Packard <keithp@keithp.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Airlie <airlied@linux.ie>, john stultz <johnstul@us.ibm.com>, Eric Anholt <eric@anholt.net>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 20, 2009 12:40 pm Jesse Barnes wrote:
> On Tuesday, January 20, 2009 12:19 pm Linus Torvalds wrote:
> > Added the other people that the git logs say worked on the vblank code
> > to the Cc.
>
> Part of the fix for the vblank hang was in libdrm.  X handles cursor
> movement using SIGALM, so it's pretty easy to get stuck restarting ioctl. 
> And in the case of the vblank ioctl, restart will prevent the kernel
> timeout code from ever triggering, so you'll just see a hang.

Sorry, misspoke here, X's core client scheduler uses SIGALRM (with a 20ms 
default timeslice), not the cursor movement code.
