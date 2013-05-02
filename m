From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: DT: tegra: pinctrl suspend resume hook
Date: Thu, 02 May 2013 12:33:31 -0600
Message-ID: <5182B17B.8050702@wwwdotorg.org>
References: <1366740542-26127-1-git-send-email-bbasu@nvidia.com> <1366740542-26127-2-git-send-email-bbasu@nvidia.com> <20130426194908.GA3302@avionic-0098.mockup.avionic-design.de> <77F7DB30C698A44DA22FB222C89DE941A6692E62BD@BGMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <77F7DB30C698A44DA22FB222C89DE941A6692E62BD-kdsAE/FnitNDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bibek Basu <bbasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 04/28/2013 07:42 AM, Bibek Basu wrote:
>> -----Original Message-----
>> From: Thierry Reding [mailto:thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org]
>> Sent: Saturday, April 27, 2013 1:19 AM
>> To: Bibek Basu
>> Cc: Rafael J. Wysocki; linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org;
>> linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [PATCH 2/2] ARM: DT: tegra: pinctrl suspend resume hook
>>
>> * PGP Signed by an unknown key
>>
>> On Tue, Apr 23, 2013 at 11:39:02PM +0530, Bibek Basu wrote:
>>> Make pinmux as the first node of tegra DT so as to achieve pinctrl as
>>> last device to suspend and first device to resume.
>>
>> I don't think this is a good idea. For one it encodes Linux specific
>> implementation details within the device tree. Furthermore I seem to
>> remember that the device tree makes no guarantees that the order of nodes
>> in the blob is the same as the order in the DTS.
>>
>> That said I don't have a good alternative. Perhaps one solution would be to
>> use suspend_late() and resume_early() for the pinmux driver since they will
>> be called after and before the suspend() and resume() callbacks of all other
>> devices, respectively. Other than that I wasn't able to find anything about
>> forcing a particular order during suspend and resume.
>>
>> Cc'ing Rafael and the linux-pm mailing list, maybe somebody among them
>> knows a proper solution.
>
> Stephen actually suggested me earlier to add dummy pinmux state on all dependent devices node. And that will make sure that dependency of driver prevails.
> I tried that but I was not getting the desired result.
> Can anyone tell me correct syntax for adding dummy state?

I agree with Thierry that this patch is not the correct approach.

A dummy pinctrl state would look something like the following in each
affected device node:

                pinctrl-names = "default";
                pinctrl-0 = <>;
