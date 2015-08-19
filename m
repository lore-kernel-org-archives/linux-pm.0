From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] PM / devfreq: comments for get_dev_status usage updated
Date: Wed, 19 Aug 2015 18:43:09 +0100
Message-ID: <20150819174309.GA22033@e104805>
References: <134989511.192481439873565434.JavaMail.weblogic@ep2mlwas01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:58220 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750910AbbHSRnR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 13:43:17 -0400
Content-Disposition: inline
In-Reply-To: <134989511.192481439873565434.JavaMail.weblogic@ep2mlwas01a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Aug 18, 2015 at 05:52:46AM +0100, MyungJoo Ham wrote:
> 
> With the introduction of devfreq_update_stats(), governors
> are not recommended to use get_dev_status() directly.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
>  include/linux/devfreq.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
Looks good to me.  FWIW,

Reviewed-by: Javi Merino <javi.merino@arm.com>
