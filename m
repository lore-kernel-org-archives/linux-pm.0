From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Question on USB re-enumeration
Date: Sun, 15 Nov 2009 14:11:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911151407380.6654-100000@netrider.rowland.org>
References: <8bf247760911150100i15434810r7be8e1c03f78c7f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8bf247760911150100i15434810r7be8e1c03f78c7f7@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sriram V <vshrirama@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Nov 2009, Sriram V wrote:

> Hi,
> 
> I have a couple of questions of re-enumeration of usb devices on
> suspend-resume
> 
> I have a USB Device permanently connected to the host controller.
> 
> Upon resume - Should i usb device get re-enumerated?

If the host controller lost power was reinitialized during the suspend 
then yes.  Otherwise no.  In particular, devices should always get 
re-enumerated when resuming from hibernation.  But when resuming from 
suspend-to-RAM, it depends on the motherboard.

> If so, does Linux choose a different address for accessing it?

If the device's firmware hasn't changed then the address remains the 
same.  Otherwise a different address is used.

Read Documentation/usb/persist.txt.

> If i have a USB harddisk, I am accessing it using a device node say
> /dev/sdb1
> The harddisk is mounted as /dev/sdb1.
> 
> Now, i go into suspend and then resume - If i need to re-enumerate the
> devices
> It could be detected as /dev/sdc1... or something.
> 
> If that is the case i cannot access my harddisk - since im assuming
> /dev/sdb1.
> 
> What im seeing here is - My usb device is permanently connected to the usb
> host via an external phy.
> 
>  When i suspend - i turn off the clocks and upon resume - turn on the clocks
> and reset the phy.
> 
>  For some time - i am able to access the device, What happens is - The
> device gets re-enumerated to some other device node.
> 
> I am not sure if this is a device issue or a resume function issue.
> 
> 
> Please advice.

Enable CONFIG_USB_DEBUG in your kernel and post the dmesg log showing
what happens during suspend and resume.

Alan Stern
