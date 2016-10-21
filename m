From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 3/4] soc: ti: Add ti_sci_pm_domains driver
Date: Fri, 21 Oct 2016 14:15:56 -0500
Message-ID: <86252d63-d7c6-3c4e-a21e-b48d600738ab@ti.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
 <20161019203347.17893-4-d-gerlach@ti.com> <7h4m45plxr.fsf@baylibre.com>
 <e13cd925-a62d-457d-cc99-fadd4d123256@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e13cd925-a62d-457d-cc99-fadd4d123256@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/21/2016 02:02 PM, Santosh Shilimkar wrote:
> On 10/21/2016 12:00 PM, Kevin Hilman wrote:
>> Dave Gerlach <d-gerlach@ti.com> writes:
>>
> [...]
>
>>
>> BTW, what is the the status of the TI-SCI protocol drivers themselves?
>> This can't be merged until that is or this won't even compile.
>>
> I was just about to ask the same question.

v4 was sent here which was just a rebase of v3 on v4.9-rc1 with no 
changes: http://www.spinics.net/lists/arm-kernel/msg536851.html

Should be ready to merge, just was too late during v4.8 cycle.

Regards,
Dave

>
> Regards,
> Santosh
>
