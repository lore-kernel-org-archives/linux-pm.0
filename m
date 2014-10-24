From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
Date: Fri, 24 Oct 2014 09:51:15 +0530
Message-ID: <CAHLCerMY3SCNixQjh7k2F=3DK1qa7JMeWsvwv426wNt8A_Vm-A@mail.gmail.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
	<1414078317.4214.4.camel@mm-sol.com>
	<20141023155435.GA30210@ilina-mac.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141023155435.GA30210@ilina-mac.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@linaro.org>, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 23, 2014 at 9:24 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Thu, Oct 23 2014 at 09:31 -0600, Ivan T. Ivanov wrote:
>>
>>
>> Hi,
>>
>> On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
>>>
>>> Hi,
>>>
>>> This v8 revision of the cpuidle driver is available at
>>> git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
>>>
>>
>> Probably I missing something, but should I expect that
>> once these patches are applied driver could be successfully
>> compiled?
>
> Yes they should.
>>
>>
>> Patches definitely break bisectability. For example [PATCH v8 1/7]
>> is using <soc/qcom/pm.h> which is introduced [PATCH v8 4/7].
>>
> You are right. I missed checking compilation against each patch.
> Based on some discussion, I need to see if pm.h is even needed.
>

git test-sequence[1] is your friend.

[1] http://dustin.sallings.org/2010/03/28/git-test-sequence.html
