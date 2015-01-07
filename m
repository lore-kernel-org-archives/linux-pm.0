From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 2/2] thermal: rcar: change type of ctemp in
 rcar_thermal_update_temp()
Date: Wed, 7 Jan 2015 00:26:32 +0000
Message-ID: <SIXPR06MB3338FB6C57D07E1133513A9D8460@SIXPR06MB333.apcprd06.prod.outlook.com>
References: <1420538528-5236-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1420538528-5236-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150106130321.GA4661@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150106130321.GA4661@developer>
Content-Language: ja-JP
Sender: linux-sh-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo-san,

> Shimoda-san,
> 
> On Tue, Jan 06, 2015 at 07:02:08PM +0900, Yoshihiro Shimoda wrote:
> > Since the ctemp is used for rcar_thermal_write() in
> > rcar_thermal_update_temp(), the type of ctemp should be "u32" instead
> > of "int".
> 
> In your V2, can you please include in your description that you are also
> updating the helper variables 'old' and 'new'?
> 
> The description does not mention it.

Thank you for the point.
I will fix this description in v2 patch set.

Best regards,
Yoshihiro Shimoda

