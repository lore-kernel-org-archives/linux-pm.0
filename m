From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/3] cpuidle/drivers/mbed: Add new governor for embedded
 systems
Date: Tue, 2 Apr 2019 18:02:02 +0200
Message-ID: <a8db3115-b12b-3a8a-5dfc-a3d068ac3810@linaro.org>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-4-daniel.lezcano@linaro.org>
 <20190402132236.7h264nffbgnojznw@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402132236.7h264nffbgnojznw@queper01-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/04/2019 15:22, Quentin Perret wrote:
> Hi Daniel,
> 
> On Friday 08 Mar 2019 at 22:20:47 (+0100), Daniel Lezcano wrote:
>> Despite the naive idle state selection for this first iteration, the
>> governor provides a performance improvement of 30% for Jankbench
>> throughout for the same amount of energy than the menu governor
> 
> Wow, that sounds really good. Which kernel and board did you use for
> testing ? What's the perf. metric here ? The 99% percentile of frame
> completion time ?

Hi Quentin,

I tried on a hikey960 with an android kernel 4.19.

The used percentile is the 95%, the tests are jankbench list_view and
edit_text, and exoplayer. Values are normalized against the menu governor:

list_view:
 frame duration -35%
 count: +20%
 energy: +1%

edit text:
 frame duration -45%
 count: +27%
 energy: -0.3%

For audio and video playback, there is no frame drop.

audio
 - energy: -2.8%

video
 - energy: -3.8%

These are preliminary results.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
