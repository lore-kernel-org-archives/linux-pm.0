From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v7 12/13] clk: qcom: gdsc: Add GDSCs in apq8084 MMCC
Date: Fri, 31 Jul 2015 17:54:56 +0300
Message-ID: <55BB8C40.507@mm-sol.com>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org> <1438076046-4706-13-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:45691 "EHLO extserv.mm-sol.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbbGaOzO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 31 Jul 2015 10:55:14 -0400
In-Reply-To: <1438076046-4706-13-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, georgi.djakov@linaro.org, srinivas.kandagatla@linaro.org, sviau@codeaurora.org


<snip>

>  
> +static struct gdsc venus0_gdsc = {
> +	.gdscr = 0x1024,
> +	.pd = {
> +		.name = "venus0",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.con_ids = { NULL },
> +};
> +

Rajendra, according to downstream kernel apq8084 has second instance of
gdsc i.e. venus1_gdsc, is that correct?


-- 
regards,
Stan
