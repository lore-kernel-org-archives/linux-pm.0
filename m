From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: x86: Expected system state when resumed
Date: Tue, 21 Jul 2009 22:48:17 +0200
Message-ID: <200907212248.18050.rjw@sisk.pl>
References: <20090721164542.GA30390@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090721164542.GA30390@plexity.net>
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
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 21 July 2009, Deepak Saxena wrote:
> 
> I am working on getting suspend/resume working on an x86 system
> (OLPC XO-1.5) where we are implementing ACPI based suspend/resume
> using Open Firmware and what I am seeing right now is that on 
> resume, we're not receiving interrupts so the system locks
> up in the suspend path when msleep() is called from the EHCI
> HCD resume code. lapic_resume() is being called so the APIC
> is being restored.  I'm looking for information on what else
> Linux's expectation from the firmware when control is handed back 
> before I start dumping every system register pre and post resume.

If that's 2.6.30 or later and your timer interrupt is MSI, for example, please
check if the timer interrupt is marked as IRQF_TIMER.  If it's not,
suspend_device_irqs() will mark it as disabled and it won't work during
early resume.

Best,
Rafael
