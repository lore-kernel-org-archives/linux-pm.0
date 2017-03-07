From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/7] thermal: rcar_gen3_thermal: record more information
 about each TSC
Date: Tue, 7 Mar 2017 20:55:24 +0100
Message-ID: <20170307195523.GD2554@tetsubishi>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-5-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40955 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755138AbdCGUuM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Mar 2017 15:50:12 -0500
Content-Disposition: inline
In-Reply-To: <20170306200401.29923-5-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On Mon, Mar 06, 2017 at 09:03:58PM +0100, Niklas Söderlund wrote:
> The struct rcar_gen3_thermal_tsc benefits from knowing which TSC it
> represent. Record this at probe time before this information is lost.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

See next review. I don't think this is needed.
