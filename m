From: akuster <akuster@mvista.com>
Subject: Re: [PATCH 2/2] PM: fast power off - driver
Date: Mon, 29 Jan 2007 07:41:59 -1000
Message-ID: <45BE31E7.6070802@mvista.com>
References: <45BBB09C.7020509@mvista.com>
	<20070128100956.77509585.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070128100956.77509585.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



Randy Dunlap wrote:
> On Sat, 27 Jan 2007 10:05:48 -1000 akuster wrote:
> =

>> My apologies, I cc'd the wrong list the first time around.
> =

> =

> +config FAST_POWER_DOWN
> +	tristate "Fast power of profile"
> ---------------------------> off
> 	What does that mean?  especially the "profile" part?
> =

> +	depends on FAST_POWER_OFF
> =

> =

> +	printk(KERN_INFO "PM: Fastpoweroff, %s profile added\n",fpo_default.nam=
e);
> =

> Space after "," please.

will correct

> =

> =

> OK, let me see if I understand fsd_default_off().
> =


<snipped.

> =

> Does this say (2) power off the system and then (3) power off devices?
yes,
> How does it power off devices after calling fastpoweroff()?

It does not, it was only a last ditch effort before losing power. I was =

on the fence whether to include that, easy to remove.

> Or is fastpoweroff() only setting the stage for something to
> happen later?

Nope.

Thanks for you time.
- Armin
