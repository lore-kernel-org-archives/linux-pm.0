From: Sylvain Munaut <246tnt@gmail.com>
Subject: Discrete Nvidia GPU shutdown with recent kernel / BIOS (on T440s
 laptop) - Should be automatic with runtime pm now ?
Date: Tue, 21 Jul 2015 11:57:38 +0200
Message-ID: <CAHL+j0-Nf4rgCrUHbtZ0d2bpW3hX57Mz5jUwhckv8endScA29g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,


tl;dr : Should device allowed to do runtime pm that have no driver go
to D3 on their own ?  And should pci root bridge go to D3 when all the
device on them are on D3 ?


The whole story:

Modern kernel ( > 3.15 ) report "Windows 2013" as an OSI string, even
newer ones report "Windows 2015" as well. This triggers some changes
in the ACPI code of the T440s laptop (and in others as well, but this
is the one I'm using as reference here).

This changes breaks the method used by Bumbblebee's bbswitch module
and by the nouveau driver to shutdown the card (to save power). No
error is reported, and some power is saved, but not as much as
previously (hence users might not notice at all).

The usual "solution" given to users is to use acpi_osi="!Windows 2013"
 (and now they'll have to add acpi_osi="!Windows 2015" as well), but I
was interested to find out exactly what was causing that behavior and
whathttps://bugs.freedesktop.org/attachment.cgi?id=117267 new method
Win 8.1 and Win 10 were using to shutdown the card.

The DSDT of the T440s running the latest 2.33 bios can be found here :
https://bugs.freedesktop.org/attachment.cgi?id=117267

The current method used to shutdown the card relies on two actions :
 - Making a _DSM call to the video acpi node, this will prepare the
shutdown and instructs ACPI to do the actual power down on the next
device state transition to D3. This is just preparaton and just sets
some variable but doesn't actually do the power off.
 - Actually make the device go to D3 with pci_set_power_state. This
then executes the _PS3 method in ACPI and if the proper variable have
been set by the DSM above, this will call the GPOF method which will
turn off power.

I looked at what changed when "Windows 2013" was present vs "Windows
2012". And here's what's triggered :
 - OSYS is set to 0x07DD.
 - This in turn cause VMSH to be set to 1.
 - This in turn causes _SB_.PCI0.PEG_.VID_.PS3 to _NOT call GPOF when
the device is set to D3.
 - and so the card is never really turned off completely

Now I looked at what other path could be taken to reach the GPOF method.
And if you look at the table you can see that it can be called as part
of the NVP3 power resource which is PR3 ... but on the node
_SB.PCI0.PEG_ and not _SB.PCI0.PEG_.VID_ !

So the GPU gets turned off when the PCIe bridge/port it's connected to
gets transitionned to D3hot. I did confirm this by manually patching
bbswitch to put the pci_upstream_bridge(...) of the device to D3hot
after putting the card itself in D3cold. Power saving measured matches
what's expected, but I have no idea if it's the "right" thing to do.

The DSM call doesn't seem to be required now, so everything is done
with pure PM state which I guess is good.

What I expected is that now that everything is purely PM, then linux
should be able to do all of this automatically without the need for
bbswitch at all.
If no driver is loaded for the card (so obviously no users), then
doing an "echo auto > .../power/control" on both the card node and the
bridge port node it's attached to should allow runtime PM. And shince
they're unused, everything should go to D3 on its own.

But that doesn't seem to happen ? Are my expectations wrong ?


Cheers,

    Sylvain
