From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 18:20:57 +0100
Message-ID: <20051223172057.GA15357@elf.ucw.cz>
References: <Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0512231122310.17020-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97523352435085009=="
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

--===============97523352435085009==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >  All you
> > have to do for each suspend routine is mimic that effect. It arguably
> > doesn't require any serious knowledge about the device - it only needs a
> > copy of the ->probe() and ->remove() routines (or the functional
> > equivalent for those devices), without the allocation and freeing of data
> > structures.
> 
> Why go to all the trouble of copying probe and remove when we can call the
> actual existing routines?

Well, if you can find some elegant solution in the core, I think thats
the best way.

You could set system_state to "suspending" or something like that, and
just if() out notifications in that case.
								Pavel

-- 
Thanks, Sharp!

--===============97523352435085009==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97523352435085009==--
