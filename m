From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
Date: Fri, 24 Mar 2017 10:19:13 -0500
Message-ID: <20170324151913.lr224la5choqtwxt@rob-hp-laptop>
References: <20170318155632.18099-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:34721 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756746AbdCXPUE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 11:20:04 -0400
Content-Disposition: inline
In-Reply-To: <20170318155632.18099-1-zajec5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>

On Sat, Mar 18, 2017 at 04:56:31PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This commit documents binding for thermal used in Northstar family SoCs.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/thermal/brcm,ns-thermal         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal

Acked-by: Rob Herring <robh@kernel.org>
