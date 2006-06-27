From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: PowerPC cpufreq using ICTC
Date: Wed, 28 Jun 2006 00:14:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0606280011120.5592@poirot.grange>
References: <023301c699f9$d3e0a860$99dfdfdf@bakuhatsu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <023301c699f9$d3e0a860$99dfdfdf@bakuhatsu.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 27 Jun 2006, Matt Sealey wrote:

> I am investigating more generic power management (cpufreq) for PowerPC, b=
oth
> in terms of DFS and the G3 dual-PLL feature (which is already implemented=
 in
> the PowerMac driver) and also using the G3/G4 "ICTC" register which stalls
> the instruction fetch for 1-255 clocks in order to allow the execution un=
its to
> go into dynamic power management (when DPM is enabled). This should, by a=
ll
> documentation, reduce the power consumption of the CPU.

Hm, I thought about replying to this thread writing something like "I'd =

like to co-operate by implementing CPU_FREQ on G2 / MPC824x", but then, =

looking at datasheets, it looks like it doesn't support any frequency =

scaling:-( So, out of luck here... Or have I overseen anything?

Thanks
Guennadi
---
Guennadi Liakhovetski
