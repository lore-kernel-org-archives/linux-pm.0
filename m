Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37524C433F5
	for <linux-pm@archiver.kernel.org>; Mon, 23 May 2022 18:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244536AbiEWSwH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 May 2022 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbiEWSup (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2022 14:50:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089068AE51;
        Mon, 23 May 2022 11:35:26 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8D44160A;
        Mon, 23 May 2022 18:35:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D44160A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1653330924; bh=kcAiTLR767/FBIPqL0r5pjEkx2hifgnBNRkXiLI3vr0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XVe4aBPlSXbhX+XcnDlA29mvENgHBPpAwRncTaUKZv5pR5KLs8Sv2AfsAfBgBJrp2
         t3+uSuVKYkx4lsB95uHakBWxkepP7NRk6rFlirFRQ/0pVXbEd6yM+PdbLaj3X4YiJB
         l0nuLiZXLPk/vjSWAAFWuCHWEgK7+I050U3txTN02EUI1yHlLI6vnEmGSiX+XaQ0lI
         qGhq/29J34MPEj8hkWj3kLzVzwmHQ3NyIAOOHJwo2+CjIH2HPucG9nqV9+w1B9wI+t
         BsNC60ZMH7F+YwS34dUmR0yYd1vrsfYTfVYUJMA+dqIKNdpqrSRNDt31expannWCES
         GKg6g9mXg5q2Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, hdegoede@redhat.com, markgross@kernel.org
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, prarit@redhat.com
Subject: Re: [PATCH] Documentation: admin-guide: pm: Add Out of Band mode
In-Reply-To: <19189e1c806bf812e41a400e826c5e23892900e0.camel@linux.intel.com>
References: <20220523172757.2351052-1-srinivas.pandruvada@linux.intel.com>
 <871qwkb0rn.fsf@meer.lwn.net>
 <19189e1c806bf812e41a400e826c5e23892900e0.camel@linux.intel.com>
Date:   Mon, 23 May 2022 12:35:23 -0600
Message-ID: <87sfp09jx0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

srinivas pandruvada <srinivas.pandruvada@linux.intel.com> writes:

>> This suggests you haven't actually built the documentation with your
>> change and verified that you got the result you were after.
> You mean I should print the result with the command? Something like
> this:
> #intel-speed-select --oob
> Intel(R) Speed Select Technology
> OOB mode is enabled and will run as daemon

No, I meant building the docs and verifying that they looked right.

That said, adding the output seems fine...

Thanks,

jon
