From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 3/3] cpuidle/drivers/mbed: Add new governor for embedded
 systems
Date: Tue, 2 Apr 2019 17:26:05 +0100
Message-ID: <20190402162605.sfu7xasexmno5qx7@queper01-lin>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
 <20190308212047.28767-4-daniel.lezcano@linaro.org>
 <20190402132236.7h264nffbgnojznw@queper01-lin>
 <a8db3115-b12b-3a8a-5dfc-a3d068ac3810@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a8db3115-b12b-3a8a-5dfc-a3d068ac3810@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 Apr 2019 at 18:02:02 (+0200), Daniel Lezcano wrote:
> I tried on a hikey960 with an android kernel 4.19.

OK. ISTR Hikey 960 had quite a few problems with idle states recently.
At some point it was so horribly broken that you could get something
like a 3x perf bonus in Jankbench _and_ save energy by just disabling
all idles states no ? I haven't been following closely but have these
issues been resolved ?

In any cases, your results seem to go in the right direction, and that's
not a blocker to go on with the review so :-)

> 
> The used percentile is the 95%, the tests are jankbench list_view and
> edit_text, and exoplayer. Values are normalized against the menu governor:
> 
> list_view:
>  frame duration -35%
>  count: +20%
>  energy: +1%
> 
> edit text:
>  frame duration -45%
>  count: +27%
>  energy: -0.3%
> 
> For audio and video playback, there is no frame drop.
> 
> audio
>  - energy: -2.8%
> 
> video
>  - energy: -3.8%
> 
> These are preliminary results.

Thanks for the details. Assuming the board support isn't too broken,
these look pretty good.

Cheers,
Quentin
