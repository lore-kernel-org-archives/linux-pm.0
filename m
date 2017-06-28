From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/8] PM / Domains: Bunch of small improvements and fixes
Date: Thu, 29 Jun 2017 01:45:02 +0200
Message-ID: <1528807.67rBpCe9VW@aspire.rjw.lan>
References: <20170628145623.20716-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63459 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751495AbdF1Xwf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 19:52:35 -0400
In-Reply-To: <20170628145623.20716-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday, June 28, 2017 04:56:15 PM Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v2:
> =================
> 1. Add Ulf's acks.
> 2. Re-order patches so the un-acked commits are at the end.
> 
> Changes since v1:
> =================
> 1. Patch 2/8: Follow Ulf's advice and use genpd_lookup_dev() which also
>    solves risk of calling this for non-genpd (thus I added Ulf's
>    Reported-by).

[1-6/8] applied, the remaining two need ACKs from the genpd people.

Thanks,
Rafael
