From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Wed, 13 Aug 2014 15:45:33 +0300
Message-ID: <23471357.28K1EPJDR0@spock>
References: <4708675.eITUXPv8Ih@spock> <CAKohpomF9QLLG-6evXWeUvrR9k7Y8ypVNdXyE4cAi=EFOQviHQ@mail.gmail.com> <22004375.5nGJFy1vsr@spock>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22004375.5nGJFy1vsr@spock>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Also I've found similar oops report with upstreamed fix (commit 
46a310b80bc2c9ccc019649c9da91194cbc10944).

On Wednesday 13 August 2014 08:56:02 Oleksandr Natalenko wrote:
> On Wednesday 13 August 2014 10:02:26 Viresh Kumar wrote:
> > That's why you should have copied the diff here, so that I could have
> > confirmed if what you have done is correct or not.
> 
> You may check my modifications here [1] or attached to this email.
> 
> [1] https://gist.github.com/bdcc7d41883b5e077974
-- 
Oleksandr post-factum Natalenko, MSc
pf-kernel community
https://natalenko.name/
