From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 7/7] linkstation: implement standby
Date: Mon, 28 Apr 2008 10:58:21 -0500
Message-ID: <20080428155821.GD9849__16459.1559711427$1209398509$gmane$org@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
	<Pine.LNX.4.64.0804281732000.7897@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804281732000.7897@axis700.grange>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Tony Breeds <tony@bakeyournoodle.com>, linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 28, 2008 at 05:40:19PM +0200, Guennadi Liakhovetski wrote:
> +static int ls_pm_enter(suspend_state_t state)
> +{
> +	u64 tb;
> +
> +	/* Get timebase */
> +	tb = get_tb();
> +
> +	/* put CPU to sleep, re-enabling interrupts */
> +	mpc6xx_enter_standby();
> +
> +	local_irq_disable();

Interrupts should not be enabled when you come out of
mpc6xx_enter_standby(); see the TLF_SLEEPING patch.

> +#define	MPC10X_LP_REF_EN	(1<<12)
> +#define	MPC10X_PM		(1<<7)
> +#define MPC10X_DOZE		(1<<5)
> +#define	MPC10X_NAP		(1<<4)
> +#define	MPC10X_SLEEP		(1<<3)

Mismatched whitespace (MPC10X_DOZE has a space before it; the others have
tabs).

-Scott
