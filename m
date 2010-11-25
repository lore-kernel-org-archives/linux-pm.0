From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Freezes on resume from S2R
Date: Thu, 25 Nov 2010 20:59:12 +0100
Message-ID: <201011252059.12794.rjw@sisk.pl>
References: <20101124095618.GC5982@denkmatte.mittag-leffler.se>
	<201011242101.08157.rjw@sisk.pl>
	<20101125101338.GG2503@denkmatte.mittag-leffler.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101125101338.GG2503@denkmatte.mittag-leffler.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Kahle <tomka@gentoo.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, November 25, 2010, Thomas Kahle wrote:
> On 21:01 Wed 24 Nov     , Rafael J. Wysocki wrote:
> > On Wednesday, November 24, 2010, Thomas Kahle wrote:
> > > https://lists.linux-foundation.org/pipermail/linux-pm/2010-November/029299.html
> > 
> > This warning means that resume took more that 10 s, which is suspicious, but
> > not a bug by itself.
> 
> Well, the resume is very quick, at least the display comes up and the
> computer starts to react for a very short time, but then freezes.
> 
> > > These problems appear to me as a regression since everything is
> > > reproducibly fine with kernels <=2.6.34, and 2.6.35 seems to be fine too
> > > (although I have tested that less).  I started a bisect, see below.
> > 
> > Well, it would be good if you could find the commit that broke things for
> > you, but it might be a few different things - ACPI, PCI, graphics driver, etc.
> 
> How do you avoid non booting kernels during bisect? I seem to run into
> non-bootable kernels frequently.

Depends.  You can use "git bisect skip" I guess.

> > Please check if you can reproduce the symptom using pm_test:
> > 
> > # echo core > /sys/power/pm_test
> > # echo mem > /sys/power/state
> > 
> > (it should simulate a suspend-resume cycle and get back to the command prompt
> > in 5-10 sec).  You can try to run that in a loop and see if that
> > breaks things.
> 
> Which kernel options do you recommend for this debugging?  Currently I
> don't have the /sys/power/pm_test node.

CONFIG_PM_DEBUG should be set (but don't set CONFIG_PM_VERBOSE at the same
time).

Thanks,
Rafael
