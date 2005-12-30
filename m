From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 12:46:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512301243540.32015-100000@netrider.rowland.org>
References: <1135824932.4774.20.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89063050593145832=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1135824932.4774.20.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============89063050593145832==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 29 Dec 2005, Nigel Cunningham wrote:

> > Often the device-specific resume routine doesn't have the information
> > needed for checking whether the device is still there.  Such checks are 
> > done by generic bus-oriented routines.
> > 
> > Yes, the bus's resume handler can do such a check.  Why should it bother,
> > when other parts of the bus code will detect the device removal in the
> > normal course of events?  Or alternatively, why shouldn't the bus's resume
> > handler simply invoke those other parts of the bus code when it determines
> > that a device has been removed?
> 
> I guess because the resume routine is almost certainly the first piece
> of code that will try to access the hardware (and possibly choke and die
> it it's not there).

Obviously we want the resume routine to be robust enough not to die if the 
device was removed while the system was suspended.  :-)

As for the rest, however, it simply is not resume()'s job to check whether 
the device is still there.  That job belongs to another piece of code.

Consider this: What would happen if the system _hadn't_ been suspended 
when the device was removed?  Why shouldn't the same thing happen if the 
system _is_ suspended when the device is removed?

Alan Stern


--===============89063050593145832==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89063050593145832==--
