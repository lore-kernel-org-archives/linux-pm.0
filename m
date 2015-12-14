From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / Domains: export symbols to add/remove devices from genpd
Date: Tue, 15 Dec 2015 00:56:28 +0100
Message-ID: <1993653.sPPMKzQ4UA@vostro.rjw.lan>
References: <1447789320-2742-1-git-send-email-Maruthi.Bayyavarapu@amd.com> <20151121155450.GA27956@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57678 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753605AbbLNX0V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 18:26:21 -0500
In-Reply-To: <20151121155450.GA27956@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Cc: khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, gregkh@linuxfoundation.org, broonie@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, November 21, 2015 04:54:50 PM Pavel Machek wrote:
> On Wed 2015-11-18 01:12:00, Maruthi Srinivas Bayyavarapu wrote:
> > Drivers which can be built as loadable module needs symbols
> > - pm_genpd_add_device/pm_genpd_remove_device to add/remove devices
> > to/from genpd. Those drivers create platform devices, which comes
> > under a powerdomain.
> > 
> > Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks!

Rafael

