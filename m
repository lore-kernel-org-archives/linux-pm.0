From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 6/8] devfreq: exynos4: Fix power-leakage of clock on
 suspend state
Date: Mon, 17 Mar 2014 11:58:05 +0900
Message-ID: <532664BD.5020308@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-7-git-send-email-cw00.choi@samsung.com>
 <532341C7.8070407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <532341C7.8070407@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On 03/15/2014 02:52 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 13.03.2014 09:17, Chanwoo Choi wrote:
>> This patch disable ppmu clocks before entering suspend state to remove
>> power-leakage and enable ppmu clocks on resume function.
> 
> I don't think there is any need for this, because all the clocks are stopped anyway in SLEEP mode.

OK, I'll discard this patch on next patchset.

Best Regards,
Chanwoo Choi



