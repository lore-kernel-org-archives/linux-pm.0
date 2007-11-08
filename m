From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Date: Thu, 8 Nov 2007 09:48:25 +0000
Message-ID: <20071108094825.GB10665__5636.95526584542$1194536295$gmane$org@linux-mips.org>
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
Cc: Bryan Wu <bryan.wu@analog.com>, David Howells <dhowells@redhat.com>, linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>, linux-pm@lists.linux-foundation.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2007 at 02:58:00PM +0100, Johannes Berg wrote:

> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Cheers,

  Ralf
