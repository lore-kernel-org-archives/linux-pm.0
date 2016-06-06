From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 0/6] Support BCM23550 SoC
Date: Mon, 6 Jun 2016 11:53:25 -0700
Message-ID: <5755C6A5.1040202@gmail.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Brand <chris.brand@broadcom.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/11/2016 02:36 PM, Chris Brand wrote:
> This patchset introduces support for the BCM23550 SoC and the Broadcom
> Sparrow development board.
> 
> It modifies the BCM21664 support slightly to share code between the two.
> 
> With this patchset, a multi-v7 kernel brings up all 4 CPUs on a Sparrow
> board, and gets to a shell prompt. Many of the IP blocks that are shared
> with BCM28155 and BCM21664 are also functional, although not all have
> been thoroughly tested.
> 
> Changes since v1
> - Moved chosen node from dtsi to dts file
> - Added stdout-path property to chosen node in dts
> - Removed "-cpu-method" from CPU enable method name

Series applied, patch 1 applied to drivers/next, patches 2, 4 and 5
applied to soc/next, and patches 2 and 6 applied to devicetree/next,
thanks everyone!
-- 
Florian
