From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 21:54:16 +0100
Message-ID: <201101212154.16597.rjw__17027.2138937891$1295643434$gmane$org@sisk.pl>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<1295587618.11852.57.camel@minggr.sh.intel.com>
	<AANLkTi=1n2YMa=_gcfuTQtT=k388MppCWCsxRkhjj-qz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=1n2YMa=_gcfuTQtT=k388MppCWCsxRkhjj-qz@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lin Ming <ming.m.lin@intel.com>, Jeff Chua <jeff.chua.linux@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, January 21, 2011, Linus Torvalds wrote:
> On Thu, Jan 20, 2011 at 9:26 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> > On Fri, 2011-01-21 at 12:50, Linus Torvalds wrote:
> >>
> >>  ...
> >>  [   54.628375] PM: Saving platform NVS memory
> >>  [   54.628387] Disabling non-boot CPUs ...
> >>  [   63.554966] ACPI Exception: AE_BAD_PARAMETER, Returned by Handler
> >> for [EmbeddedControl] (20110112/evregion-474)
> >>  [   63.554992] ACPI Error: Method parse/execution failed
> >> [\_SB_.PCI0.SBRG.EC0_.RCTP] (Node f5c2dea0), AE_BAD_PARAMETER
> >> (20110112/psparse-536)
> >>  [   63.555022] ACPI Error: Method parse/execution failed
> >> [\_TZ_.RTMP] (Node f5c32fa8), AE_BAD_PARAMETER (20110112/psparse-536)
> >>  [   63.555047] ACPI Error: Method parse/execution failed
> >> [\_TZ_.TZ00._TMP] (Node f5c34018), AE_BAD_PARAMETER
> >> (20110112/psparse-536)
> >>  [   63.555079] Thermal: failed to read out thermal zone 0
> >>  [   63.556361] CPU 1 is now offline
> >>  [   63.556944] PM: Restoring platform NVS memory
> >>  [   63.556944] Enabling non-boot CPUs ...
> >>  [   63.556944] Booting Node 0 Processor 1 APIC 0x1
> >>  [   63.556279] Initializing CPU#1
> >>  ...
> >>
> >> which really doesn't tell me much, except that clearly something in
> >> ACPI-land is unhappy, and it looks thermal-related (that last error
> >> message comes from thermal_zone_device_update()).
> >>
> >> Any ideas?

Apparently, the problem occurs while CPU1 is being disabled (or at least
the message is printed at that time), which is highly suspicious, because we
shouldn't be doing _anything_ ACPI-related at this point (the SCI should
have been disabled way earlier and the GPEs should have been disabled as well),
so I'm not really sure what's the source of the ACPI messages.

It _looks_ like we may be executing an AML method while CPU1 is disabled,
which would be kind of ... sick.

Rafael
