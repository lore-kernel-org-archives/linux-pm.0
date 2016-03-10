From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH 2/2] PM / Domains: Fix potential NULL pointer dereference
Date: Fri, 11 Mar 2016 00:24:37 +0100
Message-ID: <2444093.rvCdthdsgI@vostro.rjw.lan>
References: <1457088915-17284-1-git-send-email-jonathanh@nvidia.com> <1457088915-17284-2-git-send-email-jonathanh@nvidia.com> <CAPDyKFpha7TQbvZ2B9aDuoRuOFEHzD5ZwOCADvs6=0pwCNSgQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpha7TQbvZ2B9aDuoRuOFEHzD5ZwOCADvs6=0pwCNSgQg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Friday, March 04, 2016 12:07:23 PM Ulf Hansson wrote:
> On 4 March 2016 at 11:55, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > In the function of_genpd_get_from_provider(), we never check to see if
> > the argument 'genpdspec' is NULL before dereferencing it. Add error
> > checking to handle any NULL pointers.
> >
> > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Both this one and the [1/2] applied, thanks!

Rafael
