From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and Tegra20/30
 support
Date: Fri, 3 May 2019 03:52:50 +0300
Message-ID: <fa061a65-f108-6c5e-1f87-950a9a8caafc@gmail.com>
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
 <20190501233815.32643-1-digetx@gmail.com>
 <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

03.05.2019 3:31, Chanwoo Choi пишет:
> Hi Dmitry,
> 
> On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
>> Changelog:
>>
>> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
>>
>>     - changed the driver removal order to match the probe exactly
>>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
>>
>>     Chanwoo, please also note that the clk patch that should fix
>>     compilation problem that was reported the kbuild-test-robot is already
>>     applied and available in the recent linux-next.
> 
> I knew that Stephen picked up your path about clock.

Hi Chanwoo,

Okay, good. Thank you very much for reviewing this series! I assume it's
too late now for v5.2, but it should be good to go for v5.3.
