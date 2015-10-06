From: Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [RFC 1/7] arm64: pm/domains: try mutualize CPU domains init
 between arm/arm64
Date: Tue, 6 Oct 2015 10:52:05 +0200
Message-ID: <56138BB5.2070907@baylibre.com>
References: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
 <1443186249-14596-2-git-send-email-mtitinger+renesas@baylibre.com>
 <20151006022702.GA78570@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151006022702.GA78570@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com
List-Id: linux-pm@vger.kernel.org

On 06/10/2015 04:27, Lina Iyer wrote:
> On Fri, Sep 25 2015 at 07:04 -0600, Marc Titinger wrote:
>> From: Marc Titinger <mtitinger@baylibre.com>
>>
>> fake path to start testing, eventually move this out of /arch/.
>> incidently enable PM_GENERIC_DOMAINS for VExpress.
>>
> In fact, this could be moved out of ARM. My last series moved it to
> drivers/base/power/.
>
> -- Lina
>

Hi Lina, thanks for the heads-up, rebase of my patch-set in progress :)

Marc.
