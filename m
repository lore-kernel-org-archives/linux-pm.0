From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Some thoughts on suspend/resume development
Date: Fri, 11 Mar 2005 19:18:38 -0500
Message-ID: <1110586718.12485.234.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0503111133040.1203-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2396119954232363=="
In-Reply-To: <Pine.LNX.4.44L0.0503111133040.1203-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============2396119954232363==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-03-11 at 11:42 -0500, Alan Stern wrote:
> On Fri, 11 Mar 2005, Pavel Machek wrote:
> 
> > > This is why I'm in favor of power domains (power parents and children
> > > that can be independent of physical device relations).  Power domains
> > > are common for internal devices, not just external devices.  Still, if
> > > you disable a physical parent, then the device is no longer operational.
> > > Disable the usb host controller, and the external disk drive cannot be
> > > used (in fact data may be lost).  So it's necessary to stop every child
> > > device first, and generally also power it off if we can control the
> > > power source.
> > 
> > I just don't see it like that.
> > 
> > Remember old scsi disks where formatting took half an hour? You may do
> > something like
> > 
> > invoke scsi format operation
> > power down usb controller
> > <half an hour later>
> > power up usb controller
> > get the results
> > 
> > Now, that was probably bad example, but I do think some devices might
> > do usefull work even with their parents disabled.

Yes, but at a logical (class) level the parent device would never be
disabled, right?  I guess it would be possible to model such a situation
if we take advantage of the driver class design.  I hadn't considered it
before, but I'll try to keep it in mind.  It would be interesting to see
how common it might be.

> 
> There's another aspect to it as well.  You can suspend the USB host
> controller and then _still_ use the external disk, if the host controller
> is automatically resumed when the next disk I/O request arrives.  Whereas
> if you would stop the disk and its driver, the next I/O request might
> simply languish in a plugged queue.  I suppose this would depend on
> whether the disk driver was smart enough to leave its queue unplugged
> under the right circumstances, so perhaps this isn't a great example.  
> (And you're right about the possibility of data being lost -- although
> it's pretty unlikely -- which makes this an even worse example.)
> 
> Alan Stern

Yes, so I think if we ensure that the parent device is enabled at a
logical level, and that the power source is active, it would be possible
to do such a thing.  I'm guessing this is something not to worry about
too much now; do you think so?

Thanks,
Adam



--===============2396119954232363==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============2396119954232363==--
