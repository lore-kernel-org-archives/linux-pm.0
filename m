From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 16:21:42 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5074D05F9@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> > > ?  Wouldn't suspending the entire bus completely stop the
throughput
> > of
> > > any attached device?
> >
> > Not necessarily (right?).  If I shut off VBUS then yes then I need
to
> > re-enumerate for sure.  One might figure out a cleaver way of
shutting
> > it off and turning it back on in between host requests.
> =

> No, you can't do that.  Without VBUS power there's no reliable way to
> detect disconnects or media changes.

That's a good point.  I wonder in this case if it is possible to keep a
list of what was there.  When you re-power if its not there, it should
be like it was disconnected, then act accordingly.  If it is there all
is ok.  It seems unlikely that the same PID/VID device would have
replaced it.  New devices would show up as not being there before.

Coding that all up would likely be a bunch of work assuming it was
possible.


Thanks,
Richard W.
 =
