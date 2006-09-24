From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend and slight video corruption
Date: Sun, 24 Sep 2006 09:41:53 +0000
Message-ID: <20060924094153.GA4057@ucw.cz>
References: <20060921210244.GB5888@excelhustler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060921210244.GB5888@excelhustler.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I'm trying to use suspend to disk in a MacBook Pro and am having an odd i=
ssue:
> =

> colors get corrupted -- but only slightly -- after a resume.  The screen
> appears as if it just dropped from 24-bit color mode to 8-bit color mode
> and is doing a poor job of dithering.
> =

> The problem is most easily visible with an image such as
> http://debblue.debian.net/images/debblue/gdm-debblue.png.  Before a
> suspend, it looks fine.  After a suspend, there are concentric circles
> going out from the center with hard-edged color changes.  With many
> things, this problem is not even noticable.  I wouldn't be surprised if
> this has happened to many before without being detected.
> =

> This happens no matter what viewer I am using to display the image in X.
> It also persists even if I restart the viewer, switch to the console and
> back, etc.  But restarting the X server fixes it.
> =

> I tried running xinit /bin/false -- :1, but that hung the machine (it
> does not hang the machine when run before a suspend).
> =

> I have tried both uswsusp and suspend2 and get the same results with
> each.
> =

> This is a Debian etch system, kernel.org 2.6.18 (with the small
> mactel-linux patches), booting without EFI, XOrg 7.0.0, ATI fglrx driver
> 8.28.8.

You are using ati closed video drivers, experience video problem, and
expect us to help? Huh? Ask ATI.
-- =

Thanks for all the (sleeping) penguins.
