From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Fri, 06 Aug 2010 09:06:26 +0200
Message-ID: <4C5BB472.5000207@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C52DF50.80009@kernel.org> <4C5AE1E2.6070601@gmail.com> <201008060830.50889.stephan.diestelhorst@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <201008060830.50889.stephan.diestelhorst@amd.com>
Sender: linux-ide-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 08/06/2010 08:30 AM, Stephan Diestelhorst wrote:
> On Thursday 05 August 2010, 18:08:02 Tejun Heo wrote:
>> Can you please try the following patch and see whether the problem
>> goes away?
> <snip>
> 
> to which revision does the patch apply? I didn't get it to apply
> cleanly to Linus' kernel HEAD or the 2.6.34 stable tag. Maybe I am
> missing something, since I am a git-n00b (use Mercurial all the time)?

It applies cleanly to v2.6.35.

Thanks.

-- 
tejun
