From: Christian Krafft <KRAFFT@de.ibm.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 17:03:37 +0200
Message-ID: <OFA7E6B091.1D546AFE-ONC12571B7.0050AA2C-422571B7.0052603A@de.ibm.com>
References: <083b1ba275390c298727816bc51f21b4@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <083b1ba275390c298727816bc51f21b4@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


Matthew Locke <matt@nomadgs.com> wrote on 07/26/2006 09:44:52 AM:

> btw, we are in complete agreement about using named points.  This first
> set of patches is meant to introduce the operating point concept into
> the kernel without requiring massive changes to cpufreq.  This layer
> extends the bottom part of cpufreq to enable the control of multiple
> parameters beyond just cpu frequency and voltage across architectures.
> Currently, cpufreq does not use named operating points so we need to
> make sure cpufreq can use the power op API and continue to function.
> This topic also ties into our other email discussion on creating op
> points and names are assigned to op points.

Hi,

Maybe I missed those discussions about extending cpufreq with other
attributes.
On what list has it been posted ?

I am working on a throttling module and would like to implement it as a
cpufreq driver.
Also closer integration of the on-demand governor and the cpu scheduler
(and hopefully thermal control) would be nice.
This governor uses aged information to control cpus, whereas the scheduler
knows the future.
Thermal control could hint the scheduler, before a cpu gets too hot and
throttled down.
Are there any ideas floating around ?
