From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/2
Date: Sun, 24 Sep 2006 16:13:17 -0700 (PDT)
Message-ID: <20060924231317.5343.qmail@web82215.mail.mud.yahoo.com>
References: <20060924214517.GA1935@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1947917107=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060924214517.GA1935@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============1947917107==
Content-Type: multipart/alternative;
    boundary="----------=_1159139613-11034-411"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1159139613-11034-411
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline



Pavel Machek <pavel@ucw.cz> wrote:
  > PowerOP does *not* cover devices.  It covers system level parameters
> such clocks, buses, voltages.

I've seen "usb enabled" in one of examples.. and that sure seems like
device to me.
  Fundamentally though, USB can't be enabled when e.g. the 48 MHz
  digial PLL has been de-activated.  (Or whatever it uses on the relevant
  system.)  That's certainly a "system parameter".
  
  See for example
  
    http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/0427.html
  
  Re how-to-use, see current kernel GIT for drivers/usb/host/ohci-at91.c
  and understand that at91_suspend_entering_slow_clock() is equivalent
  to clk_must_disable(fclk) ... for AT91, "slow clock" means that the main
  oscillator (say, 3.6864 or 18.432 MHz) is off, leaving only the 32,768 Hz
  timekeeping clock.
  
  Note by the way that the clk_must_disable() model is **ORTHOGONAL** to
  power_op etc in that no matter how the run or sleep state ends up being
  transitioned to, such a call would be meaningful.  If an operating point
  or sleep state requires that the 48 MHz clock be disabled, so be it ...
  drivers have a simple implementation-neutral way to access that info.
  
  - Dave
  
  
------------=_1159139613-11034-411
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

<br><br><b><i>Pavel Machek &lt;pavel@ucw.cz&gt;</i></b> wrote:<br>  <blockquote class="replbq" DEFANGED_style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;">&gt; PowerOP does *not* cover devices.  It covers system level parameters<br>&gt; such clocks, buses, voltages.<br><br>I've seen "usb enabled" in one of examples.. and that sure seems like<br>device to me.<br>  </blockquote>Fundamentally though, USB can't be enabled when e.g. the 48 MHz<br>  digial PLL has been de-activated.&nbsp; (Or whatever it uses on the relevant<br>  system.)&nbsp; That's certainly a "system parameter".<br>  <br>  See for example<br>  <br>  &nbsp; http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/0427.html<br>  <br>  Re how-to-use, see current kernel GIT for drivers/usb/host/ohci-at91.c<br>  and understand that at91_suspend_entering_slow_clock() is equivalent<br>  to clk_must_
 disable(fclk) ... for AT91, "slow clock" means that the main<br>  oscillator (say, 3.6864!
 or
 18.432 MHz) is off, leaving only the 32,768 Hz<br>  timekeeping clock.<br>  <br>  Note by the way that the clk_must_disable() model is **ORTHOGONAL** to<br>  power_op etc in that no matter how the run or sleep state ends up being<br>  transitioned to, such a call would be meaningful.&nbsp; If an operating point<br>  or sleep state requires that the 48 MHz clock be disabled, so be it ...<br>  drivers have a simple implementation-neutral way to access that info.<br>  <br>  - Dave<br>  <br>  
------------=_1159139613-11034-411--

--===============1947917107==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1947917107==--
