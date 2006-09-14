From: Matthew Locke <matt@nomadgs.com>
Subject: PowerOP summary
Date: Thu, 14 Sep 2006 01:28:25 -0700
Message-ID: <330177f4f8f83d0d39034c8f05d4b1f7@nomadgs.com>
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
To: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

As a result of some discussion during the Linux PM summit between =

myself, Todd Poynor, Dominik Brodowski, Mark Gross, Amit Kucheria and a =

few others,  Eugeny and I have been working on getting a power =

management interface called PowerOP accepted.   A good bit of =

discussion has occurred on linux-pm over the last couple months about =

PowerOP interfaces and why its needed.  Here is a short summary =

requested by Greg:

Summary
PowerOP is an interface to create and select operating points.  =

Operating points are a collection of platform specific system =

parameters (ie not i/o devices) that affect power consumption.  These =

parameters include cpu frequency, voltages, clock sources and dividers =

and others.  PowerOP provides a platform independent interface to =

control these platform specific parameters.   This interface is a basic =

building block of a power management stack for advanced power =

management on embedded mobile devices.  For those familiar with =

cpufreq, it can be viewed as a redesign of the cpufreq_driver layer to =

be platform independent and enable more advanced governors and policies =

on hardware with lots of power parameters.

Developers
Matthew Locke and Eugeny Mints are the main guys behind PowerOP now but =

many have contributed to get to this point.

A few key points
- PowerOP does not replace cpufreq
- PowerOP authors and advocates are not suggesting to replace cpufreq
- PowerOP is required for doing power management on embedded mobile =

devices
- PowerOP patches are standalone and do not require integration with =

cpufreq or suspend/resume subsystems
- PowerOP does not break anything including existing userspace =

interface and centrino code.

We will resend the patches again for review and discussion.  Each patch =

contains more detailed description.


Matt and Eugeny
