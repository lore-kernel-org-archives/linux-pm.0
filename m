From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Some thoughts on suspend/resume development
Date: Fri, 11 Mar 2005 11:42:02 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503111133040.1203-100000@ida.rowland.org>
References: <20050311084733.GB1705@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============52054151377122015=="
In-Reply-To: <20050311084733.GB1705-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Adam Belay <amb-YszlSufgerXQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============52054151377122015==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 11 Mar 2005, Pavel Machek wrote:

> > This is why I'm in favor of power domains (power parents and children
> > that can be independent of physical device relations).  Power domains
> > are common for internal devices, not just external devices.  Still, if
> > you disable a physical parent, then the device is no longer operational.
> > Disable the usb host controller, and the external disk drive cannot be
> > used (in fact data may be lost).  So it's necessary to stop every child
> > device first, and generally also power it off if we can control the
> > power source.
> 
> I just don't see it like that.
> 
> Remember old scsi disks where formatting took half an hour? You may do
> something like
> 
> invoke scsi format operation
> power down usb controller
> <half an hour later>
> power up usb controller
> get the results
> 
> Now, that was probably bad example, but I do think some devices might
> do usefull work even with their parents disabled.

There's another aspect to it as well.  You can suspend the USB host
controller and then _still_ use the external disk, if the host controller
is automatically resumed when the next disk I/O request arrives.  Whereas
if you would stop the disk and its driver, the next I/O request might
simply languish in a plugged queue.  I suppose this would depend on
whether the disk driver was smart enough to leave its queue unplugged
under the right circumstances, so perhaps this isn't a great example.  
(And you're right about the possibility of data being lost -- although
it's pretty unlikely -- which makes this an even worse example.)

Alan Stern


--===============52054151377122015==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============52054151377122015==--
