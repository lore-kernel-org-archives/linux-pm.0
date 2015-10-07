From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/4] restore w1 slave bq27000 code of v4.3-rc4
Date: Wed, 7 Oct 2015 20:44:19 +0200
Message-ID: <8F70532F-71B3-4D5E-B5FF-4979A5B485E0@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com> <91a44e6510cf34d4744eb95887ce4b956a734c0c.1444243358.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:47997 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbbJGSoV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:44:21 -0400
In-Reply-To: <91a44e6510cf34d4744eb95887ce4b956a734c0c.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org

Sorry, please forget this.

Am 07.10.2015 um 20:42 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> drivers/w1/slaves/w1_bq27000.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq27000.c
> index 745bd6e..caafb17 100644
> --- a/drivers/w1/slaves/w1_bq27000.c
> +++ b/drivers/w1/slaves/w1_bq27000.c
> @@ -49,8 +49,6 @@ static int w1_bq27000_add_slave(struct w1_slave *sl)
> 	int ret;
> 	struct platform_device *pdev;
> 
> -	request_module("bq27x00_battery");  /* load as module if needed */
> -
> 	pdev = platform_device_alloc("bq27000-battery", -1);
> 	if (!pdev) {
> 		ret = -ENOMEM;
> -- 
> 2.5.1
> 

