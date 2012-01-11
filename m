From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Wed, 11 Jan 2012 09:32:59 +0200
Message-ID: <87r4z6d784.fsf@amiettinen-lnx.nvidia.com>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201092227.29857.rjw@sisk.pl> <20120110045042.GA14968@mgross-G62>
	<201201102146.23001.rjw@sisk.pl>
	<CAORVsuUgL=5N1s7j3mHTzVgpq5sFO5nkotAZ1PeC=s0GfkWGwA@mail.gmail.com>
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

Jean Pihet <jean.pihet@newoldbits.com> writes:
> There are case where the constraints values should be additive. The
> best example is the main memory throughput and so the memory
> controller frequency (or the L3 frequency on OMAP). The main problem
> is to estimate the overhead of multiple simultaneous transfers.
>
> What do you think?

This is a valid point. What tree/branch should I look at for the OMAP L3
PM QoS?

I think for CPU performance, it's probably simplest just to use
frequency. Mapping from GOPS/MIPS/FLOPS/FPS is probably more sensily
done by PM QoS client side.

	--Antti
