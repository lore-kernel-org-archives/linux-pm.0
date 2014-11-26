From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 05/10] arm: dts: qcom: Add power-controller device node
 for 8084 Krait CPUs
Date: Wed, 26 Nov 2014 14:43:15 -0800
Message-ID: <54765783.7000306@codeaurora.org>
References: <1417040910-43290-1-git-send-email-lina.iyer@linaro.org>
 <1417040910-43290-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1417040910-43290-6-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: devicetree@vger.kernel.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 11/26/2014 02:28 PM, Lina Iyer wrote:
> Each Krait CPU in the QCOM 8084 SoC has an SAW power controller to
> regulate the power to the cpu and aide the core in entering idle states.
> Reference the SAW instance and associate the instance with the CPU core.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
