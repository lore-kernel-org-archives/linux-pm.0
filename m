From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/3] soc/tegra: bpmp: Update ABI header
Date: Thu, 20 Apr 2017 02:44:48 +0200
Message-ID: <10169152.Khpl4fl1AK@aspire.rjw.lan>
References: <20170329163452.10761-1-thierry.reding@gmail.com> <20170329163452.10761-3-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42228 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968483AbdDTAuz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 20:50:55 -0400
In-Reply-To: <20170329163452.10761-3-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Stefan Kristiansson <stefank@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

On Wednesday, March 29, 2017 06:34:51 PM Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Update the BPMP ABI header to a more recent version. The new version
> adds support for a new powergating ABI as well as access to the ring
> buffer console, which allows debug messages to be output to the BPMP
> debug console.
> 
> Some of the previously undocumented fields have been documented and
> missing bitmasks have been added. Furthermore the MRQ_RESET request
> now has a sub-command that allows to determine the maximum ID which
> in turn allows the resets to be enumerated, thereby allowing drivers
> to become agnostic of the Tegra generation.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

I could queue up the [1,3/3] with the Ulf's ACKs, but I can't really say
whether or not this one makes sense. :-)

Any chance to ask the ARM/soc people for an ACK?

Thanks,
Rafael
