From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from
	linux-acpi-2.6/test
Date: Wed, 15 Dec 2010 23:20:09 +0100
Message-ID: <201012152320.09384.rjw__21047.9290377863$1292453197$gmane$org@sisk.pl>
References: <201012112339.53105.rjw@sisk.pl> <201012142124.37270.rjw@sisk.pl>
	<1292379455.3983.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1292379455.3983.129.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ykzhao <yakui.zhao@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 15, 2010, ykzhao wrote:
> On Wed, 2010-12-15 at 04:24 +0800, Rafael J. Wysocki wrote:
> > On Tuesday, December 14, 2010, ykzhao wrote:
> > > On Tue, 2010-12-14 at 05:25 +0800, Rafael J. Wysocki wrote:
> > > > On Monday, December 13, 2010, ykzhao wrote:
> > > > > On Sun, 2010-12-12 at 06:39 +0800, Rafael J. Wysocki wrote:
...
> > 
> > The force_power_state was _only_ a workaround for the case when
> > acpi_bus_set_power() called acpi_bus_get_power() and apparently received
> > a wrong value from it on some systems (two of them had been identified, one was
> > blacklisted in the end).  However, after my changes acpi_bus_set_power()
> > doesn't call acpi_bus_get_power() (or any equivalent) any more, so this
> > workaround isn't necessary any more either.
> 
> The flag of force_power_state will force it to do the transition of
> power state even when the target state is already the same as the
> current power state. Without this flag, it will skip the power
> transition if the two states are consistent. This is useful under the
> following cases: (The FAN device is used as an example)
>     1. The initial state is reported as D0 state (But we don't know
> whether the FAN device is really turned on)
>     2. If we expect to turn on the corresponding FAN device for the
> first time(put it into D0 state),  it will skip the power transition as
> the check of "state == device->power.state". In such case it will be
> better that the power transition is forced in order to assure that the
> FAN device is turned on by calling the _PSC/_ON object. 

Before my changes the force_power_state device flag was used only by the fan
driver in two places: in acpi_fan_add() (ie. during fan initialization) and in
acpi_fan_resume().  In both cases it was used to make acpi_bus_set_power()
accept the state read by acpi_bus_get_power().  In both cases
acpi_bus_update_power() can be used to obtain _exactly_ the same result,
so the flag is not necessary any more.

Thanks,
Rafael
