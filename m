From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
Date: Thu, 6 Sep 2018 23:40:56 -0700
Message-ID: <3b37e4fd-c793-bd52-7d70-950f846a7d5a@kernel.org>
References: <20180907053614.6540-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180907053614.6540-1-drake@endlessm.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux@endlessm.com, nouveau@lists.freedesktop.org, linux-pm@vger.kernel.org, peter@lekensteyn.nl, kherbst@redhat.com, andriy.shevchenko@linux.intel.com, rafael.j.wysocki@intel.com, keith.busch@intel.com, mika.westerberg@linux.intel.com, jonathan.derrick@intel.com, kugel@rockbox.org, davem@davemloft.net, hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com
List-Id: linux-pm@vger.kernel.org

On 9/6/2018 10:36 PM, Daniel Drake wrote:
> +	if (pci_dev->class == PCI_CLASS_BRIDGE_PCI << 8)
> +		pci_setup_bridge_mmio_pref(pci_dev);

This should probably some kind of a quirk rather than default
for the listed card as it sounds like you are dealing with
broken hardware.
