From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Date: Thu, 8 Nov 2007 00:13:28 +0900
Message-ID: <20071107151328.GA28181__37686.1075558283$1194448622$gmane$org@linux-sh.org>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135849.207149000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071107135849.207149000@sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Bryan Wu <bryan.wu@analog.com>, David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>, linux-pm@lists.linux-foundation.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2007 at 02:58:00PM +0100, Johannes Berg wrote:
> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-pm@lists.linux-foundation.org
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Bryan Wu <bryan.wu@analog.com>
> Cc: Russell King <rmk@arm.linux.org.uk>
> ---
> Architecture maintainers should evaluate whether their
> ARCH_SUSPEND_POSSIBLE symbol should be set only under
> stricter circumstances like I've done for powerpc.
> 
The SH bits look fine.

Acked-by: Paul Mundt <lethal@linux-sh.org>
