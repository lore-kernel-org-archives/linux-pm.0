From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RESEND v2] power: reset: keystone: Enable COMPILE_TEST
Date: Fri, 03 Jun 2016 08:59:48 +0200
Message-ID: <57512AE4.2090203@samsung.com>
References: <1459298988-20530-1-git-send-email-k.kozlowski@samsung.com>
 <20160415142752.GC24087@earth>
 <CAJKOXPdACNfhYj8cbrU6sUU+R7vSe+TOsRCPizhvu753KjavoA@mail.gmail.com>
 <20160603021339.GC8921@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160603021339.GC8921@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/03/2016 04:13 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, May 23, 2016 at 08:12:31AM +0200, Krzysztof Kozlowski wrote:
>> On Fri, Apr 15, 2016 at 4:27 PM, Sebastian Reichel <sre@kernel.org> wrote:
>>> Hi,
>>>
>>> On Wed, Mar 30, 2016 at 09:49:48AM +0900, Krzysztof Kozlowski wrote:
>>>> Enable the COMPILE_TEST to get build coverage, except on platforms
>>>> !HAS_IOMEM (required by selected MFD_SYSCON).
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>>> Thanks, queued.
>>
>> Hey,
>>
>> I can't find this patch in your recent pull request. What happened?
> 
> Sorry, I noticed, that I forgot to push it to -next and didn't want
> to include untested patches in the pull request. It's the first
> patch being queued for 4.8.

OK, no problem. Thanks for letting me know.

Best regards,
Krzysztof
