From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 17:16:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510051711390.6810-100000@iolanthe.rowland.org>
References: <20051005204806.GD3306@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============028671522912600444=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005204806.GD3306@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============028671522912600444==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 5 Oct 2005, Adam Belay wrote:

> > IMO we could avoid the need for power_state by removing the guarantee
> > about never calling ->suspend when a device is already in a low-power
> > state.  The system sleep code could issue an optimistic ->suspend call,
> > and if that fails then do ->resume followed by ->suspend.
> 
> Another solution would be to make it entirely the driver's responsibility.
> We could just unconditionally issue ->suspend and it could be a noop if
> the device is already in a low power state.  If driver knows the device
> needs to be powered back on and then off again to complete the suspend
> transition then all of this can happen inside the ->suspend method.

Both are possible.  The core can call ->suspend, and if the driver needs 
to resume first and is able to do so, then it does.  Otherwise it returns 
an error and the core does the resume, then calls ->suspend again.

> I see ->suspend and ->resume as a way to notify drivers of userspace
> requests and system state changes.  The driver can determine its own
> actions for each of these requests.

That's the right idea.

> > (BTW, a theoretical advantage of passing a pm_message_t to ->resume is
> > that a driver could use the _same_ subroutine as a combined suspend/resume
> > method.  :-))
> 
> Yeah, this occured to me also.  Should we go for it?  What would we call it?
> (e.g. ->statectl()).

It's up to the individual driver.  We'll keep both method pointers in
struct device; the driver can set them to point at the same subroutine if
it wants.

Alan Stern


--===============028671522912600444==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============028671522912600444==--
