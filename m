From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V5 0/7] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Tue, 18 Feb 2014 13:18:32 -0700
Message-ID: <5303C018.1020707@wwwdotorg.org>
References: <cover.1392273722.git.viresh.kumar@linaro.org>	<52FE71BD.3020103@wwwdotorg.org>	<2869027.iYHxWOSS2C@vostro.rjw.lan>	<52FEAECA.5080905@wwwdotorg.org> <CAKohpomhvuQQ0JN3wgLBnrSpFUjC9J9QwWZpD9nA6AFYw+paKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomhvuQQ0JN3wgLBnrSpFUjC9J9QwWZpD9nA6AFYw+paKA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Kgene Kim <kgene.kim@samsung.com>, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 02/17/2014 02:20 AM, Viresh Kumar wrote:
> On 15 February 2014 05:33, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 02/14/2014 03:23 PM, Rafael J. Wysocki wrote:
> 
>>> Well, it would be good to verify which part, then.
>>
>> Patch 2/7 appears to stop that message from being printed during
>> suspend, and perhaps reduce the number of times it's printed during
>> resume. Patch 7/7 stops the message being printed at all.
>>
>> Looking at patch 7, I wonder if it's simply because tegra_target() was
>> modified never to return -EBUSY, so the bug is still there, but it's
>> just been hidden.
> 
> No, the bug is removed now. Its hidden in current linus/master :)

I'm not sure what that means; I still see the message:

cpufreq: __cpufreq_driver_target: Failed to change cpu frequency: -16

... in Linus's tree (805937cf45f9 "Merge tag 'ext4_for_linus_stable' of
git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4").
