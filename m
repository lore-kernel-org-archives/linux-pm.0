From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: fix governor start/stop race condition
Date: Wed, 12 Jun 2013 14:14:43 +0530
Message-ID: <CAKohpomigrHOQ-FhuDZTTL3oBQjTDS1w9tK0PwbS6x=Op8=yTg@mail.gmail.com>
References: <1371021986-20985-1-git-send-email-chenxg@marvell.com>
	<CAKohpok2AEe3bL=mPAoxbenEBaWU=WjkRckbvcnzjnUwFZgnuA@mail.gmail.com>
	<CAFgnuDcs7AC7ZmF0xjCYsfj8R_X_cvhNR4V+bduPNhjHR3KQpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDcs7AC7ZmF0xjCYsfj8R_X_cvhNR4V+bduPNhjHR3KQpQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com
List-Id: linux-pm@vger.kernel.org

On 12 June 2013 14:13, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> I thought about return one error code before. but I checked the code
> and found that
> most of the governor stop/start operations don't check the return
> value. I can add error code
> here, I think the checking of return value is also needed. May be
> another patch can do this.

Yeah.
