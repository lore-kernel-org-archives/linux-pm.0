From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH 2/5] power: supply: tps65217: Remove IRQ data from driver
 data
Date: Wed, 23 Nov 2016 20:47:11 +0900
Message-ID: <ce8e80d3-3a40-0c82-8fa0-41a64c5097b1@gmail.com>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
 <20161115131855.4175-3-woogyom.kim@gmail.com>
 <20161122165107.nk2lm36nhz6wwlyp@earth>
 <20161122165829.kvpxzi6iddmr347b@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122165829.kvpxzi6iddmr347b@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/23/2016 01:58 AM, Sebastian Reichel wrote:
> On Tue, Nov 22, 2016 at 05:51:07PM +0100, Sebastian Reichel wrote:
>> > On Tue, Nov 15, 2016 at 10:18:52PM +0900, Milo Kim wrote:
>>> > > IRQ number is only used on requesting the interrupt, so no need to keep
>>> > > it inside the driver data.
> Please move simple cleanup patches like this one to the
> begin of the patch series.
>
>>> > > In case of polling, poll_task is valid only when polling thread is
>>> > > activated.
> And merge this change into the patch were you introduced the
> problem...

Thanks for your feedback. Let me regenerate the patch-set for better review.

Best regards,
Milo
