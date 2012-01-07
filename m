From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 3/6] cpufreq: Export user_policy min/max
Date: Fri, 6 Jan 2012 19:53:28 -0800
Message-ID: <20120107035328.GC3119@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-4-git-send-email-amiettinen@nvidia.com>
	<20120106153320.GF12530@mgross-G62>
	<20120106.212926.720061341805749024.apm@brigitte.kvy.fi>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120106.212926.720061341805749024.apm@brigitte.kvy.fi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ananaza@iki.fi
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2012 at 09:29:26PM +0200, Antti P Miettinen wrote:
> [seems that posting via gmane is broken - resenting manually via mail
> - sorry if you get duplicates]
> 
> mark gross <markgross@thegnar.org> writes:
> > Why do you need to export these values here and from the pmqos ABI?
> >
> > I don't think we want this change.  Also, isn't it redundant WRT
> > existing CPU freq govoner sysfs output?
> >
> > --mark
> 
> Hmm.. what do you mean by pmqos ABI? This is related to patch 4. Nothing
> critical, just an addition to be able to see the user_policy min/max in
> addition to the policy min/max. It's not redundant, it's an
> addition. Might be useful for e.g. tests.
Maybe I'm missing something but cpufreq already has ABI for setting
upper and lower bounds for frequencies.

/sys/devices/system/cpu/cpu0/cpufreq/[scaling_min_freq,
scaling_max_freq]

--mark
