From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Resend][PATCH 0/3] ACPI / PM: Patches missing from
	linux-acpi-2.6/test
Date: Mon, 13 Dec 2010 22:11:29 +0100
Message-ID: <201012132211.29221.rjw__46948.4555804685$1292274868$gmane$org@sisk.pl>
References: <201012112339.53105.rjw@sisk.pl>
	<alpine.LFD.2.00.1012131523320.16730@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1012131523320.16730@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 13, 2010, Len Brown wrote:
> > Hi Len,
> > 
> > The following three patches seem to have been dropped from your 'test' branch.
> > 
> > If that happened by accident, please reapply.  Otherwise, please let me know
> > what's wrong with the patches so that I can fix them.
> > 
> > [1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead of
> >         acpi_bus_get_power() which is unsafe.
> > 
> > [2/3] - Drop acpi_bus_get_power() which is unsafe and has no users.
> > 
> > [3/3] - Do not call __acpi_bus_get_power() from acpi_bus_set_power()
> >         and remove acpi_power_nocheck that is not necessary any more.
> > 
> > Without these patches the power resources handling rework is incomplete and
> > the code will not work correctly in some situations. 
> 
> Looks like my screw-up.
> 
> I recall inserting the fujitsu patch to fix the 
> build before what were originally 12/13 and 13/13 of this series,
> but apparently I kept the baseline branch and deleted the fix on top of it.
> 
> Yes, in general, I do squawk when I drop patches from acpi-test,
> even if it is a temporary drop due to a time-consuming manual merge.
> 
> So thanks for noticing, I'll look at these again now.

Thanks!

Rafael
