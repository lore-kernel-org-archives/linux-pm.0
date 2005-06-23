From: "Leo L. Schwab" <lschwab@tapwave.com>
Subject: Clock Policy Goes Where?
Date: Thu, 23 Jun 2005 13:54:11 -0700
Message-ID: <42BB2173.2010101@tapwave.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59084186070064071=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============59084186070064071==
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

.	I'm working on an implementation of the ARM clock API for the Freescale 
i.MX1 (which is very crufty right now and only works on Zodiacs so there's 
not much point in asking for it (unless you want to critique it; I could use 
the feedback)), and I find myself wondering where the default clock settings 
should come from.

	Looking at the clock API for the TI OMAP (arch/arm/mach-omap/clock.c), I 
see a table of available clock frequencies.  The init code finds the fastest 
one and sets it.  Then it clk_use()s three other clocks.  Doesn't that 
constitute a policy decision?  If so, where should this policy reside?

	The reason I ask is because my first crack at a clock driver implementation 
had the clocks being disabled/spun down until a client showed up.  This 
seems fine until you discover that the serial console gets initialized *way* 
before the clock and serial drivers; that the UART clocks are effectively 
already in use, which in turn depend on PERCLK1, which in turn depends on 
SYSPLL.  OTOH, if you don't have the serial console configured, then you 
don't have to worry about any of that.

	All of which is a long-winded way of observing that the initial state of 
the clocks appears to this novice's eye to be policy-dependent.  In the case 
of the serial console, the policy is encoded in the kernel config and can be 
easily, if hackishly, handled.  Handling of other policies is less obvious 
(sticking them all in the kernel config seems wrong).  I would prefer to do 
The Right Thing here.  Can anyone offer insights on this issue?

					Schwab

--===============59084186070064071==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59084186070064071==--
