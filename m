From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/5] PM / OPP: Support adjusting OPP voltages at runtime
Date: Tue, 22 Sep 2015 09:50:41 -0700
Message-ID: <20150922165041.GG24314@linux>
References: <1442623929-4507-1-git-send-email-sboyd@codeaurora.org>
 <1442623929-4507-3-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1442623929-4507-3-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Nishanth Menon <nm@ti.com>, David Collins <collinsd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 18-09-15, 17:52, Stephen Boyd wrote:
>  /**
> + * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
> + * @dev:		device for which we do this operation
> + * @freq:		OPP frequency to adjust voltage of
> + * @u_volt:		new OPP voltage
> + *
> + * Change the voltage of an OPP with an RCU operation.
> + *
> + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> + * copy operation, returns 0 if no modifcation was done OR modification was

                                      modification

> + * successful.

Otherwise,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
