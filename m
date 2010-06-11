From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: commit 'ACPICA: Minimize the differences between
 linux GPE code and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 22:59:06 +0300
Message-ID: <1276286346.30124.4.camel@maxim-laptop>
References: <1276256839.4251.7.camel@maxim-laptop>
	<201006112123.17706.rjw@sisk.pl>
	<1276285623.30124.1.camel@maxim-laptop>
	<201006112150.43743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006112150.43743.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "Moore,
	Robert" <robert.moore@intel.com>, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-06-11 at 21:50 +0200, Rafael J. Wysocki wrote: 
> On Friday, June 11, 2010, Maxim Levitsky wrote:
> > On Fri, 2010-06-11 at 21:23 +0200, Rafael J. Wysocki wrote: 
> > > On Friday, June 11, 2010, Maxim Levitsky wrote:
> > > > Just bisected it.
> > > > 
> > > > I also tried linux-acpi-next/test, and no change.
> > > > 
> > > > The sympthoms are that EC does't sent any GPEs, and therefore battery
> > > > insert/removal events don't show up.
> > > > 
> > > > It can be see by doing 'grep  . /sys/firmware/acpi/interrupts/*'
> > > > With regression the line is shown like this:
> > > > 
> > > > 
> > > > /sys/firmware/acpi/interrupts/gpe1C:   1	enabled
> > > > 
> > > > Without regression it is
> > > > 
> > > > /sys/firmware/acpi/interrupts/gpe1C:   22889	enabled
> > > > 
> > > > and steadily increasing.
> > > > 
> > > > After suspend/resume, regression disappears.
> > > 
> > > Hmm.
> > > 
> > > Can you please apply the following patches:
> > > 
> > > https://patchwork.kernel.org/patch/104903/
> > > https://patchwork.kernel.org/patch/104912/
> > > https://patchwork.kernel.org/patch/104909/
> > > https://patchwork.kernel.org/patch/104911/
> > > https://patchwork.kernel.org/patch/104910/
> > > 
> > > on top of current -git and see if the problem is still there?
> > > 
> > > Rafael
> > 
> > These patch don't apply nether on top of linus tree nor on top of
> > acpi-test tree (which includes these?)
> 
> Yes, acpi-test contains them, so you can test that tree.  I'm not sure why
> they don't apply on top of the Linus' tree, though.
I was using acpi-next all the time, so these patches don't help.
I partially reverted the guilty commit, and compile the kernel.


Best regards,
Maxim Levitsky
