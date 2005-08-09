From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PowerOP 0/3: System power operating point management
	API
Date: Tue, 9 Aug 2005 11:12:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76388639817161841=="
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

--===============76388639817161841==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 8 Aug 2005, Todd Poynor wrote:

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

What do those higher layers look like? Do you have a userspace component
that uses this interface?

Who is using this code? Are there vendors that are already shipping
systems with this enabled?

Is this part of the DPM project? If so, what other components are left in
DPM?

What are your plans to integrate this more with the cpufreq code?

Thanks,


	Pat


--===============76388639817161841==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76388639817161841==--
