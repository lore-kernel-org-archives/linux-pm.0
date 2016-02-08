From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] power: bq24735-charger: document
 'ti,external-control' option
Date: Mon, 8 Feb 2016 11:24:54 -0600
Message-ID: <20160208172454.GA29402@rob-hp-laptop>
References: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
 <1454479426-6437-4-git-send-email-sctincman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49602 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbcBHRY6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Feb 2016 12:24:58 -0500
Content-Disposition: inline
In-Reply-To: <1454479426-6437-4-git-send-email-sctincman@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Tinkham <sctincman@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org

On Tue, Feb 02, 2016 at 11:03:46PM -0700, Jonathan Tinkham wrote:
> Implement an 'external-control' option for when the charger
> shouldn't be configured by the kernel.
> 
> Signed-off-by: Jonathan Tinkham <sctincman@gmail.com>
> ---
>  Documentation/devicetree/bindings/power_supply/ti,bq24735.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
