From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 9/12] ACPI / PM: Introduce
	acpi_pm_wakeup_power()
Date: Thu, 7 Jan 2010 00:11:49 +0100
Message-ID: <201001070011.49755.rjw__14310.7363874607$1262819622$gmane$org@sisk.pl>
References: <200912272057.10443.rjw@sisk.pl> <200912272106.26569.rjw@sisk.pl>
	<20100106140035.6f622acf@jbarnes-piketon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100106140035.6f622acf@jbarnes-piketon>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 06 January 2010, Jesse Barnes wrote:
> On Sun, 27 Dec 2009 21:06:26 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >  /**
> > + * acpi_pm_wakeup_power - Enable/disable device wake-up power.
> > + * @dev: ACPI device to handle.
> > + * @enable: Whether to enable or disable the wake-up power of the
> > device.
> > + */
> > +int acpi_pm_wakeup_power(struct acpi_device *dev, bool enable)
> > +{
> 
> I know we've got these all over now, but functions that just take a
> bool are generally hard to read when you just look at the call site.
> If it was called "acpi_pm_set_wakeup_power" and then took an on/off
> enum it would be really easy to see, from the callsite, what was going
> on.
> 
> It's a fairly minor complaint, but it's something that's always bugged
> me about the PCI PM code in particular.

Well, in this particular case acpi_pm_wakeup_power() uses a bool, because
acpi_pm_device_sleep_wake() (which is a caller of it) does.  IMO it won't
be logical to use something else just here.

Also, as you noticed above, this follows a convention used not only in the
PCI PM, but generally in the core PM code.  Although we could change this
convention, I'm not really sure that would be worth the effort.

Rafael
