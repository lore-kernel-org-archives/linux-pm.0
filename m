From: Matthew Locke <matthew.a.locke@comcast.net>
Subject: PowerOP vs OPpoint
Date: Thu, 14 Sep 2006 02:22:25 -0700
Message-ID: <ff355e0e9a7ba8350241ffe483c664ab@comcast.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pm list <linux-pm@lists.osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Unfortunately, there are two efforts underway that makes this confusing =

and I think require a bit more than the short summary requested.  A one =

paragraph summary can't address the why and how.  This email briefly =

describes the why and the differences.

There are two main reasons for both these efforts:
- existing power management interfaces do not enable the power =

management features on the latest SOC's used in embedded mobile  =

devices
- existing power management interfaces do not provide the API necessary =

to build power managers (userspace and/or kernel space) that optimize =

power consumption to level required by embedded mobile devices

PowerOP
Focus is on a platform independent interface for selecting and creating =

operating points.  We want to get the basic power management block in =

place and build on it.  Integrating with other existing power =

management interfaces as it makes sense.  The first natural integration =

point is the cpufreq_driver layer in cpufreq and does not affect the =

userspace interface.

OPpoint
Goal is to show how all existing interfaces can use the operating point =

concept.  It is more than an interface for selecting and creating =

operating points.  It integrates with cpufreq and sleep states defining =

new userspace interfaces and using existing interfaces in different =

ways.  There are a lot of issues with the OPpoint operating point =

interface that was discussed here: =

http://lists.osdl.org/pipermail/linux-pm/2006-August/003541.html .  =

Many objections to the sleep state integration.  Most of the negative =

comments about cpufreq are about the OPpoint patches.

I have not seen or heard any justification for the OPpoint patches to =

create a different operating point interface.

Matt
