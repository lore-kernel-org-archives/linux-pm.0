From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Mon, 14 Mar 2005 09:08:27 +0100
Message-ID: <20050314080827.GG22635@elf.ucw.cz>
References: <20050313101453.GA4820@blackham.com.au>
	<20050313232002.GC22635@elf.ucw.cz>
	<20050314022308.GD6008@blackham.com.au>
	<200503132003.27555.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94650910217910367=="
In-Reply-To: <200503132003.27555.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============94650910217910367==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Ne 13-03-05 20:03:27, David Brownell wrote:
> On Sunday 13 March 2005 6:23 pm, Bernard Blackham wrote:
> > On Mon, Mar 14, 2005 at 12:20:02AM +0100, Pavel Machek wrote:
> > > > > I guess has_pci_pm check should be killed from pci_choose_state. It is
> > > > > probably going to create some problems elsewhere....
> 
> What tree are you talking about?  The code I'm seeing doesn't use that
> anywhere near USB, so by definition it can't matter.  That's the
> latest linux-2.5 tree... where FWIW I observe that pci_choose_state()
> is unusably stupid, it will gladly return power states that the
> hardware doesn't support.  That is **NOT** what the original patch
> with that routine did.
> 
> 
> You need to change the USB PM stuff with extreme caution, else you'll
> break it's ability to be a wakeup source, or handle selective suspend.
> As well as its ability to work with the various different PM configs
> that are possible with even minimal selection of BIOS, kernel, hardware,
> and module config options.

UHCI worked okay before. I'll really need to make pci_choose_state
"NOP" in the current code, so that it can be safely added to the
existing drivers.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============94650910217910367==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94650910217910367==--
