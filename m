From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: check for negative return from of_count_phandle_with_args
Date: Tue, 01 Nov 2016 05:48:16 +0100
Message-ID: <3498199.QxdRYBakzi@vostro.rjw.lan>
References: <20161025163327.2179-1-colin.king@canonical.com> <7htwc0thwv.fsf@baylibre.com> <20161026110007.GA23875@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60155 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S965641AbcKAElG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 00:41:06 -0400
In-Reply-To: <20161026110007.GA23875@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Colin King <colin.king@canonical.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, October 26, 2016 01:00:08 PM Pavel Machek wrote:
> 
> --zhXaljGHf11kAtnf
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue 2016-10-25 11:14:40, Kevin Hilman wrote:
> > Colin King <colin.king@canonical.com> writes:
> >=20
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > The return from of_count_phandle_with_args can be negative, so we
> > > should avoid kcalloc of a negative count of genpd_power_stat structs
> > > by sanity checking if count is zero or less.
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >=20
> > Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks!

Rafael

