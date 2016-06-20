From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 3/7] max8903: cleans up confusing relationship between
 dc_valid, dok and dcm.
Date: Mon, 20 Jun 2016 14:18:03 +0200
Message-ID: <5767DEFB.8010207@samsung.com>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466375242-38354-1-git-send-email-chris@cpdesign.com.au>
 <1466375242-38354-4-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1466375242-38354-4-git-send-email-chris@cpdesign.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/20/2016 12:27 AM, Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> The max8903_charger.h file indicated that dcm and dok were not optional
> when dc_valid is set.
> 
> It makes sense to have dok as a compulsory pin when dc_valid is given.
> However dcm can be optionally wired to a fixed level especially when the
> circuit is configured for dc power exclusively.
> 
> The previous implementation already allowed for this somewhat, however no
> error was given if dok wasn't given whilst dc_valid was.
> 
> The new implementation enforces dok presence when dc_valid is given. Whilst
> allowing dcm to be optional.
> 
> Signed-off-by: Chris Lapa <chris@lapa.com.au>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

BR.
Krzysztof
