From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Sun, 22 Jan 2012 11:55:47 +0200
Message-ID: <87hazof4d8.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201190024.27022.rjw@sisk.pl>
	<871uqwqja2.fsf@amiettinen-lnx.nvidia.com>
	<201201192340.24503.rjw@sisk.pl>
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

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> Well, while it might be easier, the _whole_ _point_ of governors is to make
> decisions on the basis of available data.  By introducing an independent
> mechanism for that we're bypassing governors in a sense.

I see this as modular design: governor defines the overall CPU frequency
control policy and PM QoS defines constraints. I think those things can
and probably should be somewhat independent.

	--Antti
