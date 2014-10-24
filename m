From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
Date: Fri, 24 Oct 2014 08:30:39 -0600
Message-ID: <20141024143039.GD30210@ilina-mac.qualcomm.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1414078317.4214.4.camel@mm-sol.com>
 <20141023155435.GA30210@ilina-mac.qualcomm.com>
 <1414144885.2025.4.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414144885.2025.4.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 24 2014 at 04:01 -0600, Ivan T. Ivanov wrote:
>
>On Thu, 2014-10-23 at 09:54 -0600, Lina Iyer wrote:
>> On Thu, Oct 23 2014 at 09:31 -0600, Ivan T. Ivanov wrote:
>> > >
>> > >Hi,
>> > >
>> > >On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
>> > >  Hi,
>> > > >
>> > >  This v8 revision of the cpuidle driver is available at
>> > >  git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
>> > > >
>> > >
>> > >Probably I missing something, but should I expect that
>> > >once these patches are applied driver could be successfully
>> >  compiled?
>> Yes they should.
>
>Do these patches depends on other patches, which I am missing.
>I am applying them on current linus/master. At least <soc/qcom/scm.h>
>and <soc/qcom/scm-boot.h> are missing from this patch-set v8 :-|
>

Oh sorry, if you look at the cover letter, in the past, these patches
have been pulled in or being staged.

You can get the tree and the the patches from 
https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/cpuidle-v8

which are on top of 3.17-rc1, but you should be able to pull it on top
of yours, without any issue. Do note that some of these patches that I
have on top of 3.17-rc1 (like the ARM idle states) may already be
available in linus/master.

Hope that helps.

Lina
