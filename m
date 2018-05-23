From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH RFC] schedutil: Address the r/w ordering race in kthread
Date: Tue, 22 May 2018 17:18:08 -0700
Message-ID: <20180523001808.GC55359@joelaf.mtv.corp.google.com>
References: <20180522235028.80564-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522235028.80564-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>, claudio@evidence.eu.com, kernel-team@android.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 22, 2018 at 04:50:28PM -0700, Joel Fernandes (Google) wrote:
> Currently there is a race in schedutil code for slow-switch single-CPU
> systems. Fix it by enforcing ordering the write to work_in_progress to
> happen before the read of next_freq.

Aargh, s/before/after/.

Commit log has above issue but code is Ok. Should I resend this patch or
are there any additional comments? thanks!

 - Joel

[..] 
