From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 5/7] max8903: removes non zero validity checks on gpios.
Date: Mon, 20 Jun 2016 14:21:56 +0200
Message-ID: <5767DFE4.7060306@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
 <1466375242-38354-6-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1466375242-38354-6-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/20/2016 12:27 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> Prior to this commit a zero gpio was treated as invalid. Whereas
> gpio_is_valid() will treat a zero gpio as valid.
> 
> This commit removes the confusion and explicitly uses gpio_is_valid()
> throughout. Which in turn results in several of the error messages becoming
> redundant and thus removed.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>

The same as in #1, I already reviewed it. For the record:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BR.
Krzysztof
