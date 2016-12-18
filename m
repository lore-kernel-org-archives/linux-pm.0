From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH v2 0/8] power: supply: tps65217: Support USB charger
 feature
Date: Sun, 18 Dec 2016 11:57:54 +0900
Message-ID: <c02e88cb-da46-df9a-ffb7-1eec55d7ba9d@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
 <20161217162400.7yqiibcrkzp5ac3q@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36861 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcLRC57 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 21:57:59 -0500
In-Reply-To: <20161217162400.7yqiibcrkzp5ac3q@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/18/2016 01:24 AM, Sebastian Reichel wrote:
> patches look fine, but these two patches must be reordered to fix
> bisectability. Otherwise after patch 1 the thread is not properly
> killed during driver removal.

Thanks for your guidelines. The v3 patchset has been sent.

Best regards,
Milo
