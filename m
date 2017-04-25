From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] PM / Domains: Add support for explicit control of
 PM domains
Date: Tue, 25 Apr 2017 12:13:27 +0100
Message-ID: <d2e3ceaa-57e2-033d-ecd1-a3b2bd8ffa26@nvidia.com>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490710443-27425-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


On 28/03/17 15:13, Jon Hunter wrote:
> The current generic PM domain framework (GenDP) only allows a single
> PM domain to be associated with a given device. There are several
> use-cases for various system-on-chip devices where it is necessary for
> a PM domain consumer to control more than one PM domain where the PM
> domains:
> i).  Do not conform to a parent-child relationship so are not nested
> ii). May not be powered on and off at the same time so need independent
>      control.
> 
> The solution proposed in this RFC is to allow consumers to explictly
> control PM domains, by getting a handle to a PM domain and explicitly
> making calls to power on and off the PM domain. Note that referencing
> counting is used to ensure that a PM domain shared between consumers
> is not powered off incorrectly.
> 
> The Tegra124/210 XUSB subsystem (that consists of both host and device
> controllers) is an example of a consumer that needs to control more than
> one PM domain because the logic is partitioned across 3 PM domains which
> are:
> - XUSBA: Superspeed logic (for USB 3.0)
> - XUSBB: Device controller
> - XUSBC: Host controller
> 
> These power domains are not nested and can be powered-up and down
> independently of one another. In practice different scenarios require
> different combinations of the power domains, for example:
> - Superspeed host: XUSBA and XUSBC
> - Superspeed device: XUSBA and XUSBB
> 
> Although it could be possible to logically nest both the XUSBB and XUSBC
> domains under the XUSBA, superspeed may not always be used/required and
> so this would keep it on unnecessarily.
> 
> Given that Tegra uses device-tree for describing the hardware, it would
> be ideal that the device-tree 'power-domains' property for generic PM
> domains could be extended to allow more than one PM domain to be
> specified. For example, define the following the Tegra210 xHCI device ...
> 
> 	usb@70090000 {
> 		compatible = "nvidia,tegra210-xusb";
> 		...
> 		power-domains = <&pd_xusbhost>, <&pd_xusbss>;
> 		power-domain-names = "host", "superspeed";
> 	};
> 
> This RFC extends the generic PM domain framework to allow a device to
> define more than one PM domain in the device-tree 'power-domains'
> property. If there is more than one then the assumption is that these
> PM domains will be controlled explicitly by the consumer and the device
> will not be automatically bound to any PM domain.

Any more comments/inputs on this? I can address Rajendra's feedback, but
before I did I wanted to see if this is along the right lines or not?

Cheers
Jon

-- 
nvpublic
