Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F91C7EE24
	for <linux-pm@archiver.kernel.org>; Mon,  5 Jun 2023 15:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjFEPY7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Jun 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjFEPY6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 11:24:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B4C5
        for <linux-pm@vger.kernel.org>; Mon,  5 Jun 2023 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685978697; x=1717514697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PcFFLjSAjsA3alpu5dF7mbIQQpH8uiRa0wKyPJ0RNyw=;
  b=LCv6wuickBgabvtLuDMJ8xQ8W0FrTzw8xAX0vaemWntfq9OnEhaLJ5HF
   R6K2BDN3iVI7wxfkLqOgMsAoPGN3xFG1hYwDWV+fVawZ33umzkCt1XA/H
   r9q916Z/oOMDPwQpj5DJKJS90MzDtBk9KtIB7HCjJNA2b8Z4PDJRnn+O2
   P3n9fNrbkCaFDIqz+THq5eV3qjF8rPE2l6wvIw9PpC6r3STdNYtiShto0
   NLehH5MUGJYWOG7Mb7gbVQATiZ6n/b4O8IDYfyVPacSIPcnau2h1J2vhx
   vyITt7XJFabNq6izdmjJRP/qkvOdwhfjuAiFhG0r88x4HW8dCYzbdEhFX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="358847502"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="358847502"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="702783666"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="702783666"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.212.149.103]) ([10.212.149.103])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 08:24:40 -0700
Message-ID: <22021153-1e98-25a5-2216-34f20e098247@linux.intel.com>
Date:   Mon, 5 Jun 2023 08:24:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/7] intel_idle: Add a way to skip the mwait check on all
 states
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com,
        Arjan van de Ven <arjan.van.de.ven@intel.com>
References: <20230601182801.2622044-1-arjan@linux.intel.com>
 <20230601182801.2622044-6-arjan@linux.intel.com>
 <CAJZ5v0gUCmf1e+uSQnYbQcTUjqDqKVjgJ=UaXW7Rk6NjB5K3Eg@mail.gmail.com>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0gUCmf1e+uSQnYbQcTUjqDqKVjgJ=UaXW7Rk6NjB5K3Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> I don't think that the static variable is needed here.
> 
> This function is only called from intel_idle_init_cstates_icpu() which
> in turn is only called by intel_idle_cpuidle_driver_init().
> 
> The latter is called directly by intel_idle_vminit() in the next patch
> and so it can be passed a bool arg indicating whether or not to skip
> the mwait checks.
> 

I think I found a nicer solution; will be in the next rev shortly

