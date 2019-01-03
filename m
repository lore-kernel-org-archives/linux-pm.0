From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
Date: Thu, 3 Jan 2019 21:49:58 +0100
Message-ID: <03b8e4ab-412e-24cf-9c79-5939896b3008@redhat.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
 <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
 <20190103185917.zfcw24n5w4n4qu2q@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103185917.zfcw24n5w4n4qu2q@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 03-01-19 19:59, Wolfram Sang wrote:
> 
>> I share your desire to have the check for this shared in core code,
>> but I'm afraid that just is not going to work.
> 
> Okay, so this series is definately not it. Probably the previous one
> which exposes helpers is not a bad idea after all. Because it is
> ulitmately the driver's decision when to use the helpers...

Agreed.

Regards,

Hans
