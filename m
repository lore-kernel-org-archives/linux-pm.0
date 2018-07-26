From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: Re: [PATCH 2/2] turbostat: Add support for AMD Fam 17h (Zen) RAPL
Date: Thu, 26 Jul 2018 15:29:30 -0400
Message-ID: <0cd53c74f33c7218e158539b83e0ef59ef429923.camel@kepstin.ca>
References: <20180718222656.11795-1-calvin.walton@kepstin.ca>
         <20180718222656.11795-3-calvin.walton@kepstin.ca>
         <CAJvTdKnnaGrj3PSMd00B2GVAYk-KQ07aV72mbzPSTZRbXSsdng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKnnaGrj3PSMd00B2GVAYk-KQ07aV72mbzPSTZRbXSsdng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-07-26 at 15:10 -0400, Len Brown wrote:
> Hi Calvin,
> I'll assume you are waiting for this to be tested by somebody who has
> the HW (sorry, I don't have AMD HW to test this)
> and will re-send a checkpatch.pl clean version when you have that
> result.
> 
> thanks,
> -Len

I need to rebase this on top of the 4.18-rc code at a minimum, I
suspect there will be some conflicts due to the changes for system
"Nodes". (This patch was based off 4.17)

I'll resubmit the CPUID fix shortly, and continue working on the RAPL
patch.

Thanks,
Calvin.
