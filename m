From: tony@atomide.com
Subject: Re: Clock Policy Goes Where?
Date: Fri, 24 Jun 2005 06:18:55 -0700
Message-ID: <20050624131853.GA29336@atomide.com>
References: <42BB2173.2010101@tapwave.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17817654605713384=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <42BB2173.2010101@tapwave.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Leo L. Schwab" <lschwab@tapwave.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============17817654605713384==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Leo L. Schwab <lschwab@tapwave.com> [050623 13:58]:
> .	I'm working on an implementation of the ARM clock API for the 
> Freescale i.MX1 (which is very crufty right now and only works on Zodiacs 
> so there's not much point in asking for it (unless you want to critique it; 
> I could use the feedback)), and I find myself wondering where the default 
> clock settings should come from.
> 
> 	Looking at the clock API for the TI OMAP 
> 	(arch/arm/mach-omap/clock.c), I see a table of available clock frequencies. 
> The init code finds the fastest one and sets it.  Then it clk_use()s three 
> other clocks.  Doesn't that constitute a policy decision?  If so, where 
> should this policy reside?

Well since they're needed for the system to work, I'd say low-level init
of clock.c is where they need to be. Otherwise you cannot use clock.c :)

> 	The reason I ask is because my first crack at a clock driver 
> 	implementation had the clocks being disabled/spun down until a client 
> showed up.  This seems fine until you discover that the serial console gets 
> initialized *way* before the clock and serial drivers; that the UART clocks 
> are effectively already in use, which in turn depend on PERCLK1, which in 
> turn depends on SYSPLL.  OTOH, if you don't have the serial console 
> configured, then you don't have to worry about any of that.

You should call clock init early from board init. Serial port may or may
not be on from the bootloader, and the serial console registers with
clock.c later on during the init.

> 	All of which is a long-winded way of observing that the initial 
> 	state of the clocks appears to this novice's eye to be policy-dependent.  
> In the case of the serial console, the policy is encoded in the kernel 
> config and can be easily, if hackishly, handled.  Handling of other 
> policies is less obvious (sticking them all in the kernel config seems 
> wrong).  I would prefer to do The Right Thing here.  Can anyone offer 
> insights on this issue?

You probably have all the required clocks on already from bootloader. If
they need to be on all the time, I guess you could just leave those clocks
out of the clock.c. But depending on the hardware you may also want to be
able to idle them.

Tony

--===============17817654605713384==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17817654605713384==--
