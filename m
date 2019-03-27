From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] power: reset: syscon-reboot: add a mask property
Date: Wed, 27 Mar 2019 18:53:58 -0500
Message-ID: <20190327235358.GA30280@bogus>
References: <20190308074930.15270-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308074930.15270-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schiller <ms@dev.tdt.de>
Cc: sre@kernel.org, mark.rutland@arm.com, fkan@apm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 08, 2019 at 08:49:30AM +0100, Martin Schiller wrote:
> Make the syscon-reboot driver accept value and mask instead of
> just value.
> 
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
> 
> This patch is based on commit
> f2c199db477e ("power: reset: syscon-poweroff: add a mask property")
> and does the same change for the syscon-reboot driver.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot.txt | 11 +++++++++--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/reset/syscon-reboot.c                   | 19 +++++++++++++++++--
>  2 files changed, 26 insertions(+), 4 deletions(-)
