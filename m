From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH]cpuidle: preventive check in cpuidle_select against crash
Date: Wed, 27 Dec 2017 01:42:58 +0100
Message-ID: <CAJZ5v0g36rdGVDT==CMCsnDFQ6ph2PxOyF0mgdMSfP4Wiv74TQ@mail.gmail.com>
References: <20171226072626.GA4153@gaurav.jindal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:46232 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdL0Am7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 19:42:59 -0500
In-Reply-To: <20171226072626.GA4153@gaurav.jindal>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gaurav jindal <gauravjindal1104@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Dec 26, 2017 at 8:26 AM, gaurav jindal
<gauravjindal1104@gmail.com> wrote:
> When selecting the idle state using cpuidle_select, there is no
> check on cpuidle_curr_governor. In cpuidle_switch_governor,
> cpuidle_currr_governor can be set to NULL to specify "disabled".

How exactly?
