From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 18:13:05 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503231810400.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<Pine.LNX.4.50.0503221635130.16154-100000@monsoon.he.net>
	<200503231106.03160.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59318691029979531=="
In-Reply-To: <200503231106.03160.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============59318691029979531==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 23 Mar 2005, David Brownell wrote:

> On Tuesday 22 March 2005 4:52 pm, Patrick Mochel wrote:
> > >
> > I think the core should always call ->suspend() for a device, regardless
> > of whether it thinks it's in a low power state, or inactive. This is
> > specifically for the reason that a device could be a low-power runtime
> > state when the system is suspended.
>
> I don't quite see a need for this.  If the parent/bridge driver knows
> the device is adequately suspended, why kick it again?  It's actually
> rather annoying -- and error/bug prone! -- to have to code drivers to
> detect and cope with superfluous suspend calls.

The call doesn't need to actually kick the device. It just needs to check
some state field in the device object. My point was that the core
shouldn't differentiate between not-suspended and suspended devices.

Note that this point would be moot if we moved to a complete bus-centric
view of the tree. We wouldn't care about individual devices; we would just
call the bridge drivers, which could do their own checking on which
devices were suspended and needed to be called. Note that that would be
very trivial with lists of devices in each particular state, like I just
suggested. :)


	Pat

--===============59318691029979531==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59318691029979531==--
