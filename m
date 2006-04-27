From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 08:16:51 +0000
Message-ID: <20060427081651.GC2376@ucw.cz>
References: <200604251037.13714.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0604251626180.839-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============10386349452830546=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0604251626180.839-100000@iolanthe.rowland.org>
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
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============10386349452830546==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I'd put it differently.  It's not a poor-man's way at all; passing that
> > information in hardware is the correct solution.  A regular resume would
> > keep the information there too (from STR or standby).  We don't want to
> > have swsusp piling on special cases.
> 
> Okay, I take it back.  Yes, putting the hardware into the appropriate 
> state is the right thing to do.
> 
> On the other hand, it might not be so easy to know what that state is.  
> Perhaps the decision should be left up to the device driver.  If drivers
> were told the difference between "FREEZE to prepare for creating a memory
> snapshot" and "FREEZE to prepare for restoring a memory image" then they 
> could do the right thing always.

Add flags field to pm_message_t, please. There, you have way to pass
down that ino while staying back-compatible.

-- 
Thanks, Sharp!

--===============10386349452830546==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============10386349452830546==--
