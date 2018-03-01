From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: gpio-poweroff: Add
 'timeout-ms' property
Date: Thu, 1 Mar 2018 17:26:45 -0600
Message-ID: <20180301232645.k4lraqvb2qqccipc@rob-hp-laptop>
References: <20180222231714.11843-1-mdf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180222231714.11843-1-mdf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, sre@kernel.org, andy.shevchenko@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 22, 2018 at 03:17:13PM -0800, Moritz Fischer wrote:
> Add 'timeout-ms' property to support boards where the 3s timeout that the
> current driver defaults to is too short.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Changes from v2:
> - Addressed Rob's feedback (timeout_ms -> timeout-ms)
> 
> Changes from v1:
> - Addressed Rob's feedback (timeout -> timeout_ms)
> - Added to old example rather than creating separate one
> 
> ---
> 
>  Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
