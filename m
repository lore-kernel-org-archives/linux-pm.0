From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Date: Thu, 8 Nov 2007 13:30:07 +1100
Message-ID: <18226.29871.368838.584925__14325.8933829658$1194489214$gmane$org@cargo.ozlabs.ibm.com>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135849.207149000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Bryan Wu <bryan.wu@analog.com>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Johannes Berg writes:

> This cleans up the suspend Kconfig and removes the need to
> declare centrally which architectures support suspend. All
> architectures that currently support suspend are modified
> accordingly.

Acked-by: Paul Mackerras <paulus@samba.org>
