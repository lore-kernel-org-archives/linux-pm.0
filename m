From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 11/14] PM / AVR32: Use struct syscore_ops
 instead of sysdevs for PM
Date: Tue, 26 Apr 2011 14:22:12 +0200
Message-ID: <1303820532.3125.12.camel__39717.574165161$1303830028$gmane$org@hcegtvedt>
References: <201103280125.11750.rjw@sisk.pl>
	<201104172301.54115.rjw@sisk.pl>  <201104172313.09712.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104172313.09712.rjw@sisk.pl>
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2011-04-17 at 23:13 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Convert some AVR32 architecture's code to using struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
> 
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

Thanks, nice work. Tested and run on hardware.

<snipp>

-- 
Hans-Christian Egtvedt
