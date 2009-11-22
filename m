From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ACPI/ACPICA: resume hang (battery related)
Date: Sun, 22 Nov 2009 15:36:11 +0200
Message-ID: <1258896971.3432.6.camel__4476.59137794307$1258897043$gmane$org@maxim-laptop>
References: <1258664394.3611.8.camel@maxim-laptop>
	<200911192255.45447.rjw@sisk.pl>
	<1258670277.27524.4.camel@maxim-laptop>
	<1258892448.3231.23.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1258892448.3231.23.camel@maxim-laptop>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

I had just disabled the AC driver, yeah, got similar backtrace from acpi
video driver.

Ok, enough, pattern is visible.
The common point is that all backtraces lead to
acpi_ex_acquire_global_lock

According to sources, it is only taken on access to ACPI hardware ranges
that are marked as 'Lock'.

On my system only EC space is marked as such, thus this leads me to two
conclusions.

Ether during suspend EC access isn't synced (this is, EC transaction is
still pending),or that EC gets busted (suprise...) on resume or suspend,
and first read/write cycle to/from it never finishes.

I am using hibernate cycles using 'reboot' mechanism.


Best regards,
Maxim Levitsky
