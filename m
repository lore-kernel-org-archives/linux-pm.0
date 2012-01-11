From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Thu, 12 Jan 2012 00:00:16 +0100
Message-ID: <201201120000.17044.rjw@sisk.pl>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<CAORVsuUgL=5N1s7j3mHTzVgpq5sFO5nkotAZ1PeC=s0GfkWGwA@mail.gmail.com>
	<87r4z6d784.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87r4z6d784.fsf@amiettinen-lnx.nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 11, 2012, Antti P Miettinen wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
> > There are case where the constraints values should be additive. The
> > best example is the main memory throughput and so the memory
> > controller frequency (or the L3 frequency on OMAP). The main problem
> > is to estimate the overhead of multiple simultaneous transfers.
> >
> > What do you think?
> 
> This is a valid point. What tree/branch should I look at for the OMAP L3
> PM QoS?
> 
> I think for CPU performance, it's probably simplest just to use
> frequency. Mapping from GOPS/MIPS/FLOPS/FPS is probably more sensily
> done by PM QoS client side.

Well, unfortunately, frequency is kind of system-specific.  I mean,
you need to know what frequencies are supported/available to use that,
so it would require the potential users to know the CPU internals.

Thanks,
Rafael
