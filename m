From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/4] AnalyzeSuspend v4.5
Date: Thu, 9 Feb 2017 22:42:33 +0100
Message-ID: <CAJZ5v0hPYRWwjwR=pRcLL1oazvxv40iF6GztGY9kApUBkxGJJQ@mail.gmail.com>
References: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35344 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdBJCT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 21:19:56 -0500
Received: by mail-ot0-f196.google.com with SMTP id 65so2444414otq.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2017 18:19:56 -0800 (PST)
In-Reply-To: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, todd.e.brandt@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rafael Wysocki <rafael.j.wysocki@intel.com>

On Thu, Feb 9, 2017 at 10:27 PM, Todd Brandt
<todd.e.brandt@linux.intel.com> wrote:
> This patch series updates the tool from v4.2 to v4.5. The patches
> can be combined into a single commit for brevity.
>
> Todd Brandt (4):
>   AnalyzeSuspend v4.3
>   AnalyzeSuspend v4.4
>   AnalyzeSuspend v4.5
>   AnalyzeSuspend v4.5: fix drag and zoom bug in javascript
>
> v2 changes:
>  - added v4.5 fixes since initial upstream attempt
> v3 changes:
>  - resubmit with fixes to v2 submit errors
>
>  scripts/analyze_suspend.py | 1933 ++++++++++++++++++++++++++------------------
>  1 file changed, 1135 insertions(+), 798 deletions(-)
>
> --

I applied the previous iteration.

Have patches [1-3/4] changed since then?

Thanks,
Rafael
