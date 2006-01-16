From: Pavel Machek <pavel@suse.cz>
Subject: Re: Suspend to RAM and disk
Date: Mon, 16 Jan 2006 21:11:48 +0100
Message-ID: <20060116201147.GP1666@elf.ucw.cz>
References: <20060116114037.GA26986@elf.ucw.cz>
	<200601162106.42512.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76806374185799786=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601162106.42512.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: seife@suse.de, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============76806374185799786==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 16-01-06 21:06:41, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 16 January 2006 12:40, Pavel Machek wrote:
> > In good old days of Pentium MMX, when ACPI was not yet born and APM
> > ruled the world, I had and thinkpad 560X notebook. And that beast
> > supported suspend-to-both: It stored image on disk, but then suspended
> > to RAM, anyway. I think I want that feature back.
> > 
> > [Advantage was, that suspend/resume was reasonably fast for common
> > case, yet you did not loose your opened applications if your battery
> > ran flat. Speed advantage will be even greater these days -- boot of
> > "resume" kernel takes most of time.]
> > 
> > Unfortunately, suspend-to-RAM is not in quite good state these
> > days. It tends to work -- after you setup your video drivers according
> > to video.txt, with some scripting needed. Unfortunately, after we
> > suspended to disk, system is frozen -- we may not run scripts.
> > 
> > I guess the solution is to create userland application that will parse
> > the DMI, look into table, and if it is neccessary do the vbe
> > saving/restoring itself. (We may not run external binaries on frozen
> > system; everything has to be pagelocked.) I guess that will include
> > quite a lot of cut-copy-and-paste from various project, but I see no
> > other way :-(.
> 
> Yes, I think we could embed the s2ram preparation in the suspending
> application, and program it to operate like that:
> 1) freeze
> 2) call atomic snapshot
> 3) save the image
> 4) prepare s2ram
> 5) suspend to RAM
> 6) sleep
> 7) wake up (this would unfreeze processes too, if successful)
> 8) zap the image header

Yep, that's the way go. Unfortunately s2ram is little complicated by
need to save video state. Usually s2ram is done by script, and
embedding means it needs to be done in C. So I'll hack C program to
s2ram the machine.

> This would play some ping-pong with devices that would be suspended,
> woken up and then suspended again before s2ram, but I don't think that's
> avoidable in the current state of things.

We'll eventually need to do something with device ping-pong --
devices/highmem take as long as saving to disk in my case...

							Pavel
-- 
Thanks, Sharp!

--===============76806374185799786==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76806374185799786==--
