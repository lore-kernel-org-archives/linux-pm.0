From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 10:08:39 -0800
Message-ID: <200503241008.39984.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503240933.49123.david-b@pacbell.net>
	<Pine.LNX.4.50.0503240937150.13683-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73773625405544596=="
In-Reply-To: <Pine.LNX.4.50.0503240937150.13683-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============73773625405544596==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 24 March 2005 9:41 am, Patrick Mochel wrote:
> 
> 
> That's a bit of a stretch. While it's true that some devices can generate
> wakeup interrupts, they are not servicing normal requests. Enabling the
> wakeup events seems to imply disabling other services.

There's not much distinction between wakeup irqs and "normal" ones.
Normally they're one and the same.  (That's not OMAP-specific.)


> It sounds like in the case you speak of, the devices are still doing
> 'normal' work, but it also seems like that normal work is self-contained
> in the device and doesn't need any code executed on a CPU to do so (like
> via an ISR).

Well, the IRQ would transition the SOC out of say "big sleep", then the
ISR would run.  (I'm not sure whether DMAs can stay active in big sleep.)

Just this morning I saw an experimental patch teaching the smc91x Ethernet
driver -- external chip, hooked up to many OMAP devel boards -- to setup
its GPIO IRQ line as a wakeup IRQ.  So the normal work of receiving
and transmitting packets using that chip's local buffers could go on while
the SOC went to sleep.

You're right, it sounds _just_ like that!  :)


One reason I mentioned the AT91rm9200 is because it has a "slow clock mode"
where the CPU itself is running at 32KHz.  Variations on a low-power theme.

- Dave

--===============73773625405544596==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73773625405544596==--
