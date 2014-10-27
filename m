From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 0/9] cpuidle driver for QCOM SoCs: 8064, 8074, 8084
Date: Mon, 27 Oct 2014 08:45:35 -0600
Message-ID: <20141027144535.GF30210@ilina-mac.qualcomm.com>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414401339.2343.2.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414401339.2343.2.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 27 2014 at 03:15 -0600, Ivan T. Ivanov wrote:

Hi Ivan, 
>
>Hi Lina,
>
>On Fri, 2014-10-24 at 17:40 -0600, Lina Iyer wrote:
>> Changes since v8:
>> [ https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg11473.html ]
>> - Flatten out the file structure - merge pm.c into spm.c after discussions
>> - Add a new function to set warm boot address, in scm-boot.c
>> - Support for 8064 (New)
>> - Tested on 8074, 8084. 8064 was tested with a WIP tree
>> - Address review comments from v8
>> - Looking into possiblility of  initializing the cpuidle device for a cpu,
>> only when the corresponding spm device is probed successfully.
>>
>>
>
>And this is based on...? Please, could you be explicit what kind
>of patches are needed before applying this patch set. Is seems
>that they don't depend just on "Lorenzo's ARM idle-states patches",
>I see patches from Stephen Boyd, Olav Haugan and Vikram Mulukutla
>in your tree.

You need these series of patches - 

1. Lorenzo's ARM common idle states
2. Stephen Boyd's SCM update series -
	https://lkml.org/lkml/2014/8/4/767
3. My SCM patches updating Stephen's (that I believe Kumar pulled in) - 
	http://www.spinics.net/lists/linux-arm-msm/msg10799.html
	http://www.spinics.net/lists/linux-arm-msm/msg10795.html

Thanks,
Lina
