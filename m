From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: uhci-hcd suspend/resume under the new driver model
Date: Sun, 13 Mar 2005 19:12:25 +0100
Message-ID: <20050313181225.GC1579@elf.ucw.cz>
References: <20050313101453.GA4820@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============37440366828381433=="
In-Reply-To: <20050313101453.GA4820-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============37440366828381433==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> One of the problems Suspend2 is running into with the driver model
> changes, is uhci-hcd doesn't suspend and resume correctly. The
> problem is that in the changes to usb_hcd_pci_suspend in hcd-pci.c,
> we now use pci_choose_state to obtain the PCI power state to put the
> machine into. It affects uhci-hcd because it does not have the
> PCI_CAP_ID_PM capability bit set.
> 
> Before the new driver model, state would be 3 (passed directly to
> the function), and the function would run with state D3hot, and
> has_pci_pm false.  With these changes however, pci_choose_state sees
> the lack of PCI_CAP_ID_PM and returns state D0 instead of D3hot.
> Hence the function runs as if suspending into D0, and doesn't do the
> suspend as it should.
> 
> My hack (attached), fixes the suspend function to proceed with the
> suspend even if state is D0, if it sees that has_pci_pm is false. It
> resolves the suspend/resume issues, but it's probably not the
> cleanest solution, as it relies on the fact that the suspend
> function is only there to put the device into D3hot (and not any
> other power state).
> 
> Other drivers that lack PCI_CAP_ID_PM probably have the same
> problem, and I thought you might have a cleaner solution. Any
> suggestions? :)

I guess has_pci_pm check should be killed from pci_choose_state. It is
probably going to create some problems elsewhere....

								Pavel


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============37440366828381433==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============37440366828381433==--
