From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] add firmware disk state and clean up
Date: Tue, 20 Mar 2007 15:59:32 -0700
Message-ID: <200703201559.33065.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174385865.3770.20.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Ben Dooks <ben@simtec.co.uk>, Pavel Machek <pavel@ucw.cz>, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 3:17 am, Johannes Berg wrote:

> --- linux-2.6.orig/arch/arm/mach-at91/pm.c	2007-03-20 10:55:35.433214909 =
+0100
> +++ linux-2.6/arch/arm/mach-at91/pm.c	2007-03-20 10:56:02.243214909 +0100
> @@ -199,11 +199,16 @@ error:
>  	return 0;
>  }
>  =

> +static int at91_pm_valid(suspend_state_t state)
> +{
> +	return state =3D=3D PM_SUSPEND_MEM;
> +}
>  =

>  static struct pm_ops at91_pm_ops =3D{
>  	.valid		=3D at91_pm_valid_state,
>  	.prepare	=3D at91_pm_prepare,
>  	.enter		=3D at91_pm_enter,
> +	.valid		=3D at91_pm_valid,
>  };
>  =

>  static int __init at91_pm_init(void)

Clearly bogus.  The STR support isn't upstream yet, true, but
you shouldn't modify that code at all.

- Dave
