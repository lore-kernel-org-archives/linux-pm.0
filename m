From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Sat, 19 Mar 2005 00:18:01 +0100
Message-ID: <20050318231801.GE24449@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503181147110.1099-100000@ida.rowland.org>
	<1111187278.1236.187.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95215026343470877=="
In-Reply-To: <1111187278.1236.187.camel@gaston>
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

--===============95215026343470877==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > Usually very fast.  Unfortunately for some kinds of USB host controllers 
> > it can be relatively slow, since quiescing the controller has an 
> > unavoidable side effect of suspending all devices on the bus.
> 
> I wonder if we need to quiesce the controller in fact for FREEZE.
> Probably not. Just stop all queue processing and refuse URBs. The hcca
> will still get updated, but who cares ? it will end up beeing saved in
> an inconsistent state in the suspend image, so what ? On resume, we will
> have rebooted, we can "clean it up".
> 
> This is sort-of breaking the rule of "no DMA", and thus is not suitable
> for kexec (which is ok, kexec currently uses the separate "shutdown"
> callback which must switch DMA off), but would fix the problem for
> suspend to disk...

What problem? suspend seems to +/- work with suspend-to-disk just
now. I'd really hate to have to think about "some memory may change
behind my back" during suspend. I think "no DMA" is a good rule.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============95215026343470877==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95215026343470877==--
