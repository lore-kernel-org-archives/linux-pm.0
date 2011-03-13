From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/8] timekeeping: Use syscore_ops instead of
	sysdev class and sysdev
Date: Sun, 13 Mar 2011 16:08:14 +0100
Message-ID: <201103131608.14914.rjw__28576.5134184205$1300028965$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl> <201103122217.34004.rjw@sisk.pl>
	<alpine.LFD.2.00.1103131455320.2787@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1103131455320.2787@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, March 13, 2011, Thomas Gleixner wrote:
> On Sat, 12 Mar 2011, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The timekeeping subsystem uses a sysdev class and a sysdev for
> > executing timekeeping_suspend() after interrupts have been turned off
> > on the boot CPU (during system suspend) and for executing
> > timekeeping_resume() before turning on interrupts on the boot CPU
> > (during system resume).  However, since both of these functions
> > ignore their arguments, the entire mechanism may be replaced with a
> > struct syscore_ops object which is simpler.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

Rafael
