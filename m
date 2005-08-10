From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 0/3: System power operating point management
	API
Date: Wed, 10 Aug 2005 12:07:18 +0200
Message-ID: <20050810100718.GC1945@elf.ucw.cz>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20276334729866763=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
List-Id: linux-pm@vger.kernel.org

--===============20276334729866763==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> PowerOP is a system power parameter management API submitted for
> discussion.  PowerOP writes and reads power "operating points",
> comprised of arbitrary integer-valued values, called power parameters,
> that correspond to registers, clocks, dividers, voltage regulators,
> etc. that may be modified to set a basic power/performance point for the
> system.  The core basically passes an array of integer-valued power
> parameters (with very little additional structure imposed by the core)
> to a platform-specific backend that interprets those values and makes
> the requested adjustments.  PowerOP is intended to leave all power
> policy decisions to higher layers.  An optional sysfs representation of
> power parameters is also available, primarily for diagnostic use.
> 
> PowerOP can be thought of as a layer below cpufreq that actually
> accesses the hardware to make cpu frequency, voltage, core bus, and
> perhaps other modifications to set a power point, leaving cpufreq to
> manage the interfaces based around the "cpu frequency" abstraction, the
> policies and governors that select the frequency, its notifiers, and so
> forth.  An example hooking up support for one cpufreq platform to
> PowerOP is in patch 3/3.
> 
> Depending on the ability of the hardware to make software-controlled
> power/performance adjustments, this may be useful to select custom
> voltages, bus speeds, etc. in desktop/server systems.  Various embedded
> systems have several parameters that can be set.  For example, an XScale
> PXA27x could be considered to have six basic power parameters (mainly
> cpu run mode and memory and bus dividers) that for the most part
> should

This scares me a bit. Is table enough to handle this? I'm afraid that
table will get very large on systems that allow you to do "almost
anything".
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

--===============20276334729866763==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20276334729866763==--
