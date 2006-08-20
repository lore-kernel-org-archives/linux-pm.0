From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 20 Aug 2006 08:36:53 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50735FAD1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> =

>                 Oppoint could replace large pieces of the cpufreq code
>         in the kernel, most notably the policy and governor code,
which I
>         believe belongs in user space in the power manager daemon.

I've not actually looked a CPUFreq implementation to know how all this
maps...

In general policy is better in user space and depending on your system
it might all live there.

However, when response time counts, it can be necessary to have a level
of algorithm be executed in kernel space.  Some might associate this
level with policy.

Cpufreq has both user and kernel space governess.  For sure the choice
of what govner to use, in which context it executes, and tracking of its
performance likely would be easiest in user space.

Regards,
Richard W.  =
