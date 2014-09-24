From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v5 1/4] of: Add bindings for nvidia,tegra124-soctherm
Date: Wed, 24 Sep 2014 13:43:40 -0600
Message-ID: <54231EEC.1080600@wwwdotorg.org>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com> <1408616242-21009-2-git-send-email-mperttunen@nvidia.com> <20140924184054.GA7593@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140924184054.GA7593@developer>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, juha-matti.tilli@iki.fi
List-Id: linux-pm@vger.kernel.org

On 09/24/2014 12:40 PM, Eduardo Valentin wrote:
> Hello,
>
> On Thu, Aug 21, 2014 at 01:17:19PM +0300, Mikko Perttunen wrote:
>> This adds binding documentation and headers for the Tegra124
>> SOCTHERM device tree node.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>
> Stephen, are you still queueing this series in your tree?

Yes, I except it makes sense to take this through the Tegra tree. 
However, it wont' be for 3.18, since I've already sent pull requests for 
this cycle.
