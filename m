From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Wed, 16 Mar 2005 11:04:49 +0800
Message-ID: <20050316030448.GA8588@blackham.com.au>
References: <20050314022308.GD6008@blackham.com.au>
	<Pine.LNX.4.44L0.0503151636290.711-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30941724390495917=="
In-Reply-To: <Pine.LNX.4.44L0.0503151636290.711-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============30941724390495917==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2005 at 04:48:19PM -0500, Alan Stern wrote:
> One other point: Suspend calls free_irq() and resume calls request_irq().  
> This doesn't seem necessary to me since the common IRQ handler will reject
> interrupts occuring while the controller is suspended.  Also it's asking
> for trouble if the driver is unloaded before the controller is resumed,
> since the remove routine will call free_irq() again on its own.  I've
> #ifdef'ed out those calls below, but this deserves closer attention.
> 
> Another thing deserving closer attention is the various error pathways and
> what state they end up leaving the hardware and the data structures in.  
> The patch below doesn't address this.
> 
> Anyway, here are the changes I made.  Now things are working better again.  
> Bernard, does this help you?

Somewhat. I had to tweak the patches for the new driver model
(specifically, change "power_state = state" to "power_state.event =
msg.event"), and I'm still using the patch to remove the
PCI_CAP_ID_PM check from pci_choose_state.

Suspend and resume into both S3, and suspend-to-disk (where
PMSG_FREEZE and PMSG_ON are used), are fine if there are no devices
plugged in. If there are devices plugged in, it's not so good.
(Using a boring USB mouse for testing here). They'll suspend and
resume the first time, suspend a second time, then fail on resume -
I get a stream of messages:

Mar 16 10:07:30 amidala kernel: uhci_hcd 0000:00:1d.1: suspend_hc
Mar 16 10:07:30 amidala kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Mar 16 10:07:31 amidala kernel: uhci_hcd 0000:00:1d.1: host controller process error, something bad happened!
Mar 16 10:07:31 amidala kernel: uhci_hcd 0000:00:1d.1: host controller halted, very bad!
Mar 16 10:07:31 amidala kernel: usb 3-1: gpilotd timed out on ep0in
Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: suspend_hc
Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: host controller process error, something bad happened!
Mar 16 10:07:33 amidala kernel: uhci_hcd 0000:00:1d.1: host controller halted, very bad!
Mar 16 10:07:35 amidala kernel: uhci_hcd 0000:00:1d.1: suspend_hc
Mar 16 10:07:35 amidala kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Mar 16 10:07:36 amidala kernel: uhci_hcd 0000:00:1d.1: host controller process error, something bad happened!

repeating over and over again. USB is dead, and any program that
tries to touch USB will hang:

Mar 16 10:08:55 amidala kernel: Xorg          D C041E3E0     0  3214   3118          3952       (NOTLB)
Mar 16 10:08:55 amidala kernel: f5fb5ee8 00003082 f5ae0570 c041e3e0 f5a2fb80 f5fb5ee8 c026271a c1bfbe00 
Mar 16 10:08:55 amidala kernel:        f5a2fb80 c01e3f43 f6c08020 00000c34 c53639fe 00000017 f5ae06c4 f5a2fb80 
Mar 16 10:08:55 amidala kernel:        f5fb5f18 f5fb5f0c f5fb5f44 c026321d f5a2fb80 fffffffe 00000000 f5ae0570 
Mar 16 10:08:55 amidala kernel: Call Trace:
Mar 16 10:08:55 amidala kernel:  [usb_kill_urb+221/304] usb_kill_urb+0xdd/0x130
Mar 16 10:08:55 amidala kernel:  [input_close_device+57/64] input_close_device+0x39/0x40
Mar 16 10:08:55 amidala kernel:  [mixdev_release+58/112] mixdev_release+0x3a/0x70
Mar 16 10:08:55 amidala kernel:  [__fput+301/320] __fput+0x12d/0x140
Mar 16 10:08:55 amidala kernel:  [filp_close+87/144] filp_close+0x57/0x90
Mar 16 10:08:55 amidala kernel:  [sys_close+97/160] sys_close+0x61/0xa0
Mar 16 10:08:55 amidala kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

and strangely enough, soon every process in the system becomes hung.
I haven't tried David's patch yet - the only differences are it
seems to use a slightly different order, and also calls
pci_set_master. I'll give that a spin later today combined with and
without yours to see what works reliably.

Thanks,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--===============30941724390495917==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30941724390495917==--
