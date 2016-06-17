From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] firmware: scpi: add device power domain support
Date: Fri, 17 Jun 2016 10:56:45 +0200
Message-ID: <CAPDyKFohYGyQshYNxTP103XDwWG5GYsfAPr8=DskNtzGBk2MJA@mail.gmail.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466082894.20208.1.camel@linaro.org> <5762A8FD.7070807@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5762A8FD.7070807@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-Id: linux-pm@vger.kernel.org

On 16 June 2016 at 15:26, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 16/06/16 14:14, Jon Medhurst (Tixy) wrote:
>>
>> On Thu, 2016-06-16 at 11:37 +0100, Sudeep Holla wrote:
>>>
>>> This series add support for SCPI based device device power state
>>> management using genpd.
>>>
>>> Regards,
>>> Sudeep
>>>
>>> v1[1]->v2:
>>>         - Fixed the endianness handling in scpi_device_get_power_state
>>>           as spotted by Tixy
>>>         - Renamed scpi_pd.c to scpi_pm_domain.c as suggested by Ulf
>>
>>
>> You seemed to also have made some changes to the contents of the file,
>> is that deliberate? This is the diff...
>>
>
> name array was accidental. I added it as I was not sure if I want to
> make it dynamic, just found I might be hitting the max while testing and
> added it.
>
> The other change was something that I found recently after I tried to
> get rid of juno coresight primecell override after I realized AMBA
> framework should be able to cope up with power domains. I will reply
> on that thread. Sorry for missing out this in changelog. I assume in my
> previous testings only the paths that ignored the return were executed.
>
> --
> Regards,
> Sudeep

For the series,

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
