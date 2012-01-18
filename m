From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Wed, 18 Jan 2012 22:22:06 +0200
Message-ID: <87aa5krcb5.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<20120118034406.GD27153@mgross-G62>
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

mark gross <markgross@thegnar.org> writes:
> Would it be possible for you to split this set up where you only have
> the cpu_min_freq enabling in pos.c and cpufreq and make the rest of the
> set a separate patch set?

Would that be patches 1-5 vs the rest?

> As you have it currently the parts I care about are intermixed with
> controversial things (max freq and the new cpufreq exports).

I think the cpufreq changes, patches 3-5, are necessary. Well, patch 3
is not necessary for functionality but would be helpful for
debugging/diagnosis and IMHO makes sense as a companion to patch 4. The
max freq is in patches 7 and 8.

> Also could you make the entire set git am friendly?  Only the first
> patch am's the reset don't.

Could you help me reproduce the problem? For me the mails apply fine.
Also a colleague tested them and encountered no problems. When I know
how to fix the set I'll post a split version.

	--Antti
