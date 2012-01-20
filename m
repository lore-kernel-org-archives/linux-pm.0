From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH] input: CPU frequency booster
Date: Fri, 20 Jan 2012 10:36:57 +0200
Message-ID: <87r4yu22ja.fsf@amiettinen-lnx.nvidia.com>
References: <1326977615-4387-1-git-send-email-amiettinen@nvidia.com>
	<201201192353.00761.trenn@suse.de>
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

Thomas Renninger <trenn@suse.de> writes:
> I can't see why pm_qos is needed at all, better use cpufreq
> providing interface.

One reason for using PM QoS is that it provides an interface for user
space. We want to be able to control frequency also from user space.

	--Antti
