From: Chris Brand <chris.brand@broadcom.com>
Subject: Re: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
Date: Tue, 7 Jun 2016 12:40:41 -0700
Message-ID: <CAMsMSK9X2ME=nyBhD4q8MvdYrqe7h+SmVstD++1OfBn-uvuSHA@mail.gmail.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
	<1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
	<57409633.8060605@gmail.com>
	<20160603023853.GD8921@earth>
	<CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
	<20160607015017.GA25073@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607015017.GA25073@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 6, 2016 at 6:50 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Mon, Jun 06, 2016 at 09:42:03AM -0700, Chris Brand wrote:
>> On Thu, Jun 2, 2016 at 7:38 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> > Feel free to queue it via arm-soc with
>> >
>> > Acked-By: Sebastian Reichel <sre@kernel.org>
>> >
>> > If I didn't overlook it, it's missing DT documentation, though.
>>
>> Thanks, Sebastian. Because this is effectively a move of code from
>> arch/arm rather than new code, there's already dt documentation in
>> Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt
>
> Ok. That directory is usually used for periphal reset controller.
> Board/System reset controllers are usually documented in
> .../bindings/power/reset (following kernel strucuture
> [drivers/reset and drivers/power/reset]).
>
> -- Sebastian

Would you like me to send a separate patch to move that file ?

Chris
