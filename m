Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1EEC4332F
	for <linux-pm@archiver.kernel.org>; Thu,  8 Dec 2022 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLHMth (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 8 Dec 2022 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiLHMth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2022 07:49:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5027CD1
        for <linux-pm@vger.kernel.org>; Thu,  8 Dec 2022 04:49:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrZ0Zg9z4xN1;
        Thu,  8 Dec 2022 23:49:34 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     rafael@kernel.org, npiggin@gmail.com,
        Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>,
        mpe@ellerman.id.au, daniel.lezcano@linaro.org,
        svaidy@linux.vnet.ibm.com
Cc:     srikar@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
In-Reply-To: <20221114145611.37669-1-aboorvad@linux.vnet.ibm.com>
References: <20221114073154.30407-1-aboorvad@linux.vnet.ibm.com> <20221114145611.37669-1-aboorvad@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooze state
Message-Id: <167050321754.1457988.14917789901150069869.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:40:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 14 Nov 2022 20:26:11 +0530, Aboorva Devarajan wrote:
> During the comparative study of cpuidle governors, it is noticed that the
> menu governor does not select CEDE state in some scenarios even though when
> the sleep duration of the CPU exceeds the target residency of the CEDE idle
> state this is because the CPU exits the snooze "polling" state when snooze
> time limit is reached in the snooze_loop(), which is not a real wake up
> and it just means that the polling state selection was not adequate.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooze state
      https://git.kernel.org/powerpc/c/5ddcc03a07ae1ab5062f89a946d9495f1fd8eaa4

cheers
