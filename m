From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: v4.15-rc5: resume took way too long, warning in syslog
Date: Fri, 29 Dec 2017 11:23:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1712291119210.24019-100000@netrider.rowland.org>
References: <20171229155714.GA30656@amd>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171229155714.GA30656@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-pm mailing list <linux-pm@vger.kernel.org>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Dec 2017, Pavel Machek wrote:

> Hi!
> 
> v4.15-rc5.. resume took _way_ too long, and I have warn_on in dmesg as
> a bonus. It looks like USB problem...? I never seen this before.

Is this problem very repeatable?  Is there any possibility of bisecting 
to find the cause?

> [42269.489765] usb 1-1.3: reset full-speed USB device number 3 using ehci-pci
> [42269.577806] ata2: SATA link down (SStatus 0 SControl 300)
> [42269.577851] ata5: SATA link down (SStatus 0 SControl 300)
> [42269.677809] usb 1-1.6: reset high-speed USB device number 4 using ehci-pci
> [42270.167923] psmouse serio1: synaptics: queried max coordinates: x [..5472], y [..4448]
> [42270.361825] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [42270.363396] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> [42270.363404] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> [42270.363409] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> [42270.366202] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> [42270.366209] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> [42270.366215] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> [42270.367116] ata1.00: configured for UDMA/133
> [42273.571626] e1000e: eth2 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
> [42273.571638] e1000e 0000:00:19.0 eth2: 10/100 speed: disabling TSO
> [42274.421868] usb 2-1.1.4: reset high-speed USB device number 55 using ehci-pci
> [42279.541849] usb 2-1.1.4: device descriptor read/64, error -110
> [42295.157864] usb 2-1.1.4: device descriptor read/64, error -110
> [42295.345865] usb 2-1.1.4: reset high-speed USB device number 55 using ehci-pci
> [42300.533867] usb 2-1.1.4: device descriptor read/64, error -110
> [42316.149843] usb 2-1.1.4: device descriptor read/64, error -110
> [42316.337864] usb 2-1.1.4: reset high-speed USB device number 55 using ehci-pci
> [42327.029859] usb 2-1.1.4: device not accepting address 55, error -110
> [42327.113863] usb 2-1.1.4: reset high-speed USB device number 55 using ehci-pci
> [42337.781888] usb 2-1.1.4: device not accepting address 55, error -110

> [42337.913753] usb 2-1.1.4: new high-speed USB device number 56 using ehci-pci
> [42338.395078] e1000e: eth2 NIC Link is Down
> [42338.732172] systemd-journald[2470]: Received SIGTERM from PID 1 (systemd).
> [42339.679602] systemd[1]: Unit systemd-journald.service entered failed state.
> [42340.426957] systemd-journald[30462]: Received request to flush runtime journal from PID 1
> [42343.029871] usb 2-1.1.4: device descriptor read/64, error -110
> [42344.483918] e1000e: eth2 NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
> [42344.483927] e1000e 0000:00:19.0 eth2: 10/100 speed: disabling TSO
> [42358.645164] usb 2-1.1.4: device descriptor read/64, error -110
> [42358.833023] usb 2-1.1.4: new high-speed USB device number 57 using ehci-pci
> [42364.018463] usb 2-1.1.4: device descriptor read/64, error -110
> [42379.626669] usb 2-1.1.4: device descriptor read/64, error -110
> [42379.735177] usb 2-1.1-port4: attempt power cycle
> [42380.338299] usb 2-1.1.4: new high-speed USB device number 58 using ehci-pci

It sure looks like that USB device (or maybe the hub it was connected 
to) decided to stop working during the suspend.

Alan Stern
