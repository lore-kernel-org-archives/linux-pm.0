From: "Preece Scott-PREECE" <scott.preece@motorola.com>
Subject: RE: Re: Runtime PM and device locking
Date: Thu, 11 Aug 2005 10:24:41 -0400
Message-ID: <ADE4D9DBCFC3A345AAA95C195F62B6DD05A708@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54938523097605163=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============54938523097605163==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

As I understood it, the "parents" are simply things the device has
dependencies on. Since the dependencies are different, there is at least
potentially a benefit in being able to dismiss those dependencies
serially (that is, as the dependency on each device goes away, tell that
parental device that its parental role has been satisfied and that the
child is no longer depending on it as a parent).

scott

-----Original Message-----
From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Pavel Machek
Sent: Thursday, August 11, 2005 9:10 AM
To: Alan Stern
Cc: Linux-pm mailing list
Subject: Re: [linux-pm] Re: Runtime PM and device locking

Hi!

> > This solution is very similar to the power object tree patch I'm 
> > currently working on.  The main difference is that I'm using 
> > pre-state-change and post-state-change notification methods.  The 
> > advantage is that we should be able to use an iterative algorithm, 
> > allowing for deep power trees.  I'll post code soon.
> 
> I'm looking forward to seeing it.  However, I think an iterative 
> algorithm may be impractical, to a greater or lesser extent.  (Not to 
> mention the fact that in any particular case we never need both pre- 
> and post-
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

Ouch, thats really ugly. Is it really neccessary to do something to the
device just after notifying parent?

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


--===============54938523097605163==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54938523097605163==--
