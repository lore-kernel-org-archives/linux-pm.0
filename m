From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 18:12:55 +0530
Message-ID: <CAKohponBPtU4HoUGd4dApZkH06kNe+Vu_fBFEtT==oO_81LmWw@mail.gmail.com>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
	<53BE75EE.6010200@mit.edu>
	<CAKohpokb3S3czYB46JsDYggYBYi34CmRhjNGVJDO3wtLV7xGzQ@mail.gmail.com>
	<53BE776A.6060401@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <53BE776A.6060401@mit.edu>
Sender: stable-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa@mit.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Saravana Kannan <skannan@codeaurora.org>, "Bu, Yitian" <ybu@qti.qualcomm.com>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10 July 2014 16:52, Srivatsa S. Bhat <srivatsa@mit.edu> wrote:
> I know.. That's why it makes even more sense to consolidate all the
> work into one function. We can restructure cpufreq_nominate_new_policy_cpu()
> such that the kobject_move() can be moved to update_policy_cpu().

Done.
