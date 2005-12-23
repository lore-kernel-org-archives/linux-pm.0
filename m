From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Fri, 23 Dec 2005 07:12:35 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
References: <20051223143047.GC16463@f192.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46154174634917822=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051223143047.GC16463@f192.suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Holger Macht <hmacht@suse.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============46154174634917822==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 23 Dec 2005, Holger Macht wrote:

> Hi,
>
> We implemented device runtime power management in a userspace application
> (the powersave daemon). In this specific case, it means to successively
> put pci devices into D3 powersave mode with writing a numerical '3' to the
> corresponding power state file.
>
> There are two main reasons for us to even doing this:
>
>   1. At first, the obvious reason. As mentioned in our research regarding
>      power consumption on this list, there is a very huge potential to
>      save battery power.
>
>   2. Due to the fact that this is AFAIK a heavily untested area, as a side
>      effect, we like to get reports about broken modules/drivers and maybe
>      get them fixed.

That's great!

Please note that D3 is only relevant for PCI devices and for ACPI devices.
The fact that it's the same value for every device in the system is a
design flaw. Please be aware that the value to write to the device file
could change, and will be dependent on the type (bus) of device, and quite
possibly on the device itself. It may not even be '3' for all PCI devices
in the future, or may be a string rather than 1 character, or simply a '1'
into a different file.

Please also note that D3 is not always a good choice. A driver may not be
able to reinitialize the device from D3. And, since it takes longer to
resume from D3, you may want to start with D1 or D2. (The same concept is
true for devices other than PCI, though the values will be different.)

How do you determine the idleness of a device? Or, is it based purely on
user direction?

Also, is there source available?

Thanks,


	Patrick


--===============46154174634917822==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46154174634917822==--
