From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Some thoughts on suspend/resume development
Date: Fri, 11 Mar 2005 23:42:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0503112341030.7509-100000@netrider.rowland.org>
References: <1110586718.12485.234.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98692621125795466=="
In-Reply-To: <1110586718.12485.234.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============98692621125795466==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 11 Mar 2005, Adam Belay wrote:

> > > Now, that was probably bad example, but I do think some devices might
> > > do usefull work even with their parents disabled.
> 
> Yes, but at a logical (class) level the parent device would never be
> disabled, right?  I guess it would be possible to model such a situation
> if we take advantage of the driver class design.  I hadn't considered it
> before, but I'll try to keep it in mind.  It would be interesting to see
> how common it might be.
> 
> > 
> > There's another aspect to it as well.  You can suspend the USB host
> > controller and then _still_ use the external disk, if the host controller
> > is automatically resumed when the next disk I/O request arrives.  Whereas
> > if you would stop the disk and its driver, the next I/O request might
> > simply languish in a plugged queue.  I suppose this would depend on
> > whether the disk driver was smart enough to leave its queue unplugged
> > under the right circumstances, so perhaps this isn't a great example.  
> > (And you're right about the possibility of data being lost -- although
> > it's pretty unlikely -- which makes this an even worse example.)
> > 
> > Alan Stern
> 
> Yes, so I think if we ensure that the parent device is enabled at a
> logical level, and that the power source is active, it would be possible
> to do such a thing.  I'm guessing this is something not to worry about
> too much now; do you think so?

Agreed.  As Patrick said, this is a corner case.

Alan Stern


--===============98692621125795466==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============98692621125795466==--
