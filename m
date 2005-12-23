From: Greg KH <greg@kroah.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 13:28:27 -0800
Message-ID: <20051223212827.GA17350@kroah.com>
References: <20051223172057.GA15357@elf.ucw.cz>
	<Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============748153236283983=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============748153236283983==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2005 at 04:22:44PM -0500, Alan Stern wrote:
> On Fri, 23 Dec 2005, Pavel Machek wrote:
> 
> > Well, if you can find some elegant solution in the core, I think thats
> > the best way.
> > 
> > You could set system_state to "suspending" or something like that, and
> > just if() out notifications in that case.
> 
> How about simply adding a call to try_to_freeze() somewhere inside 
> kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much 
> what I want, in theory.  The hotplug processes would get frozen before 
> /sbin/hotplug is exec'ed.

On modern distros, /sbin/hotplug is set to NULL, so this isn't an issue.
We use netlink to send the data out, so this might not even be a problem
anymore...

thanks,

greg k-h

--===============748153236283983==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============748153236283983==--
