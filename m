From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
 params
Date: Thu, 12 Jan 2012 20:37:18 -0800
Message-ID: <20120113043718.GA6004@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<CAORVsuUgL=5N1s7j3mHTzVgpq5sFO5nkotAZ1PeC=s0GfkWGwA@mail.gmail.com>
	<87r4z6d784.fsf@amiettinen-lnx.nvidia.com>
	<201201120000.17044.rjw@sisk.pl>
	<87ehv5cnui.fsf@amiettinen-lnx.nvidia.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ehv5cnui.fsf@amiettinen-lnx.nvidia.com>
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

On Thu, Jan 12, 2012 at 10:43:49AM +0200, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > On Wednesday, January 11, 2012, Antti P Miettinen wrote:
> >> I think for CPU performance, it's probably simplest just to use
> >> frequency. Mapping from GOPS/MIPS/FLOPS/FPS is probably more sensily
> >> done by PM QoS client side.
> >
> > Well, unfortunately, frequency is kind of system-specific.  I mean,
> > you need to know what frequencies are supported/available to use that,
> > so it would require the potential users to know the CPU internals.
> >
> > Thanks,
> > Rafael
> 
> I would expect clients requesting for computing performance to require
> system specific knowledge anyway. Computing performance is often
> affected by target specific details (CPU, memory, interconnects). So
> something like board specific configuration parameters would probably be
> required for the PM QoS clients doing computing performance requests.
>
Also, one doesn't have to know the exact number to use the throughput
parameter.  If one value was not enough (i.e. you are missing
deadlines) the increase it until things stabilize.

In practice I doubt any of these qos parameter can be portable.  I
once thought of using units of bogomips for cpu throughput but, thats
just as un-portable as frequency.  Things will end up having to be
tuned or use some training algorithm.

--mark
