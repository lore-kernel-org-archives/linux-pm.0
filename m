From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
Date: Thu, 23 Oct 2014 18:31:57 +0300
Message-ID: <1414078317.4214.4.camel@mm-sol.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi, 

On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
> Hi,
> 
> This v8 revision of the cpuidle driver is available at
> git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
> 

Probably I missing something, but should I expect that
once these patches are applied driver could be successfully
 compiled? 

Patches definitely break bisectability. For example [PATCH v8 1/7]
is using <soc/qcom/pm.h> which is introduced [PATCH v8 4/7].

Regards,
Ivan
