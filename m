From: Paul Mackerras <paulus@samba.org>
Subject: Re: PowerPC cpufreq using ICTC
Date: Thu, 29 Jun 2006 15:50:35 +1000
Message-ID: <17571.27179.106239.531807@cargo.ozlabs.ibm.com>
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
To: matt@genesi-usa.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Matt Sealey writes:

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

But does it reduce the energy consumed per instruction executed, or
increase it?  I would expect that you wouldn't see any improvement in
energy per instruction unless you can reduce the CPU core Vdd voltage.
If you can't reduce the energy per instruction then you might as well
"race to idle", which is effectively what we do currently.

Paul.
