From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 0/5] Functional dependencies between devices
Date: Thu, 03 Nov 2016 04:55:29 +0800
Message-ID: <581A52C1.1010907@linaro.org>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <13957403.ZrB4mMbICz@vostro.rjw.lan> <5811F0CF.5000204@huawei.com> <20161028093959.GA7889@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028093959.GA7889@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Hanjun Guo <guohanjun@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On 10/28/2016 05:39 PM, Lukas Wunner wrote:
> On Thu, Oct 27, 2016 at 08:19:27PM +0800, Hanjun Guo wrote:
>> I'm trying to using this patch set to solve the functional dependency
>> between devices and irqchip, which are both ACPI platform devices.
>> irqchip needs to be probed before the devices connecting to them,
>> which specifically, it's the mbi-gen support I send out recently:
>>
>> https://lkml.org/lkml/2016/10/25/453
>>
>> But I didn't see an example to do so in this patch set, and seems that
>> some extra code needs to be added for that purpose, could you give me
>> some suggestions for how to do that then I can work on and test against
>> your patch set?
>
> If the consumers can detect that there's a consumer on which they depend,
> you could call device_link_add() from their ->probe hook.
>
> Generally the earliest point in time when device links can be added is
> after device_initialize() has been called for the consumer and device_add()
> has been called for the supplier.  (At least that's my understanding.)

Thank you, currently I'm on travailing and will take a deep look to
see if it works (or adding things on top) on my case.

Thanks
Hanjun
