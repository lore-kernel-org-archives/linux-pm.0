From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Wed, 23 Mar 2005 11:46:16 -0800
Message-ID: <200503231146.17105.david-b@pacbell.net>
References: <1111113131.25179.73.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34702737394517946=="
In-Reply-To: <1111113131.25179.73.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============34702737394517946==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 17 March 2005 6:32 pm, Benjamin Herrenschmidt wrote:

> BTW. David, can't your clock stuff be simply represented in terms of bus & device states as
> well ? In most case, it's not PCI, so it could be defined as special bus types with states
> matching the various clock states.

It's not "my" clock stuff ... I don't design hundreds of chips!  ;)

Yes and no.  I described a canonical situation in IRC, as applied to
certain devices.  A given device state has consequences in terms of
clock usage.  Using ACPI terminology, it'd be straightforward to
support D0 (operational), D2 (suspend), and D3 (poweroff) states
for many peripherals.  And folk are using platform_bus for this,
nothing special is necessary.

Thing is, it's the system power states that are placing clock
constraints on devices.  On OMAP, going into "deep sleep" means
you've got to stop using the 48 MHz clock.  For "big sleep",
you can keep using that clock.  Most other CPUs have similar
constraints:  multiple system states, defined primarily by
clock usage.  (Discussing off-chip peripherals like LCDs and
backlights adds some orthogonal dimensions.

- Dave

--===============34702737394517946==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34702737394517946==--
