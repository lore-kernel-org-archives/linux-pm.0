From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 'ACPICA: Minimize the differences between
	linux GPE code and ACPICA code base' breaks EC GPE on my system
Date: Fri, 11 Jun 2010 22:34:39 +0200
Message-ID: <201006112234.39747.rjw__25828.5654163503$1276288738$gmane$org@sisk.pl>
References: <1276256839.4251.7.camel@maxim-laptop>
	<201006112143.54654.rjw@sisk.pl>
	<1276288322.2651.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1276288322.2651.4.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, "Moore,
	Robert" <robert.moore@intel.com>, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Friday, June 11, 2010, Maxim Levitsky wrote:
> On Fri, 2010-06-11 at 21:43 +0200, Rafael J. Wysocki wrote: 
> > On Friday, June 11, 2010, Rafael J. Wysocki wrote:
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
> > 
> > Also, regardless of whether or not this helps, please try to revert only the
> > changes made by the "guilty" commit in drivers/acpi/acpica/evxface.c and see
> > if that helps (this revert will conflict with the patches above, so you'll need
> > to unapply them before).
> > 
> > Thanks,
> > Rafael
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Yes, reverting changes in 'drivers/acpi/acpica/evxface.c' do restore
> correct behavior.

Good.  I think we'll need to revert them for .35, then.

I'll prepare a patch and send it to Len.

Rafael
