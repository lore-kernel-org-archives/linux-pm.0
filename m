From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH v6] Thermal: introduce INT3406 thermal driver
Date: Tue, 16 Dec 2014 09:59:33 +0800
Message-ID: <548F9205.8060901@intel.com>
References: <54868CF6.6020505@intel.com>	<CAOesGMirF-_H2ZzFR-VpwkEErZE2uQJSYx5EuePArQsEh=r_Kw@mail.gmail.com>	<20141211010226.GA26253@aaronlu.sh.intel.com>	<CAOesGMj_uObbxLdpobEhP=nRPsFUJNCtq01RH7ZSECd5=1Ti6Q@mail.gmail.com>	<1418265472.12435.68.camel@rzhang1-toshiba>	<548934D0.8000502@intel.com>	<1418286781.12435.73.camel@rzhang1-toshiba>	<54895821.3050902@intel.com> <CAOesGMjKdi6wPsy+U1makbFyJpsj8RZykOZ5BEYrFWj_VzUxqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOesGMjKdi6wPsy+U1makbFyJpsj8RZykOZ5BEYrFWj_VzUxqA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 13/12/14 02:18, Olof Johansson wrote:
> Hi,
> 
> 
> 
> On Thu, Dec 11, 2014 at 12:38 AM, Aaron Lu <aaron.lu@intel.com> wrote:
>> INT3406 ACPI device object resembles an ACPI video output device, but its
>> _BCM is said to be deprecated and should not be used. So we will make
>> use of the raw interface to do the actual cooling. Due to this, the
>> backlight core has some modifications. Also, to re-use some of the ACPI
>> video module's code, one function has been exported.
>>
>> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
>> ---
>> v6: Fix an issue that wrongly set error path return value as reported
>> by Olof Johansson.
> 
> Last night's -next was still broken. I take it this wasn't applied
> yet? Please at least revert the original patch.

Indeed, not yet.
I believe Rui is waiting for you to confirm that the patch indeed
fix your problem, so can you please kindly give it a test? Thanks.

-Aaron

> 
> 
> -Olof
> 
