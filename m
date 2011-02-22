From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv3] amba: support pm ops
Date: Tue, 22 Feb 2011 20:15:29 +0000
Message-ID: <20110222201529.GB29559__2172.09175830266$1298408558$gmane$org@n2100.arm.linux.org.uk>
References: <201102212126.10742.rjw@sisk.pl>
	<1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
	<201102222102.15089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102222102.15089.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Rabin Vincent <rabin.vincent@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 22, 2011 at 09:02:14PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, February 22, 2011, Rabin Vincent wrote:
> > Support pm_ops in the AMBA bus, required to allow drivers to use runtime pm.
> > The implementation of AMBA bus pm ops is based on the platform bus
> > implementation.
> > 
> > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> 
> Looks good.
> 
> Who's supposed to take it?

Does this help?

ARM PRIMECELL BUS SUPPORT
M:      Russell King <linux@arm.linux.org.uk>
S:      Maintained
F:      drivers/amba/
F:      include/linux/amba/bus.h
