From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH v2] PCI: Reprogram bridge prefetch registers on resume
Date: Wed, 12 Sep 2018 17:37:37 +0800
Message-ID: <CAD8Lp474=_Yy62O6SX4_jGvJLUJyeMBkircyPeDG+NkGA7EhqQ@mail.gmail.com>
References: <20180912064523.9599-1-drake@endlessm.com> <CAJZ5v0j6VcFbO_R3fGLi2Ec1DmWsVA-0mzDG3LrA-3D5CrsPbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j6VcFbO_R3fGLi2Ec1DmWsVA-0mzDG3LrA-3D5CrsPbw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>, Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com, Rafael Wysocki <rafael.j.wysocki@intel.com>, Keith Busch <keith.busch@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jon Derrick <jonathan.derrick@intel.com>, Thomas Martitz <kugel@rockbox.org>, David Miller <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>, netdev <netdev@vger.kernel.org>, nic_swsd@realtek.com, rchang@marvell.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 5:05 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Passing the extra bool around is somewhat clumsy, but I haven't found
> a cleaner way to do it, so

Thanks, according to your suggestion (which I plan to follow after
this) we will remove this parameter for v4.20+ and have all the
register writes be forced regardless of current value.

Daniel
