From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 11:32:38 +0100
Message-ID: <20050319103238.GL24449@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503181147110.1099-100000@ida.rowland.org>
	<1111187278.1236.187.camel@gaston>
	<20050318231801.GE24449@elf.ucw.cz>
	<1111195262.25179.201.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16567698893018501=="
In-Reply-To: <1111195262.25179.201.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============16567698893018501==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > This is sort-of breaking the rule of "no DMA", and thus is not suitable
> > > for kexec (which is ok, kexec currently uses the separate "shutdown"
> > > callback which must switch DMA off), but would fix the problem for
> > > suspend to disk...
> > 
> > What problem? suspend seems to +/- work with suspend-to-disk just
> > now. I'd really hate to have to think about "some memory may change
> > behind my back" during suspend. I think "no DMA" is a good rule.
> 
> Well, it's not that simple. It may work for you and not for others, and
> it will definitely introduce complications with the current scheme since
> it seems we +/- have to suspend USB busses (and possibly disconnect some
> devices) at freeze time...

Okay, I see that can be slow. Is there any other problem?

...and I probably would not want to suspend to my external usb2
disk... Ok, that might be small problem.
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============16567698893018501==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16567698893018501==--
