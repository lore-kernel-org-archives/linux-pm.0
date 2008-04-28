From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/7] mpc83xx: timer driver for PM wakeup
Date: Mon, 28 Apr 2008 13:15:43 -0500
Message-ID: <20080428181543.GL9849__27129.427312366$1209406674$gmane$org@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
	<Pine.LNX.4.64.0804281721050.7897@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804281721050.7897@axis700.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 28, 2008 at 05:39:32PM +0200, Guennadi Liakhovetski wrote:
> This is a driver for the mpc83xx's GTM4 timer.  It's functionality
> is limited to providing a wakeup source for suspend-to-RAM.

This driver should be redone as a client of Anton's more general GTM
driver.

-Scott
