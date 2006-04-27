From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 08:20:09 +0000
Message-ID: <20060427082009.GD2376@ucw.cz>
References: <Pine.LNX.4.44L0.0604251626180.839-100000@iolanthe.rowland.org>
	<200604251730.34377.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47145278601716312=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251730.34377.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@cyclades.com>, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============47145278601716312==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > At the least it would depend on 
> > the particular state.  For instance, I've got a PCI USB controller card
> > (VIA) on which the UHCI controllers support only D0 and D3cold.  And
> > (although I'm not certain of this) I may have seen a report from someone
> > whose system _does_ retain power during swsusp.  IIRC it was a powerbook
> > of some sort.
> 
> I know that Macintoshes are good about maintaining power during STR, and
> suspect that some systems running Apple's OS will do so during "hibernate";
> they have a more complete/powerful power management framework than Linux.
> 
> But last time the topic came up, I recall Pavel saying he'd never seen or
> heard of hardware that did things like that with swsusp, even when using
> "platform" (or "firmware") suspend mode.

I have seen such macine since that. NAPA seems to keep usb powered
even when off. I think I'll just use it as cellphone charger :-).

							Pavel

-- 
Thanks, Sharp!

--===============47145278601716312==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============47145278601716312==--
