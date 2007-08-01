From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: delete CONFIG_ACPI_PROCFS_SLEEP (again)
Date: Wed, 1 Aug 2007 12:24:34 +0200
Message-ID: <200708011224.35917.rjw__1294.42316615513$1185963400$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
	<200707312327.10755.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707312327.10755.lenb@kernel.org>
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
To: Len Brown <lenb@kernel.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 1 August 2007 05:27, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> CONFIG_ACPI_PROCFS_SLEEP is a NO-OP -- delete it (again).
> 
> Apparently 296699de6bdc717189a331ab6bbe90e05c94db06 creating CONFIG_SUSPEND
> and CONFIG_PM_SLEEP was based on an out-dated version of drivers/acpi/Kconfig,
> as it erroneously restored this recently deleted config option.

Some chunks of code in drivers/acpi/sleep/proc.c depend on
CONFIG_ACPI_PROCFS_SLEEP.  Do you also intend to remove that code?

Greetings,
Rafael
