From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 7/7] thermal: rcar_gen3_thermal: add suspend and resume
 support
Date: Tue, 7 Mar 2017 20:55:46 +0100
Message-ID: <20170307195546.GG2554@tetsubishi>
References: <20170306200401.29923-1-niklas.soderlund+renesas@ragnatech.se>
 <20170306200401.29923-8-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170306200401.29923-8-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 06, 2017 at 09:04:01PM +0100, Niklas Söderlund wrote:
> To restore operation it's easiest to reinitialise all TSC. In order to
> do this the current trip window needs to be stored in the TSC structure
> so that it can be restored upon resume.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
