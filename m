From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] fix some problems for cpufreq
Date: Tue, 2 Dec 2014 10:08:24 +0530
Message-ID: <CAKohpomMWj8QRW5eYdTGXT+HEZpSA6AV5C6mUzYyC1N1fWV7vg@mail.gmail.com>
References: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
	<2248504.pAVebap2qN@vostro.rjw.lan>
	<547923F2.6000701@huawei.com>
	<4004530.x5fm24OG42@vostro.rjw.lan>
	<547AD41F.7030907@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547AD41F.7030907@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Weidong <wangweidong1@huawei.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

On 30 November 2014 at 13:53, Wang Weidong <wangweidong1@huawei.com> wrote:
> No, there are not utilities and scripts relying on it.

How can you be so sure about it ? There might be scripts/utils you
aren't aware of
and are depending on this..

> I just confuse that:
> If the policy->min and policy-max is changed while it shows all available freqs
> though scaling_available_frequencies. I can't set all freq-steps, only [policy->min, policy->max].
> why should it show all the available freqs.

That's not the only purpose of those frequencies there. It shows list
of all possible
frequencies. Now, there can be issues if those lists are updated.

Suppose somebody just played with the min/max frequency, now how would anybody
come to know about the frequencies available above/below the
user-max/min frequency?

So as you mentioned in your example above: User space would never know about

1.05 Ghz and 2.3GHz anymore.. Unless you remember it or save it somewhere.

> Although, it doesn't impact on us. So just ignore the patch#2. :)

Probably yes.
