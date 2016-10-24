From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V7 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Mon, 24 Oct 2016 18:21:17 +0200
Message-ID: <eaff4043-5a62-da2d-cee1-9962b8c4783a@i2se.com>
References: <1474446227-1147-1-git-send-email-kernel@martin.sperl.org>
 <1474446227-1147-3-git-send-email-kernel@martin.sperl.org>
 <87twczg27x.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87twczg27x.fsf@eliezer.anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: kernel@martin.sperl.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, Will Deacon <will.deacon@arm.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Martin,

Am 28.09.2016 um 23:10 schrieb Eric Anholt:
> kernel@martin.sperl.org writes:
>
>> From: Martin Sperl <kernel@martin.sperl.org>
>>
>> Add basic thermal driver for bcm2835 SOC.
>>
>> This driver currently relies on the firmware setting up the
>> tsense HW block and does not set it up itself.
>>
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> Acked-by: Eric Anholt <eric@anholt.net>
>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> What's the status of merging this one?  I'd like to merge the other
> patches.

i think it's necessary to rebase the whole series. Maybe we could get it
into 4.10.

Stefan
