From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/4] Fix forcedeth hibernate/wake-on-lan
 problems
Date: Sat, 31 May 2008 22:51:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805312247100.18240-100000__36420.915000099$1212288893$gmane$org@netrider.rowland.org>
References: <20080531221223.GA2630@yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080531221223.GA2630@yamamaya.is-a-geek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 1 Jun 2008, Tobias Diedrich wrote:

> Ok, after another long debugging session I finally found out the
> reason for the immediate reboot (after finding the place that
> suspends the serial console (drivers/pnp) and disabling that suspend
> path):
> The system is woken up by USB activity! (Optical mouse, anyone?)
> 
> Lo and behold:
> drivers/usb/core/hcd-pci.c tries it's best to activate 'wake on
> usb', which I didn't know since it apparently also never worked.
> However, after applying the 'use platform_enable_wakeup'-patch,
> not only forcedeth wake starts working, also usb wake.
> If I prevent usb wake:
> |echo disabled > /sys/devices/pci0000\:00/0000\:00\:02.0/power/wakeup'
> |echo disabled > /sys/devices/pci0000\:00/0000\:00\:02.1/power/wakeup'
> And then hibernate in platform mode, the immediate reboot is gone
> and waking up using magic packets works fine even without setting up
> /proc/acpi/wakeup first.
> 
> Maybe I should try hooking mouse and keyboard onto different usb
> host controllers, so I can disable wakeup for the mouse host
> controller and enable wakeup for the keyboard host controller,
> then it should be possible to wake the system by pressing a key. :)

You don't need to do that.  Wakeup can be set specifically for each 
individual USB device, provided CONFIG_USB_SUSPEND is enabled.


On Sun, 1 Jun 2008, Tobias Diedrich wrote:

> (BTW I first thought the 'immediate reboot because of usb wake' effect is
> caused by the optical mouse generating a wake event, but it rather
> seems to be a problem with a flaky secondary usb host controller,
> which sees a connected device where nothing is attached)

Can you provide debugging information (i.e., CONFIG_USB_DEBUG) with the 
details on this bogus wakeup?

Alan Stern
