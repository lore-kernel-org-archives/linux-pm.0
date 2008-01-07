From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB PM suspend/resume problems with Marvell Orion SoC
Date: Mon, 7 Jan 2008 11:21:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801071119320.4609-100000@iolanthe.rowland.org>
References: <4780F8FC.4070309@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4780F8FC.4070309@marvell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tawfik Bayyouk <tawfik@marvell.com>
Cc: linux-pm@lists.linux-foundation.org, Tzachi Perelstein <tzachi@marvell.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Jan 2008, Tawfik Bayyouk wrote:

> Hi,
> 
> I am working with Linux version 2.6.24-rc4 for adding the power
> management capabilities to the USB ehci driver for Orion SoC 
> device of Marvell.
> 
> I need help in 2 issues:
> 
> 1- The SoC device supports 2 levels of power management and I'd 
> like to reflect this at the driver level. 
> The first is "standby" where only clocks are halted while 
> preserving the registers values. The second is "mem" where the 
> whole SoC (including the USB HC) are powered off.
> What is the correct way to distinguish between the 2 modes in 
> the .suspend and .resume routines of the platform_driver?
> I believe that the parameter I am looking for is the PM target 
> state which is usually passed in the .set_target of the 
> platform_suspend_ops routine.
> 
> 2- After resuming from "mem" suspend, the USB can no longer 
> detect plugging in and out of USB devices.
> I have investigate the problem and found that 4 registers where 
> not configured correctly. Saving the values of these registers 
> in the .suspend routine and loading them back in the .resume 
> routine resolves the problem. 
> The following are the 4 problematic registers:
>     USBCMD (0x140)
>     USBINTR (0x148)
>     PORTSC1 (0x184)
>     USBMODE (0x1A8)

So what's the problem?  Just have your platform suspend method always
save the registers and have the resume method always restore them.  If 
you do this, you should also call usb_root_hub_lost_power().

Alan Stern
