From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] kirkwood: fix coccicheck warnings
Date: Fri, 22 Mar 2013 01:43:39 +0100
Message-ID: <1794203.BzriCauSp9@vostro.rjw.lan>
References: <1362987319-6369-1-git-send-email-silviupopescu1990@gmail.com> <1773787.ohbjPLoSz4@vostro.rjw.lan> <CAPWTe+J4kduwxEgqMrKuZE48NMRzqYzeRUWXJMAmp4Dw=aEGtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59705 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab3CVAgU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 20:36:20 -0400
In-Reply-To: <CAPWTe+J4kduwxEgqMrKuZE48NMRzqYzeRUWXJMAmp4Dw=aEGtg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Silviu Popescu <silviupopescu1990@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, andrew@lunn.ch, jason@lakedaemon.net, rob.lee@linaro.org, len.brown@intel.com, khilman@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, March 22, 2013 02:18:38 AM Silviu Popescu wrote:
> On Fri, Mar 22, 2013 at 1:48 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, March 11, 2013 09:35:19 AM Silviu-Mihai Popescu wrote:
> >> Convert all uses of devm_request_and_ioremap() to the newly introduced
> >> devm_ioremap_resource() which provides more consistent error handling.
> >>
> >> devm_ioremap_resource() provides its own error messages so all explicit
> >> error messages can be removed from the failure code paths.
> >>
> >> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> >
> > If I'm supposed to take these changes, please split them into separate patches
> > for cpufreq, cpuidle and thermal (which would be for Rui BTW).
> 
> There seems to be an existing patch for thermal[1], as Rui pointed out himself.
> I have split the changes in two patches, as you have requested, and resent them.
> 
> [1] http://marc.info/?l=linux-pm&m=136238017027514&w=2

Thanks a lot!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
