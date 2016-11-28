From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle/powernv: staticise powernv_idle_driver
Date: Mon, 28 Nov 2016 14:35:13 +0100
Message-ID: <CAJZ5v0gaKtYq__2BQDHFqR1s77kDuRdCY70PEYpczLsMdMtttQ@mail.gmail.com>
References: <20161122050806.29564-1-andrew.donnellan@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34904 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932266AbcK1NfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 08:35:15 -0500
In-Reply-To: <20161122050806.29564-1-andrew.donnellan@au1.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux PM <linux-pm@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 22, 2016 at 6:08 AM, Andrew Donnellan
<andrew.donnellan@au1.ibm.com> wrote:
> powernv_idle_driver isn't exported, it can be made static. Found by sparse.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied.

Thanks,
Rafael
