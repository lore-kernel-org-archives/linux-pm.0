From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RE: on-ness
Date: Thu, 20 Apr 2006 13:25:43 +0000
Message-ID: <20060420132542.GA2668@ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41499902880835537=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Brown, Len" <len.brown@intel.com>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============41499902880835537==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> (restored linux-pm to cc:)

> no, if the numbers happen to corrolate to ACPI states,
> that is purely lucky for the ACPI maintainer:-)
> But honestly, we should "leverage" all we can from ACPI.
> My role, of course, it to make sure that the generic
> description can accommodate everything ACPI can do.

Please, put there translation layer from the begining. Otherwise
people will assme they *are* ACPI states, and great confusion will
begin.

See suspend functions, where half people assumed they are acpi Dx
states, half people thought they are pci Dx states, and half the
people assumed they are system Sx states.


It took quite long to sort out.

> yes, idle refers to either Cx or Dx states -- it depends
> on the device.  0 means operating, non zero means non-operating.
> 
> Re: strings.
> we breifly debated strings vs numbers.
> I'm not confident that there are enough unique strings
> available without falling into state0, state1, state2, state3 --
> so numbers seemed simpler.
> The only issue I see with numbers is that they imply order,
> and it may be that some operating points might not have
> such a strict order.

Second issue is that you might want to "insert" between states.

Lets look at disk. Old disks had:

spinning
spindown

states. You'd name them 0 and 1, eventually apps will learn to use
that. But (some) newer disks have

spinning
slowspin
spindown

if app does echo 1 > state, it will get slowspin instead of spindown
it wanted.

Yes, inventing good names may be tricky in some cases, but in other
cases names are very natural (arm has sleep, deep sleep and big sleep,
iirc).... And we can always fall back to state0..state5.

						Pavel
-- 
Thanks, Sharp!

--===============41499902880835537==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41499902880835537==--
