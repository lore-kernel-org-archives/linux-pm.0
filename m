From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH]switching off autosuspend through sysfs
Date: Fri, 26 Jan 2007 15:27:33 +0100
Message-ID: <200701261527.33767.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Greg KH <gregkh@suse.de>, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 24. Januar 2007 17:51 schrieb Alan Stern:
> > Hm, I missed that. =A0This seems to be a very usb-specific thing at the
> > moment.
> =

> It is USB-specific because I wanted to start out in a well-defined =

> environment where the mechanisms could get tested and shaken out. =A0When =

> the problems are gone, it will make sense to think about moving the whole =

> autosuspend infrastructure into the PM core.

USB has some advantages. There's only one level of suspend,
which is supposed to be mandatory. In addition, it's important for PM
because USB always means DMA.

	Regards
		Oliver

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
