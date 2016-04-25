From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / Domains: Further consolidate and clarify genpd code
Date: Tue, 26 Apr 2016 01:58:35 +0200
Message-ID: <1502023.o1ZTkFOg9W@vostro.rjw.lan>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org> <7hwpnq4hrs.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64155 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752236AbcDYXzh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 19:55:37 -0400
In-Reply-To: <7hwpnq4hrs.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

On Thursday, April 21, 2016 05:19:19 PM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > This is yet another quite trivial series of patches that further intends to
> > consolidate and clarify some of the code for the generic PM domain (genpd).
> >
> > Ulf Hansson (3):
> >   PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
> >   PM / Domains: Rename pm_genpd_runtime_suspend|resume()
> >   PM / Domains: Remove ->save|restore_state() callbacks
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> with an enthusiastic yes!  :)
> 
> Thanks for the cleanups and clarifications.

All [1-3/3] applied, thanks!

