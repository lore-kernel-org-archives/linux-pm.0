From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/5] ACPI / boot: Don't handle SCI on HW reduced
 platforms
Date: Tue, 18 Jul 2017 13:11:16 +0300
Message-ID: <1500372676.29303.65.camel@linux.intel.com>
References: <20170717132946.20892-1-andriy.shevchenko@linux.intel.com>
         <20170717132946.20892-6-andriy.shevchenko@linux.intel.com>
         <596DD9BF.5000509@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:29475 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751322AbdGRKPu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Jul 2017 06:15:50 -0400
In-Reply-To: <596DD9BF.5000509@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 2017-07-18 at 17:49 +0800, Hanjun Guo wrote:
> On 2017/7/17 21:29, Andy Shevchenko wrote:
> > WIP
> 
> Does it mean not ready for upstream yet?

Yep, this patch is subject to discussion. I will update it in v3, though
it would be nice to discuss anyway (and test on some hardware reduced
platforms).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
