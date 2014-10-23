From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
Date: Thu, 23 Oct 2014 09:54:35 -0600
Message-ID: <20141023155435.GA30210@ilina-mac.qualcomm.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1414078317.4214.4.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414078317.4214.4.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 23 2014 at 09:31 -0600, Ivan T. Ivanov wrote:
>
>Hi,
>
>On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
>> Hi,
>>
>> This v8 revision of the cpuidle driver is available at
>> git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
>>
>
>Probably I missing something, but should I expect that
>once these patches are applied driver could be successfully
> compiled?
Yes they should.
>
>Patches definitely break bisectability. For example [PATCH v8 1/7]
>is using <soc/qcom/pm.h> which is introduced [PATCH v8 4/7].
>
You are right. I missed checking compilation against each patch.
Based on some discussion, I need to see if pm.h is even needed.

>Regards,
>Ivan
>
>
