From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
Date: Tue, 17 Jul 2018 11:06:29 +0200
Message-ID: <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com> <20180717085039.kqxwbkgruhj5qxtx@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717085039.kqxwbkgruhj5qxtx@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:

[cut]

>
> On balance before this commit users could use pcc-cpufreq but had
> already suboptimal performance (compared to say intel_pstate driver
> which can be used changing BIOS options).

BTW, I wonder why you need to change the BIOS options for intel_pstate to load.

It should be initialized before pcc-cpufreq (according to their
respective initcall levels), so in theory intel_pstate should be used
by default on the affected systems anyway.

What BIOS settings need to be changed for that?
