From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Date: Tue, 22 May 2018 16:24:29 +0530
Message-ID: <20180522105429.yn2omuz63oa2w3ez@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
 <20180522105006.hvntwnhzzvhznij2@vireshk-i7>
 <4393838.cQWhzXzUcj@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4393838.cQWhzXzUcj@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>, linux-kernel@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>, claudio@evidence.eu.com, kernel-team@android.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-05-18, 12:50, Rafael J. Wysocki wrote:
> Ugly indeed.

Hehe. I was thinking, maybe we can write wrapper helpers around lock/unlock
which are stored as pointers in sg_policy. So that those are only set to
non-NULL values (or non-Noop routines) for slow-switching single policy or
any-switching shared policy systems. Then we can get rid of such conditional
locking attempts :)

-- 
viresh
