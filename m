From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Runtime PM and device locking
Date: Thu, 11 Aug 2005 16:10:19 +0200
Message-ID: <20050811141019.GA16264@elf.ucw.cz>
References: <20050808164111.GA7276@neo.rr.com>
	<Pine.LNX.4.44L0.0508081645010.4470-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61777045657307728=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508081645010.4470-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============61777045657307728==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > This solution is very similar to the power object tree patch I'm currently
> > working on.  The main difference is that I'm using pre-state-change and
> > post-state-change notification methods.  The advantage is that we should
> > be able to use an iterative algorithm, allowing for deep power trees.  I'll
> > post code soon.
> 
> I'm looking forward to seeing it.  However, I think an iterative algorithm 
> may be impractical, to a greater or lesser extent.  (Not to mention the 
> fact that in any particular case we never need both pre- and post- 
> notifications.)
> 
> Consider a device that has many power parents (P1 - Pn).  A typical 
> power-state change for this device might have to go like this:
> 
> 	Do something to the device.
> 
> 	Notify P1.
> 
> 	Do some more to the device.
> 
> 	Notify P2.
> 
> 	Do some more to the device.
> 
> 	...
> 
> 	Notify Pn.
> 
> 	Do the last thing to the device.

Ouch, thats really ugly. Is it really neccessary to do something to
the device just after notifying parent?

I thought it would be more like

mouse
	"oh, I'm idle".
	power myself down. 
	tell all my parents that they can power down my cord.

If something is neccessary to be done after changing parent state, I'd
do it during call from parent.
								Pavel


-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============61777045657307728==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61777045657307728==--
