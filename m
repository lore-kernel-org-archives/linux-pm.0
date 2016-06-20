From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 2/7] max8903: store pointer to pdata instead of copying
 it.
Date: Mon, 20 Jun 2016 14:18:06 +0200
Message-ID: <5767DEFE.6060108@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
 <1466375242-38354-3-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1466375242-38354-3-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/20/2016 12:27 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Stores pointer to pdata because it easily allows pdata to reference
> either platform data or in the future device tree data.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

The same as in #1. For the record:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BR.
Krzysztof
