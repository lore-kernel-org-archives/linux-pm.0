From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Sun, 13 Mar 2005 20:03:27 -0800
Message-ID: <200503132003.27555.david-b@pacbell.net>
References: <20050313101453.GA4820@blackham.com.au>
	<20050313232002.GC22635@elf.ucw.cz>
	<20050314022308.GD6008@blackham.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============84790272164943192=="
In-Reply-To: <20050314022308.GD6008-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============84790272164943192==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 13 March 2005 6:23 pm, Bernard Blackham wrote:
> On Mon, Mar 14, 2005 at 12:20:02AM +0100, Pavel Machek wrote:
> > > > I guess has_pci_pm check should be killed from pci_choose_state. It is
> > > > probably going to create some problems elsewhere....

What tree are you talking about?  The code I'm seeing doesn't use that
anywhere near USB, so by definition it can't matter.  That's the
latest linux-2.5 tree... where FWIW I observe that pci_choose_state()
is unusably stupid, it will gladly return power states that the
hardware doesn't support.  That is **NOT** what the original patch
with that routine did.


You need to change the USB PM stuff with extreme caution, else you'll
break it's ability to be a wakeup source, or handle selective suspend.
As well as its ability to work with the various different PM configs
that are possible with even minimal selection of BIOS, kernel, hardware,
and module config options.

(If you spend less than a couple weeks full time testing out those
different combinations, you'll surely miss some essential ones...)


> > > Definitely.
> > 
> > I fixed it in my tree, but I can't easily generate diffs just now (and
> > do not get as much testing as suspend2 :-). Bernard, could you remove
> > first two lines of pci_choose_state, verify it fixes uhci and submit
> > it as a patch?
> 
> Not happy yet. Passing D0 to uhci suspend's method is the cause of
> the issue (it doesn't handle it particularly well), and D0 is also
> passed when PMSG_FREEZE is sent. So while it works for entering S3,
> it fails in the same way when preparing for the atomic copy in S4.

Last I heard, UHCI still wasn't expected to behave with PM active.
OHCI and EHCI were, although there are likely some platforms that
have issues.  And various changes to usbcore may have borked some
things; it's clearly time to spend another couple weeks testing.

- Dave



> Hacking around the issue by always using D3hot should return it back
> to the pre-drivermodel behaviour and mostly works. However at least
> one person has reported that even doing this, uhci_hcd alone
> suspends fine, but if both uhci_hcd and ehci_hcd are loaded, USB is
> dead on resume until reloading both modules. I'm still digging
> deeper and may need to enlist the help of linux-usb-devel...
> 
> I'll let you know when I have something cleaner that works for
> everyone.
> 
> Bernard.
> 
> -- 
>  Bernard Blackham <bernard at blackham dot com dot au>
> 

--===============84790272164943192==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============84790272164943192==--
