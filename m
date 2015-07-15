From: yu chen <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] intel_pstate: enable hwp per cpu
Date: Wed, 15 Jul 2015 19:17:53 +0800
Message-ID: <CADjb_WSyVQNeeKEoC+MEUfwZTEpzuAO8-Bwae24Z49vJCKewTQ@mail.gmail.com>
References: <1436892383-4217-1-git-send-email-kristen@linux.intel.com>
	<20150714105832.43ef93d0@kcaccard-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34184 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbGOLRy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 07:17:54 -0400
Received: by wibud3 with SMTP id ud3so78264448wib.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2015 04:17:53 -0700 (PDT)
In-Reply-To: <20150714105832.43ef93d0@kcaccard-desk.amr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On Wed, Jul 15, 2015 at 1:58 AM, Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:

>
> Oops - don't apply this one yet please.  I think I
> might have broken S3 resume.
>

Hi, Kristen
This patch will fix the S3 resume panic bug.
We encountered panic on kernel without this patch applied last week.
After this patch applied,  each cpu will get a chance to
re-enable HWP in intel_pstate_cpu_init, after resuming.

Yu
