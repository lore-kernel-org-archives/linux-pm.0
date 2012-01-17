From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Tue, 17 Jan 2012 11:54:47 +0200
Message-ID: <87mx9mr6vs.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201162238.57556.rjw@sisk.pl>
	<87r4yyrh2e.fsf@amiettinen-lnx.nvidia.com>
	<810586B7581CC8469141DADEBC37191204112D@BGSMSX102.gar.corp.intel.com>
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
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Mansoor, Illyas" <illyas.mansoor@intel.com> writes:
> How about a notion of platform agnostic freq metric that can then me
> normalized to The platform available freq's like for example a value
> 100 that denotes top freq, that Way PM QoS can then ajust the
> application requested number to platform available Freq.

That will not necessarily help the PM QoS client in choosing the
appropriate performance level. On one platform the appropriate level for
a given situation might be 5% of max, on another 75%. I think the hairy
issue is that there are so many application oriented performance metrics
(MIPS, FLOPS, FPS, milliseconds..).

	--Antti
