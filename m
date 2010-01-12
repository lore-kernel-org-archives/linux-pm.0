From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Query: CPU Freq Framework
Date: Tue, 12 Jan 2010 19:50:37 +0100
Message-ID: <20100112185037.GA5000@comet.dominikbrodowski.net>
References: <9841a0471001112244g24d732f7t73ec1a25d59bf430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9841a0471001112244g24d732f7t73ec1a25d59bf430@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Deepak Sikri <deepak.sikri79@gmail.com>
Cc: armando.visconti@st.com, shiraz.hashim@st.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hey,

On Tue, Jan 12, 2010 at 12:14:29PM +0530, Deepak Sikri wrote:
> The System timer (Clock Source & ClockEvent) for our board is sharing the
> clock with CPU.On changing the CPU frequency using the CPU freq governors,
> we are changing the clock being fed to CPU and timers. This is affecting the
> kernel time keeping as the timer frequecy has been changed. What is the
> mechanism for managing this through the CPU freq/some other Linux Framework
> ?

The CPUfreq framework offers CPU transition notifiers for exactly this
purpose. See e.g. this snippet from arch/x86/kernel/tsc.c:

	...
        cpufreq_register_notifier(&time_cpufreq_notifier_block,
                                CPUFREQ_TRANSITION_NOTIFIER);
	...

static struct notifier_block time_cpufreq_notifier_block = {
        .notifier_call  = time_cpufreq_notifier
};

	...

static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
                                void *data)
{
	...

        if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
                        (val == CPUFREQ_POSTCHANGE && freq->old > freq->new) ||
                        (val == CPUFREQ_RESUMECHANGE)) {
                *lpj = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);

                tsc_khz = cpufreq_scale(tsc_khz_ref, ref_freq, freq->new);
		...
        }
	...
}

Hope this helps.

Best,
	Dominik
