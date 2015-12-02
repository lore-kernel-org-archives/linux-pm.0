From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [RFD] PM_GENERIC_DOMAINS && !PM
Date: Wed, 02 Dec 2015 02:35:20 +0100
Message-ID: <1995321.JkVMSghsar@vostro.rjw.lan>
References: <565C7C86.7030801@nvidia.com> <565DBEE6.5030704@nvidia.com> <20151201161809.GA20561@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151201161809.GA20561@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 01, 2015 05:18:09 PM Thierry Reding wrote:
> 

[cut]

> 
> That all sounds very complicated for little gain. Disabling PM doesn't
> make much sense these days, so I'd personally be fine to unconditonally
> enable PM on Tegra. I'm not sure what the correct way would be. Since
> the PM symbol is user-visible, selecting it doesn't sound like a very
> good solution, though a quick grep shows that some architectures do
> this.
> 
> Rafael, do you know what the canonical way is to make !PM invalid for a
> platform?

Well, good question.

I can't really suggest anything cleaner than selecting it from the top-level
Kconfig at the moment.

Thanks,
Rafael
