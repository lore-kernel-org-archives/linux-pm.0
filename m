From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Mon, 14 Mar 2005 10:23:08 +0800
Message-ID: <20050314022308.GD6008@blackham.com.au>
References: <20050313101453.GA4820@blackham.com.au>
	<20050313181225.GC1579@elf.ucw.cz>
	<1110754654.5787.187.camel@gaston>
	<20050313232002.GC22635@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============18364560816036235=="
In-Reply-To: <20050313232002.GC22635-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============18364560816036235==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 14, 2005 at 12:20:02AM +0100, Pavel Machek wrote:
> > > I guess has_pci_pm check should be killed from pci_choose_state. It is
> > > probably going to create some problems elsewhere....
> > 
> > Definitely.
> 
> I fixed it in my tree, but I can't easily generate diffs just now (and
> do not get as much testing as suspend2 :-). Bernard, could you remove
> first two lines of pci_choose_state, verify it fixes uhci and submit
> it as a patch?

Not happy yet. Passing D0 to uhci suspend's method is the cause of
the issue (it doesn't handle it particularly well), and D0 is also
passed when PMSG_FREEZE is sent. So while it works for entering S3,
it fails in the same way when preparing for the atomic copy in S4.

Hacking around the issue by always using D3hot should return it back
to the pre-drivermodel behaviour and mostly works. However at least
one person has reported that even doing this, uhci_hcd alone
suspends fine, but if both uhci_hcd and ehci_hcd are loaded, USB is
dead on resume until reloading both modules. I'm still digging
deeper and may need to enlist the help of linux-usb-devel...

I'll let you know when I have something cleaner that works for
everyone.

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--===============18364560816036235==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============18364560816036235==--
