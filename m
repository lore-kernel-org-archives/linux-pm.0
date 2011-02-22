From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv3] amba: support pm ops
Date: Tue, 22 Feb 2011 21:28:21 +0100
Message-ID: <201102222128.21601.rjw__34793.5860431336$1298452296$gmane$org@sisk.pl>
References: <201102212126.10742.rjw@sisk.pl> <201102222102.15089.rjw@sisk.pl>
	<20110222201529.GB29559@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110222201529.GB29559@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-pm@lists.linux-foundation.org, Rabin Vincent <rabin.vincent@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 22, 2011, Russell King - ARM Linux wrote:
> On Tue, Feb 22, 2011 at 09:02:14PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 22, 2011, Rabin Vincent wrote:
> > > Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
> > > The implementation of AMBA bus pm ops is based on the platform bus
> > > implementation.
> > > 
> > > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> > 
> > Looks good.
> > 
> > Who's supposed to take it?
> 
> Does this help?
> 
> ARM PRIMECELL BUS SUPPORT
> M:      Russell King <linux@arm.linux.org.uk>
> S:      Maintained
> F:      drivers/amba/
> F:      include/linux/amba/bus.h

Still, it's power management, right?

Anyway, I guess that means you're going to take care of it. :-)

Thanks,
Rafael
