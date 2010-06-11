From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: commit 'ACPICA: Minimize the differences between
 linux GPE code and ACPICA code base' breaks EC GPE on my system
Date: Sat, 12 Jun 2010 00:43:35 +0300
Message-ID: <1276292615.2617.1.camel__39449.1808409386$1276292683$gmane$org@maxim-laptop>
References: <1276256839.4251.7.camel@maxim-laptop>
	<1276288322.2651.4.camel@maxim-laptop> <201006112234.39747.rjw@sisk.pl>
	<201006112259.33602.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006112259.33602.rjw@sisk.pl>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "Moore,
	Robert" <robert.moore@intel.com>, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 2010-06-11 at 22:59 +0200, Rafael J. Wysocki wrote: 
> On Friday, June 11, 2010, Rafael J. Wysocki wrote:
> > On Friday, June 11, 2010, Maxim Levitsky wrote:
> > > On Fri, 2010-06-11 at 21:43 +0200, Rafael J. Wysocki wrote: 
> > > > On Friday, June 11, 2010, Rafael J. Wysocki wrote:
> > > > > On Friday, June 11, 2010, Maxim Levitsky wrote:
> > > > > > Just bisected it.
> > > > > > 
> > > > > > I also tried linux-acpi-next/test, and no change.
> > > > > > 
> > > > > > The sympthoms are that EC does't sent any GPEs, and therefore battery
> > > > > > insert/removal events don't show up.
> > > > > > 
> > > > > > It can be see by doing 'grep  . /sys/firmware/acpi/interrupts/*'
> > > > > > With regression the line is shown like this:
> > > > > > 
> > > > > > 
> > > > > > /sys/firmware/acpi/interrupts/gpe1C:   1	enabled
> > > > > > 
> > > > > > Without regression it is
> > > > > > 
> > > > > > /sys/firmware/acpi/interrupts/gpe1C:   22889	enabled
> > > > > > 
> > > > > > and steadily increasing.
> > > > > > 
> > > > > > After suspend/resume, regression disappears.
> > > > > 
> > > > > Hmm.
> > > > > 
> > > > > Can you please apply the following patches:
> > > > > 
> > > > > https://patchwork.kernel.org/patch/104903/
> > > > > https://patchwork.kernel.org/patch/104912/
> > > > > https://patchwork.kernel.org/patch/104909/
> > > > > https://patchwork.kernel.org/patch/104911/
> > > > > https://patchwork.kernel.org/patch/104910/
> > > > > 
> > > > > on top of current -git and see if the problem is still there?
> > > > 
> > > > Also, regardless of whether or not this helps, please try to revert only the
> > > > changes made by the "guilty" commit in drivers/acpi/acpica/evxface.c and see
> > > > if that helps (this revert will conflict with the patches above, so you'll need
> > > > to unapply them before).
> > > > 
> > > > Thanks,
> > > > Rafael
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > Yes, reverting changes in 'drivers/acpi/acpica/evxface.c' do restore
> > > correct behavior.
> > 
> > Good.  I think we'll need to revert them for .35, then.
> > 
> > I'll prepare a patch and send it to Len.
> 
> Can you check if the patch below fixes the issue?
Yes it does. Thanks!

Best regards,
Maxim Levitsky
