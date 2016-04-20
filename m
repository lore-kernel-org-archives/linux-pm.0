From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 00/11] qcom: Add support for TSENS driver
Date: Wed, 20 Apr 2016 16:51:28 -0700
Message-ID: <20160420235127.GC2558@localhost.localdomain>
References: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460626319-14516-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 14, 2016 at 03:01:48PM +0530, Rajendra Nayak wrote:
> Current set of patches apply on 4.6-rc3. nvmem apis are currently
> broken and hence need to pull in the fixes for it as proposed here [1]


Could you please clarify this a bit?

Do I understand properly that we need to wait until [1] gets merged to
get the driver functional again after applying this series?
> 
