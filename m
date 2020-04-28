Return-Path: <SRS0=CzTI=6M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94792C83004
	for <linux-pm@archiver.kernel.org>; Tue, 28 Apr 2020 03:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56680206D6
	for <linux-pm@archiver.kernel.org>; Tue, 28 Apr 2020 03:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="qvBZYugu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgD1D1u (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:27:50 -0400
Received: from mx1.riseup.net ([198.252.153.129]:48878 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgD1D1u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 23:27:50 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49B6Xk03C7zFdlK;
        Mon, 27 Apr 2020 20:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588044470; bh=a0Wy7E5siiXDebQgyesDP0oK49d8RJIPyuqff09a1uA=;
        h=From:To:Cc:Subject:Date:From;
        b=qvBZYugun/cXoZMk7BOsRQjugepg2LvPUI28aUOYF69bJE+8qP7qMj5nSNkhIQEiW
         63eoT8UhQy2RsL+Kp6K106FhdhM/Vl1QROCS6dYncVNCp6d07U5iJlMNA5GlZbFIGj
         Nnz+LkQVf5w6IPUXdDubqEa+REFrpfemHU59tpkY=
X-Riseup-User-ID: 53C500CA5D871291934B90EAD4C245BCC82D2E323A6C8690E133045A54D58370
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 49B6Xj4DckzJqbk;
        Mon, 27 Apr 2020 20:27:49 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada\, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        chris.p.wilson@intel.com,
        "Vivi\, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC] GPU-bound energy efficiency improvements for the intel_pstate driver (v2.99)
Date:   Mon, 27 Apr 2020 20:22:47 -0700
Message-Id: <20200428032258.2518-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This addresses the technical concerns people brought up about my
previous v2 revision of this series.  Other than a few bug fixes, the
only major change relative to v2 is that the controller is now exposed
as a new CPUFREQ generic governor as requested by Rafael (named
"adaptive" in this RFC though other naming suggestions are welcome).
Main reason for calling this v2.99 rather than v3 is that I haven't
yet addressed all the documentation requests from the v2 thread --
Will spend some time doing that as soon as I have an ACK (ideally from
Rafael) that things are moving in the right direction.

You can also find this series along with the WIP code for non-HWP
platforms in this branch:

https://github.com/curro/linux/tree/intel_pstate-vlp-v2.99

Thanks!

[PATCHv2.99 01/11] PM: QoS: Add CPU_SCALING_RESPONSE global PM QoS limit.
[PATCHv2.99 02/11] drm/i915: Adjust PM QoS scaling response frequency based on GPU load.
[PATCHv2.99 03/11] OPTIONAL: drm/i915: Expose PM QoS control parameters via debugfs.
[PATCHv2.99 04/11] cpufreq: Define ADAPTIVE frequency governor policy.
[PATCHv2.99 05/11] cpufreq: intel_pstate: Reorder intel_pstate_clear_update_util_hook() and intel_pstate_set_update_util_hook().
[PATCHv2.99 06/11] cpufreq: intel_pstate: Call intel_pstate_set_update_util_hook() once from the setpolicy hook.
[PATCHv2.99 07/11] cpufreq: intel_pstate: Implement VLP controller statistics and target range calculation.
[PATCHv2.99 08/11] cpufreq: intel_pstate: Implement VLP controller for HWP parts.
[PATCHv2.99 09/11] cpufreq: intel_pstate: Enable VLP controller based on ACPI FADT profile and CPUID.
[PATCHv2.99 10/11] OPTIONAL: cpufreq: intel_pstate: Add tracing of VLP controller status.
[PATCHv2.99 11/11] OPTIONAL: cpufreq: intel_pstate: Expose VLP controller parameters via debugfs.

