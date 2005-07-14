From: "Leo L. Schwab" <ewhac@best.com>
Subject: Re: Few enhancement ideas
Date: Thu, 14 Jul 2005 14:56:07 -0700
Message-ID: <20050714215607.GA16613@best.com>
References: <1121277175.6338.105.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5882963574550486=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1121277175.6338.105.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============5882963574550486==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 13, 2005 at 08:52:55PM +0300, Amit Kucheria wrote:
> The Nokia 770 Linux team has made many contributions to the Linux-OMAP
> port, some of the PM-specific ones being:
> 
> - Dynamic tick patch by Tony Lindgren
> (http://www.muru.com/linux/dyntick/): Initially for
> the OMAP architecture followed by the recent x86 port
> - Clock framework for the OMAP architecture - Thanks to Tuukka Tikkanen
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> - PM-enabling various drivers in the mach-omap tree
> 
	My thanks to you and Tuukka Tikkanen as well.  I took the ARM clock
API framework you developed for the OMAP, hacked it to shreds and got it
working on the Freescale i.MX1.

	Some clocks on the i.MX1 are always running, so when they're unused,
I elected to spin them down the slowest available speed, saving a bit more
power.  I also keep a copy of the requested target frequency so that when
parent clocks get changed, I can keep the child clocks running as close as
possible to the originally requested speed.  This is useful for stuff like
the I2C bus and audio clocks, and really darned helpful in keeping the
console serial port working correctly.

	When you were implementing the framework, did you have any thoughts
about where the initial clock frequencies "should" come from?  It sounds
like a policy issue, and therefore compiling it into the kernel (as you've
done in your OMAP implementation) is The Wrong Thing.  But it's not at all
clear where else it could go.

	Again, my thanks.  It was tons of help.

					Schwab

--===============5882963574550486==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============5882963574550486==--
