From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH/RESEND] thermal: qcom-spmi: Treat reg property as a
 single cell
Date: Mon, 24 Oct 2016 14:27:25 -0500
Message-ID: <20161024192725.GI3145@hector.attlocal.net>
References: <20161018234019.5489-1-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161018234019.5489-1-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Ivan T . Ivanov" <iivanov.xz@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 18, 2016 at 04:40:19PM -0700, Stephen Boyd wrote:
> We only read the first element of the reg property to figure out
> the offset of the temperature sensor inside the PMIC.
> Furthermore, we want to remove the second element in DT, so just
> don't read the second element so that probe keeps working if we
> change the DT in the future.
> 
> Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
