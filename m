From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 4/7] max8903: adds requesting of gpios.
Date: Mon, 20 Jun 2016 14:20:57 +0200
Message-ID: <5767DFA9.30608@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
 <1466375242-38354-5-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1466375242-38354-5-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/20/2016 12:27 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> This change ensures all gpios are available for the driver to use and also
> splits off gpio setup into its own function for readability.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>
> ---
>  drivers/power/max8903_charger.c | 136 ++++++++++++++++++++++++++++++----------
>  1 file changed, 102 insertions(+), 34 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
