From: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Thu, 17 Mar 2005 00:52:39 +0800
Message-ID: <20050316165239.GA10545@blackham.com.au>
References: <20050316030448.GA8588@blackham.com.au>
	<Pine.LNX.4.44L0.0503161024360.1040-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70395214584345545=="
In-Reply-To: <Pine.LNX.4.44L0.0503161024360.1040-100000-3WpdWqXrU/qjv4eRiOYp3g@public.gmane.org>
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

--===============70395214584345545==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2005 at 10:45:57AM -0500, Alan Stern wrote:
> The power_state.event change shouldn't affect the code's functioning.  
> Neither should the PCI_CAP_ID_PM check provided it still ends up deciding 
> to "suspend" to D0.

Can you elaborate on '"suspend" to D0' ? If the PCI_CAP_ID_PM check
is in place, the state variable in usb_hcd_pci_suspend is set to 0,
which means the if statement here:

    case HCD_STATE_SUSPENDED:
        if (state <= dev->current_state)
            break;

is hit, and pci_save_state, pci_disable_device, and free_irq are
never called.

If, on the other hand the PCI_CAP_ID_PM check is removed from
pci_choose_state, "state" is D3hot, so the PCI disabling code *is*
called, and the function bails out when it hits if (!has_pci_pm) {...

> Below is a new version of my patch with the IRQ handling reinstated and
> the missing pci_set_master included.  I'll do some more testing and get
> back to you...

Needed an extra patch to compile, attached. However, it still
doesn't survive more than one suspend/resume with devices plugged
in. On the second resume, USB is dead, and it enters the same
suspend_hc/wakeup_hc loop. I traced this back to the hcd never
really being resumed, as the pci power state never changes from D0
as pci_set_power_state is never called here. The attached patch also
addresses this - I'm not sure if it's the right way, but it
works(ish):

Suspend and resume for S3 or suspend to disk, without devices
plugged in, works fine. If my USB mouse is plugged in, it is resumed
and powered up, but nothing is sent out /dev/input/mice until I
unplug and replug the device (but USB is not dead :)

I'll forward this (combined) patch to the user on the Suspend2 list
having issues suspending when both uhci and ehci were loaded.

Thanks,

Bernard.

-- 
 Bernard Blackham <bernard at blackham dot com dot au>

--===============70395214584345545==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70395214584345545==--
