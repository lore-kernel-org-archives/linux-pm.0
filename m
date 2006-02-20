From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC][PATCH] swsusp: warn about USB devices in
	documentation
Date: Mon, 20 Feb 2006 21:41:05 +0100
Message-ID: <20060220204105.GC21557@elf.ucw.cz>
References: <Pine.LNX.4.50.0602201151350.13570-100000@monsoon.he.net>
	<Pine.LNX.4.44L0.0602201526330.28136-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92864120950724383=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602201526330.28136-100000@netrider.rowland.org>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============92864120950724383==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 20-02-06 15:30:16, Alan Stern wrote:
> On Mon, 20 Feb 2006, Patrick Mochel wrote:
> 
> > > And if the computer can wake up in response to USB events, then obviously
> > > the USB controller _is_ receiving some power.
> > 
> > True, and I apologize if I misunderstood your initial question. By "up", I
> > thought you meant fully powered and functional.
> 
> No; in the context of this thread I merely meant suspend-power was
> present.  Pavel had said that a machine which supplies any USB power at
> all during swsusp is broken.  I was trying to show this isn't so.

I take that back. I still claim it is unusal ;-).
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

--===============92864120950724383==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92864120950724383==--
