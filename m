From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Mon, 14 Mar 2005 00:20:02 +0100
Message-ID: <20050313232002.GC22635@elf.ucw.cz>
References: <20050313101453.GA4820@blackham.com.au>
	<20050313181225.GC1579@elf.ucw.cz>
	<1110754654.5787.187.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43140236973398505=="
In-Reply-To: <1110754654.5787.187.camel@gaston>
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
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============43140236973398505==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I guess has_pci_pm check should be killed from pci_choose_state. It is
> > probably going to create some problems elsewhere....
> 
> Definitely.

I fixed it in my tree, but I can't easily generate diffs just now (and
do not get as much testing as suspend2 :-). Bernard, could you remove
first two lines of pci_choose_state, verify it fixes uhci and submit
it as a patch? Oh and thanks for great detective work.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============43140236973398505==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43140236973398505==--
