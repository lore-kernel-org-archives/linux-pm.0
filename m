From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Devices eating too much power [was Re: Some thoughts
	on suspend/resume development]
Date: Sun, 13 Mar 2005 19:14:55 +0100
Message-ID: <20050313181455.GD1579@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0503091111470.1117-100000@ida.rowland.org>
	<1110403931.8870.6.camel@desktop.cunningham.myip.net.au>
	<20050309214416.GG17034@elf.ucw.cz>
	<1110405336.8870.22.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60792205593996052=="
In-Reply-To: <1110405336.8870.22.camel-r49W/1Cwd2ff0s6lnCXPX/uOuaPYTxhvJwvTLr3MMZM@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============60792205593996052==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > This isn't to say that we should copy Windows.  However it does show that 
> > > > a very complex set of controls might not be needed.
> > 
> > Actually, as we already spindown and blank settings, we could finish
> > here :-).
> > 
> > What devices is this targetted at? Video should be handled
> > already (or perhaps we want to power down graphics card when screen is
> > blanked?). Disks spin down too. IRDA ports?
> 
> - Video

X/dpms handles these already.

> - Storage

laptop mode.

> - Hotplug devices
> - CPU power savings

cpufreq.

> - Scanner lights

Ok ;-).

> Anything you might care to imagine :>

Well, I meant something that is not already handled. Like... what
power-hungry device do we fail to properly handle today?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============60792205593996052==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============60792205593996052==--
