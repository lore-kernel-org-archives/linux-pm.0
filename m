From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/4] PM / devfreq: Fix the wrong description for
 userspace governor
Date: Mon, 30 Jan 2017 11:44:42 +0100
Message-ID: <CAJZ5v0iVf1stbyaHJWr_QWi7tt8P7L1zpfP23p5N=QKgHamV8Q@mail.gmail.com>
References: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170123033151epcas5p3a484d70bbdef282b92eb8d97d912e75c@epcas5p3.samsung.com>
 <20170124034211epcms1p6ded0f600506896af5bdf09e9afd6eb94@epcms1p6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124034211epcms1p6ded0f600506896af5bdf09e9afd6eb94@epcms1p6>
Sender: linux-kernel-owner@vger.kernel.org
To: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 24, 2017 at 4:42 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> This patch fixes the wrong description of governor_userspace.c
>> and removes the unneeded blank line.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>
> Applied in for-next


Quite frankly I'm not entirely sure what's going on in the devfreq land.

Some patches are ACKed by you, some of them are applied and it is hard
to say what the rule is.

Besides, it is quite late in the cycle, so it would be nice to receive
a pull request for the devfreq material already collected for 4.11.

Thanks,
Rafael
