From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Tue, 19 Jun 2007 16:57:55 +0800
Message-ID: <1182243475.5411.101.camel__44710.0022262477$1182243977$gmane$org@localhost.localdomain>
References: <20070518071523.GA3195@inferi.kami.home>
	<20070518002240.bc08e811.akpm@linux-foundation.org>
	<20070519064829.GA15518@inferi.kami.home>
	<20070519000413.75badb6f.akpm@linux-foundation.org>
	<20070520061408.GA3325@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070520061408.GA3325@inferi.kami.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mattia Dongili <malattia@linux.it>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-05-20 at 15:14 +0900, Mattia Dongili wrote:
> On Sat, May 19, 2007 at 12:04:13AM -0700, Andrew Morton wrote:
> > On Sat, 19 May 2007 15:48:29 +0900 Mattia Dongili <malattia@linux.it> wrote:
> > 
> > > On Fri, May 18, 2007 at 12:22:40AM -0700, Andrew Morton wrote:
> > > > On Fri, 18 May 2007 16:15:24 +0900 Mattia Dongili <malattia@linux.it> wrote:
> > > > 
> > > > > Hello,
> > > > > 
> > > > > After finally catching fw-{ohci,core} to be problematic during resume,
> > > > > I'm now experiencing an immediate resume after suspending.
> > > > > 
> > > > > 2.6.21-rc7-mm* didn't even suspend, my last known suspend-and-resuming
> > > > > kernel was 2.6.21-rc5-mm3 (I know one other vaio SZ user could STR with
> > > > > 2.6.21-rc6-mm* after the cpuidle fixes).
> > > > > 
> > > > > my .config is: http://oioio.altervista.org/linux/config-2.6.22-rc1-mm1-1
> > > > > and a str cycle with PM_DEBUG=y:
> > > > > http://oioio.altervista.org/linux/dmesg-SRT-immediately-resumes.txt
> > > ...
> > > > > Any idea where to start from? (bisecting is ok, but it'll take some
> > > > > time...)
> > > > 
> > > > Bisecting isn't that bad ;) I'd pick git-acpi.patch as the starting point.
> > > 
> > > ok, git-acpi.patch is not the bad boy :)
> 
> but very very close:
> acpi-driver-model-flags-and-platform_enable_wake.patch
> 
Hi, Mattia,

I tested this patch on several platforms but can not reproduce the bug.
Could you please help me do a simple test please?

Any kernel release later than 2.6.22-rc1 is ok. You don't need to apply 
acpi-driver-model-flags-and-platform_enable_wake.patch.

Try to enable the wakeup GPE for all the USB devices first.
e.g. "#echo USB1 >/proc/acpi/wakeup" will enable GPE for USB1.
USB1      S3     disabled  pci:0000:00:1d.0
USB2      S3     disabled  pci:0000:00:1d.1
USB3      S3     disabled  pci:0000:00:1d.2
USB4      S3     disabled  pci:0000:00:1d.3
USB7      S3     disabled  pci:0000:00:1d.7

Try STR and check if it resumes immediately after suspend.
I think the same problem will happen without this patch.

Thanks,
Rui
