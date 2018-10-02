From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers on resume
Date: Tue, 2 Oct 2018 16:29:23 -0500
Message-ID: <CAErSpo7nZCJv9+nvkWkWKUh5WetT7cp+v9QxV0pX4oqjLTZp2w@mail.gmail.com>
References: <20180913033745.11178-1-drake@endlessm.com> <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org> <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
 <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org> <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
 <0b3bc158-b836-7b44-ef09-7c124f479c58@rockbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0b3bc158-b836-7b44-ef09-7c124f479c58@rockbox.org>
Sender: netdev-owner@vger.kernel.org
To: kugel@rockbox.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Daniel Drake <drake@endlessm.com>, linux-pci@vger.kernel.org, linux@endlessm.com, nouveau@lists.freedesktop.org, Linux PM list <linux-pm@vger.kernel.org>, Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com, andy.shevchenko@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Keith Busch <keith.busch@intel.com>, Jon Derrick <jonathan.derrick@intel.com>, David Miller <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>, netdev <netdev@vger.kernel.org>, Realtek linux nic maintainers <nic_swsd@realtek.com>, rchang@marvell.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 2, 2018 at 4:27 PM Thomas Martitz <kugel@rockbox.org> wrote:
>
> Am 02.10.18 um 22:03 schrieb Bjorn Helgaas:
> > Hi Thomas,
> >
> > On Mon, Oct 01, 2018 at 04:25:06PM +0200, Thomas Martitz wrote:
> >> Am 01.10.18 um 06:57 schrieb Daniel Drake:
> >>> On Sun, Sep 30, 2018 at 5:07 AM Thomas Martitz <kugel@rockbox.org> wrote:
> >>>> The latest iteration does not work on my HP system. The GPU fails to
> >>>> power up just like the unpatched kernel.
> >>>
> >>> That's weird, I would not expect a behaviour change in the latest
> >>> patch. pci_restore_config_dword() has some debug messages, could you
> >>> please make them visible and show logs again?
> >>> Also remind us of the PCI device address of the parent bridge (lspci -vt)
> >>
> >> I'll follow up with more the requested information on bugzilla
> >> (Link: https://bugzilla.kernel.org/show_bug.cgi?id=201069).
> >>
> >> On a quick re-check, it seems to depend on if I used the eGPU before
> >> the initial suspend. If I run glxgears (with DRI_PRIME=1) before suspend it
> >> seems fine.
> >
> > Does the patch ([1]) make things *worse* compared to v4.19-rc5?
> >
>
> No, certainly not. It does look like a different issue since resuming now
> works at least if I used the eGPU in some way before suspend
> (DRI_PRIME=1 glxgears seems to be enough, I assume glxinfo would work as
> well).
>
> Without the patch resuming the eGPU does not work whatsoever.
>
> Please ship the patch. I'll hopefully sort this other issue out.

Great, thanks!  That's what I thought, but just wanted to double check.
