From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: suspend/resume uevents [was Re: Introducing HAL
	userspace power management]
Date: Sat, 12 Mar 2005 07:39:34 +1100
Message-ID: <1110573574.32510.2.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0503071125001.1378-100000@ida.rowland.org>
	<1110411138.7779.86.camel@daxter.boston.redhat.com>
	<20050309233556.GO17034@elf.ucw.cz>
	<1110426926.3443.3.camel@daxter.boston.redhat.com>
	<20050310095629.GA13444@elf.ucw.cz>
	<1110476278.3404.60.camel@daxter.boston.redhat.com>
	<20050310211320.GG632@openzaurus.ucw.cz> <4230BCB9.7070005@suse.de>
	<20050310230008.GB10954@elf.ucw.cz> <42317A81.8050205@suse.de>
	<20050311110619.GK1705@elf.ucw.cz>  <4231872F.9040101@suse.de>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============034701645831829886=="
In-Reply-To: <4231872F.9040101-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Stefan Seyfried <seife-l3A5Bk7waGM@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============034701645831829886==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Fri, 2005-03-11 at 22:55, Stefan Seyfried wrote:
> Pavel Machek wrote:
> > Hi!
> 
> > I'm afraid this is racy by default. Machine resumes, then Xscreensaver
> > is being told that it should lock, but bad user may type in console in
> > meantime or something.
> 
> i do of course lock the screen before suspend, but some screensavers are
> not synchronous and take some time to actually lock. It is a mess.
> 
> > Synchronous notification *before* suspend might do the trick,
> > through. Tell Xscreensaver to lock, wait for it to lock, only then
> > proceed with suspend. That seems only safe solution.
> 
> Yes, but you'll need another ~10 seconds until power off.
> Both xscreensaver and kde screensaver are not from the speedy department :-(

There's an xset to activate the screensaver too - and to force it to
lock if you want.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============034701645831829886==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============034701645831829886==--
