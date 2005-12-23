From: Greg KH <greg@kroah.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 11:40:54 -0800
Message-ID: <20051223194053.GA15865@kroah.com>
References: <Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0512231122310.17020-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79401518870897503=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512231122310.17020-100000@netrider.rowland.org>
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

--===============79401518870897503==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2005 at 11:52:03AM -0500, Alan Stern wrote:
> > I don't find justification to your argument in avoiding to fix drivers. We
> > don't change the core when it means the impact would be to change every
> > driver. And, we shouldn't change the core to avoid fixing a subset of
> > drivers. The number of drivers that it affects should not be 100% of them.
> 
> The issue of registering and unregistering devices during a sleep 
> transition has come up before.  It's not going to go away.  We should 
> find a good way to deal with it.  Changing the core hotplug support so 
> that new unfrozen processes don't get started up while everything else is 
> frozen seems to me like a fairly small, cheap way of getting things to 
> work properly.
> 
> Furthermore, Greg KH has stated that many (or even most) USB drivers 
> shouldn't need to have special support for suspend/resume added.  I'm not 
> sure whether he intended that these drivers should be unbound during a 
> suspend, but that's the easiest way to handle them.

No, my main point was that we can not abort the syspend sequence just
because a USB driver does not have a suspend/resume callback.  That is
what was happening in the tree at the time, and a lot of different users
complained about it.

And yes, I don't mind if we just unbind those drivers from devices at
suspend, as for USB that's probably the easiest way.

thanks,

greg k-h

--===============79401518870897503==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79401518870897503==--
