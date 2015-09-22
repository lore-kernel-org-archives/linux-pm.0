From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 1/5] regulator: smd: Add floor and corner operations
Date: Tue, 22 Sep 2015 09:39:46 -0700
Message-ID: <20150922163946.GG23081@codeaurora.org>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-2-git-send-email-sboyd@codeaurora.org>
 <20150919165712.GH30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150919165712.GH30445@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Andy Gross <agross@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Georgi Djakov <georgi.djakov@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 09/19, Mark Brown wrote:
> On Fri, Sep 18, 2015 at 05:52:05PM -0700, Stephen Boyd wrote:
> 
> > +EXPORT_SYMBOL(qcom_rpm_set_floor);
> 
> The entire regulator API is EXPORT_SYMBOL_GPL(), adding plain
> EXPORT_SYMBOL() exports is not good.

That's fine. I can make it GPL.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
