From: "Jordan Crouse" <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 12:37:25 -0700
Message-ID: <20050323123725.201d8a67@cosmic.amd.com>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<1111465290.27490.34.camel@gaston>
	<200503231058.54311.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54017693396607935=="
In-Reply-To: <200503231058.54311.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

--===============54017693396607935==
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 23 Mar 2005 10:58:54 -0800
"David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> So, two types of request to drivers then.  The main one would be to
> become compatible with a given system power state; flexible.  The
> inflexible one would be to go into a specific device power state.

I like the idea of the flexible request.  This would add the ability for
the policy to individually manage devices that for one reason or another
cannot or should not enter a power state compatible with the system
power state. 

As an illustrative example, I'm thinking of a fictitious VoIP phone with
an audio device that has an abnormally large latency resuming from a
clocks off power state, so by the time it wakes up and is ready to go,
the incoming call is lost.  At this point, the user/developer/designer
could decide that the the extra power consumed by leaving the clocks on
is less important then having a responsive device, and the policy is set
so that the device only enters a D1 state with a suspend-to-ram system
power state, rather then a D3 state as it normally would (pardon the
PCI/ACPI terms, they're just for simplicity).

In that case, even though the device state wouldn't technically be
compatible with the given system state, it would still be the
best fit for the platform as a whole.

Jordan




--===============54017693396607935==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54017693396607935==--
