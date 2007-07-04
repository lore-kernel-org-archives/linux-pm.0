From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Introduce pm_power_off_prepare
Date: Wed, 4 Jul 2007 23:42:27 +0200
Message-ID: <200707042342.27427.rjw__33495.4396625564$1183584933$gmane$org@sisk.pl>
References: <200707012051.48338.rjw@sisk.pl> <200707012054.31782.rjw@sisk.pl>
	<20070704195231.GI2728@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704195231.GI2728@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 21:52, Pavel Machek wrote:
> On Sun 2007-07-01 20:54:31, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Introduce the pm_power_off_prepare() callback that can be registered by the
> > interested platforms in analogy with pm_idle() and pm_power_off(), used for
> > preparing the system to power off (needed by ACPI).
> > 
> > This allows us to drop acpi_sysclass and device_acpi that are only defined in
> > order to register the ACPI power off preparation callback, which is needed by
> > pm_power_off() registered in a much different way.
> 
> Well, the acpi way works with more than one piece of code "listening"
> for powerdowns... and does not seem that ugly to me.
> 
> Okay, so accessing system_state is not _that_ nice... aha, and perhaps
> I understand why 1/2 of this series is right... it called prepare for
> S4 even when we had shutdown in /sys/power/disk, right?
> 
> Hmm. Okay, I think I can ACK both of these patches, but ACPI people
> should have chance to comment, and it probably needs to stay in -mm
> for a while.

Well, linux-acpi in on the CC list and I see no comments from them. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
