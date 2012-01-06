From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 3/6] cpufreq: Export user_policy min/max
Date: Fri, 06 Jan 2012 21:29:26 +0200 (EET)
Message-ID: <20120106.212926.720061341805749024.apm@brigitte.kvy.fi>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-4-git-send-email-amiettinen@nvidia.com>
	<20120106153320.GF12530@mgross-G62>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

[seems that posting via gmane is broken - resenting manually via mail
- sorry if you get duplicates]

mark gross <markgross@thegnar.org> writes:
> Why do you need to export these values here and from the pmqos ABI?
>
> I don't think we want this change.  Also, isn't it redundant WRT
> existing CPU freq govoner sysfs output?
>
> --mark

Hmm.. what do you mean by pmqos ABI? This is related to patch 4. Nothing
critical, just an addition to be able to see the user_policy min/max in
addition to the policy min/max. It's not redundant, it's an
addition. Might be useful for e.g. tests.

	--Antti

> On Fri, Jan 06, 2012 at 02:36:23AM +0200, Antti P Miettinen wrote:
>> Add sysfs nodes for user_policy min and max settings.
>> 
>> Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
>> ---
>>  drivers/cpufreq/cpufreq.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
