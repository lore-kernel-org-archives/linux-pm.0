From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 0/7] Bring suspend to RAM support to MVEBU SATA
Date: Fri, 11 Jan 2019 14:48:08 -0700
Message-ID: <b5be50cf-336b-c10f-5cb1-efbf8b69ab61@kernel.dk>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <35c5cdcf-0d89-9236-7937-0c750a781d13@kernel.dk>
 <20190111143404.518723a3@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190111143404.518723a3@xps13>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 1/11/19 6:34 AM, Miquel Raynal wrote:
> Hi Jens,
> 
> Jens Axboe <axboe@kernel.dk> wrote on Tue, 4 Dec 2018 17:11:18 -0700:
> 
>> On 12/4/18 12:28 PM, Miquel Raynal wrote:
>>> Hello,
>>>
>>> As part of an effort to bring suspend to RAM support to Armada 3700
>>> SoCs (main target: ESPRESSObin), this series handles the work around
>>> the SATA IP.
>>>
>>> First, a change in the libahci platform adds support for the new PHY
>>> framework by following the phy_set_mode()/phy_power_on()
>>> sequence. Then, the AHCI MVEBU driver is a bit updated (patch 2 & 3)
>>> and a missing initialization is added for the A3700 in patch 4 (only
>>> done by the Bootloader before). Missing clock support is implemented
>>> in patch 5 to be sure the clock will be resumed before this driver
>>> (see [1] for the series adding device links to the clock core).
>>>
>>> Finally, device trees are updated to reflect the hardware: the missing
>>> PHY is added to the ESPRESSObin DT, and the clock is added to the SoC
>>> DT (patch 6 & 7). Bindings already document the clock and the PHY so
>>> no update is needed on this regard.  
>>
>> Probably the best/easiest to queue this through the libata tree for
>> 4.21. Agree?
>>
> 
> It looks like this patchset got left aside for 5.0, shall I re-send? (I
> rebased on top of 5.0 and the series applied fine).

I never got a reply to the above, so I didn't add it. I've now picked
up 1-5, 6-7 should go in through someone elses tree.

-- 
Jens Axboe
