From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [GIT PULL] cpupower update for 4.15-rc2
Date: Sat, 18 Nov 2017 15:07:35 +0100
Message-ID: <CAJZ5v0hSAoJJbKqQL+cngFX5BOHkbZy7MjQm_yC5dZPGY2oooQ@mail.gmail.com>
References: <e7b8b542-2fc9-0b6f-da97-a0dd50a7d55d@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44039 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965859AbdKROHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Nov 2017 09:07:36 -0500
In-Reply-To: <e7b8b542-2fc9-0b6f-da97-a0dd50a7d55d@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Renninger <trenn@suse.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>

On Fri, Nov 17, 2017 at 7:20 PM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
> Hi Rafael,

Hi,

> Please pull the cpupower update for 4.15-rc2
>
> This update consists of fixes to tool's handling of offline cpus.
> The first patch fixes the tool to find information on the cpu it
> is running on, instead of always looking for cpu0 and failing if
> cpu0 happens to be offline.
>
> The second patch fixes the incorrect check for offline cpu status.
>
> Diff is attached.

Pulled, thanks!

Rafael
