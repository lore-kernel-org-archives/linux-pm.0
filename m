From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] PM / Domains: Fix compatible for domain idle state
Date: Mon, 21 Nov 2016 16:30:41 +0000
Message-ID: <bb7451ec-6bc3-aa95-2334-fbaeb492e457@arm.com>
References: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
 <1478210075-92045-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478210075-92045-2-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Lina,

On 03/11/16 21:54, Lina Iyer wrote:
> Re-using idle state definition provided by arm,idle-state for domain
> idle states creates a lot of confusion and limits further evolution of
> the domain idle definition. To keep things clear and simple, define a
> idle states for domain using a new compatible "domain-idle-state".
>
> Fix existing PM domains code to look for the newly defined compatible.
>

Thanks for doing this(reluctantly? :-)). Looks good to me.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
