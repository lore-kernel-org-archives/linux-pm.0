From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
Date: Thu, 31 May 2018 09:03:50 +0100
Message-ID: <e313f870-ef27-7721-9395-31671f00ef4a@nvidia.com>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-9-ulf.hansson@linaro.org>
 <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
 <CAPDyKFrV5fosZ1QZ4un+okzpeQDM3QSCBWJB1YZH4WNxKf_FVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrV5fosZ1QZ4un+okzpeQDM3QSCBWJB1YZH4WNxKf_FVQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Todor Tomov <todor.tomov@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 31/05/18 07:17, Ulf Hansson wrote:
> [...]
> 
>>> +/**
>>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>>> + * @dev: Device to attach.
>>
>> Can you update the description of the above as well?
> 
> Yes, like below?
> 
> genpd_dev_pm_attach_by_id() - Associate a device with one of its PM domains.
> @dev: The device used to lookup the PM domain.

Yes perfect.

Thanks
Jon

-- 
nvpublic
