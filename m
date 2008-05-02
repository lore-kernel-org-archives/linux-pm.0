From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend, followed by immediate resume
Date: Fri, 2 May 2008 18:59:56 +0200
Message-ID: <200805021859.57457.rjw@sisk.pl>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805021849.14120.rjw@sisk.pl>
	<20080502115706.57d1adf9@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080502115706.57d1adf9@osprey.hogchain.net>
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
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 2 of May 2008, Jay Cliburn wrote:
> On Fri, 2 May 2008 18:49:13 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Can you try to comment out acpi_enable_wakeup_device(acpi_state) in
> > drivers/acpi/sleep/main.c:acpi_suspend_enter() and see if that helps?
> 
> I'm working with 2.6.25.1, which doesn't have acpi_suspend_enter(), but
> I'll hop over to current git and give it a try.

This function is called acpi_pm_enter() in 2.6.25.1.

Thanks,
Rafael
