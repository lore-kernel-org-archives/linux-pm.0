From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.12-rc4] remove driver model detach_state
Date: Fri, 13 May 2005 00:31:52 -0700
Message-ID: <200505130031.52818.david-b@pacbell.net>
References: <200505121206.27981.david-b@pacbell.net>
	<20050512203704.GA25241@kroah.com>
	<20050512220632.GA4293@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============62398990563284107=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050512220632.GA4293@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============62398990563284107==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 12 May 2005 3:06 pm, Adam Belay wrote:
> 
> Although I agree with this patch, I think it's important that we don't
> forget about the code's original intentions.  When manual driver binding
> and unbinding is supported, it would be nice if we could specify a detach
> state.  My guess is that this should only include "on" or "off", but not
> any intermediate states.
> 
> ->remove isn't good enough, as the driver developer makes the decision
> "let's turn off the device before detaching" or "let's leave it on".
> This will vary between implementations. I think it may be better to
> allow the user to specify this.

Users haven't yet needed it ... or sysadmins either.  I don't see
why this should need any policy decisions at all.  If unused/idle
devices would just stay in low power modes all the time, then the
only issue would be buggy hardware ... and buggy hardware calls for
hardware-specific workarounds, always.  (Either in infrastructure
quirk code, or in the devices' drivers.)

For example, lots of ARM chips (in embedded hardware) leave most
things unclocked, and where relevant also powered down, until they're
needed.  That's just the way things are ... reset powers things
down, the bootloader (maybe something like U-Boot) turns on enough
to get Linux started, and then Linux turns on other things as
needed.

Many PCI devices could do the same thing, and stay in D3hot state
until some more active mode is needed.


> Finally, if the device is disabled, the configuration (e.g. PCI config
> space) may need to be restored for the device to work on a future
> driver.  This seems like a tricky problem if the driver is removed.

Drivers are expected to initialize using the current hardware state.
If they can't, it's a driver bug.  They normally leave PCI config
space alone.

- Dave

--===============62398990563284107==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============62398990563284107==--
